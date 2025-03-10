local sbar = require("sketchybar")
local colors = require("colors")
local icons = require("icons")
local settings = require("settings")
local app_icons = require("helpers.app_icons")
local aerospace = require("helpers.aerospace")

-- Configuration
local POLL_INTERVAL = 1 -- Polling interval in seconds
local query_workspaces =
"aerospace list-workspaces --all --format '%{workspace}%{monitor-appkit-nsscreen-screens-id}' --json"

-- for i in query_workspaces do
--   local space = sbar.add("space", "space." .. i, {
--     space = i,
--     icon = {
--       font = { family = settings.font.numbers },
--       string = i,
--       padding_left = 15,
--       padding_right = 8,
--       color = colors.white,
--       highlight_color = colors.red,
--     },
--     label = {
--       padding_right = 20,
--       color = colors.grey,
--       highlight_color = colors.white,
--       font = "sketchybar-app-font:Regular:16.0",
--       y_offset = -1,
--     },
--     padding_right = 1,
--     padding_left = 1,
--     background = {
--       color = colors.bg1,
--       border_width = 1,
--       height = 26,
--       border_color = colors.black,
--     },
--     popup = { background = { border_width = 5, border_color = colors.black } },
--   })
--
--   spaces[i] = space

-- Helper function: Trim whitespace from a string
local function trim(s)
  return s:match("^%s*(.-)%s*$")
end

-- Create root item (padding and event container)
local root = sbar.add("item", {
  icon = {
    color = colors.with_alpha(colors.white, 0.3),
    highlight_color = colors.white,
    drawing = false,
  },
  label = {
    color = colors.grey,
    highlight_color = colors.white,
    drawing = false,
  },
  background = {
    color = colors.bg0,
    border_width = 1,
    height = 28,
    border_color = colors.black,
    corner_radius = 9,
    drawing = false,
  },
  padding_left = 6,
  padding_right = 0,
})

local workspaces = {}

-- withWindows: Collect open windows, focused workspace, and visible workspaces data
local function withWindows(callback)
  local open_windows = {}
  local get_windows = "aerospace list-windows --monitor all --format '%{workspace}%{app-name}' --json"
  local query_visible_workspaces =
  "aerospace list-workspaces --visible --monitor all --format '%{workspace}%{monitor-appkit-nsscreen-screens-id}' --json"
  local get_focus_workspace = "aerospace list-workspaces --focused"
  sbar.exec(get_windows, function(windows_data)
    for _, entry in ipairs(windows_data) do
      local workspace_index = entry.workspace
      local app = entry["app-name"]
      if not open_windows[workspace_index] then
        open_windows[workspace_index] = {}
      end
      table.insert(open_windows[workspace_index], app)
    end
    sbar.exec(get_focus_workspace, function(raw_focused)
      local focused_workspace = trim(raw_focused)
      sbar.exec(query_visible_workspaces, function(visible_workspaces)
        local args = {
          open_windows = open_windows,
          focused_workspace = focused_workspace,
          visible_workspaces = visible_workspaces,
        }
        callback(args)
      end)
    end)
  end)
end

-- updateWindow: Build icon string and update a workspace item accordingly
local function updateWindow(workspace_index, args)
  local open_windows = args.open_windows[workspace_index] or {}
  local focused_workspace = args.focused_workspace
  local visible_workspaces = args.visible_workspaces

  local icon_line = ""
  local no_app = true
  for _, app in ipairs(open_windows) do
    no_app = false
    local lookup = app_icons[app]
    local icon = (lookup == nil and app_icons["Default"] or lookup)
    icon_line = icon_line .. " " .. icon
  end

  sbar.animate("tanh", 10, function()
    for _, vis in ipairs(visible_workspaces) do
      if no_app and workspace_index == vis["workspace"] then
        local monitor_id = vis["monitor-appkit-nsscreen-screens-id"]
        icon_line = " —"
        workspaces[workspace_index]:set({
          icon = { drawing = true },
          label = {
            string = icon_line,
            drawing = true,
            font = "sketchybar-app-font:Regular:16.0",
            y_offset = -1,
          },
          background = { drawing = true },
          padding_right = 1,
          padding_left = 1,
          display = monitor_id,
        })
        return
      end
    end

    if no_app and workspace_index ~= focused_workspace then
      workspaces[workspace_index]:set({
        icon = { drawing = false },
        label = { drawing = false },
        background = { drawing = false },
        padding_right = 0,
        padding_left = 0,
      })
      return
    end

    if no_app and workspace_index == focused_workspace then
      icon_line = " —"
      workspaces[workspace_index]:set({
        icon = { drawing = true },
        label = {
          string = icon_line,
          drawing = true,
          font = "sketchybar-app-font:Regular:16.0",
          y_offset = -1,
        },
        background = { drawing = true },
        padding_right = 1,
        padding_left = 1,
      })
      return
    end

    workspaces[workspace_index]:set({
      icon = { drawing = true },
      label = { drawing = true, string = icon_line },
      background = { drawing = true },
      padding_right = 1,
      padding_left = 1,
    })
  end)
