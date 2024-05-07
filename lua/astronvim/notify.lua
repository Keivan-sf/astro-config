---AstroNvim Notify Utilities
---
---This module implements a pausable `vim.notify` in order to defer notifications on startup as well as allow for freely pausing and resuming of notifications
---
---Based on notification lazy loading in LazyVim
---https://github.com/LazyVim/LazyVim/blob/a50f92f7550fb6e9f21c0852e6cb190e6fcd50f5/lua/lazyvim/util/init.lua#L90-L125
---
---@class astronvim.notify
local M = {}

local notifications, paused = {}, false

--- Check if notifications are paused
---@return boolean # whether or not the notifications are paused
function M.is_paused() return paused end

--- Check now many notifications are pending
---@return integer # the number of pending notifications
function M.num_pending() return #notifications end

--- Pause notifications
function M.pause() paused = true end

--- Resume paused notifications
function M.resume()
  paused = false
  vim.schedule(function()
    vim.tbl_map(function(notif) vim.notify(vim.F.unpack_len(notif)) end, notifications)
    notifications = {}
  end)
end

--- A pausible `vim.notify` function
---@vararg ... the arguments that would be passed to the original `vim.notify` function
function M.notify(...)
  if M.is_paused() then
    table.insert(notifications, vim.F.pack_len(...))
  else
    M._original(...)
  end
end

--- Set `vim.notify` to extend it to be pause-able
function M.set()
  assert(vim.notify ~= M.notify, "vim.notify is already setup")
  M._original = vim.notify
  vim.notify = M.notify
end

--- Remove `astronvim.notify` utilities and restore original `vim.notify`
function M.restore()
  M.notify = M._original
  if M.is_paused() then M.resume() end
end

--- Initial setup for the module that also immediately pauses notifications until either `vim.notify` changes or 500ms passes
function M.lazy_notify()
  M.set()
  M.pause()

  -- defer initially for 500ms or until `vim.notify` changes
  local uv = vim.uv or vim.loop
  local timer, checker = uv.new_timer(), assert(uv.new_check())

  local function replay()
    timer:stop()
    checker:stop()
    M.resume()
  end

  -- wait till vim.notify has been replaced
  checker:start(function()
    if vim.notify ~= M.notify then replay() end
  end)
  -- or if it took more than 500ms, then something went wrong
  timer:start(500, 0, replay)
end

return M