end

-- updateWindows: Update every workspace item using current window data
local function updateWindows()
  withWindows(function(args)
    for workspace_index, _ in pairs(workspaces) do
      updateWindow(workspace_index, args)
    end
  end)
end

-- updateWorkspaceMonitor: Update display (monitor) info for each workspace
local function updateWorkspaceMonitor()
  local workspace_monitor = {}
  sbar.exec(query_workspaces, function(workspaces_and_monitors)
    for _, entry in ipairs(workspaces_and_monitors) do
      local space_index = entry.workspace
      local monitor_id = math.floor(entry["monitor-appkit-nsscreen-screens-id"])
      workspace_monitor[space_index] = monitor_id
    end
    for workspace_index, _ in pairs(workspaces) do
      workspaces[workspace_index]:set({
        display = workspace_monitor[workspace_index],
      })
    end
  end)
end

-- Create workspace items from Aerospace query
sbar.exec(query_workspaces, function(workspaces_and_monitors)
  for _, entry in ipairs(workspaces_and_monitors) do
    local workspace_index = entry.workspace

    local workspace = sbar.add("item", {
      icon = {
        color = colors.with_alpha(colors.white, 0.3),
        highlight_color = colors.white,
        drawing = false,
        font = { family = settings.font.numbers },
        string = workspace_index,
        padding_left = 10,
        padding_right = 5,
      },
      label = {
        padding_right = 10,
        color = colors.with_alpha(colors.white, 0.3),
        highlight_color = colors.white,
        font = "sketchybar-app-font:Regular:16.0",
        y_offset = -1,
      },
      padding_right = 2,
      padding_left = 2,
      background = {
        color = colors.bg3,
        border_width = 1,
        height = 28,
        border_color = colors.bg2,
      },
      click_script = "aerospace workspace " .. workspace_index,
    })

    workspaces[workspace_index] = workspace

    -- Subscribe for workspace focus changes
    workspace:subscribe("aerospace_workspace_change", function(env)
      local focused_workspace = env.FOCUSED_WORKSPACE
      local is_focused = focused_workspace == workspace_index
      sbar.animate("tanh", 10, function()
        workspace:set({
          icon = { highlight = is_focused },
          label = { highlight = is_focused },
          background = {
            border_width = is_focused and 2 or 1,
          },
          blur_radius = 30,
        })
      end)
    end)
  end

  -- Initial setup: update workspaces and monitor info
  updateWindows()
  updateWorkspaceMonitor()

  root:subscribe("aerospace_focus_change", function()
    updateWindows()
  end)

  root:subscribe("display_change", function()
    updateWorkspaceMonitor()
    updateWindows()
  end)

  sbar.exec("aerospace list-workspaces --focused", function(focused_workspace)
    local focused_workspace = trim(focused_workspace)
    workspaces[focused_workspace]:set({
      icon = { highlight = true },
      label = { highlight = true },
      background = { border_width = 2 },
    })
  end)
end)

-- Subscribe to aerospace_workspace_change for real-time updates
sbar.subscribe("aerospace_workspace_change", function(env)
  updateWindows()
end)

-- Polling loop: force updates every POLL_INTERVAL seconds
local function pollForUpdates()
  updateWindows()
  updateWorkspaceMonitor()
  sbar.exec("sleep " .. POLL_INTERVAL, function()
    pollForUpdates()
  end)
end

pollForUpdates()
