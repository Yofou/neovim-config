--  vim.g.lightline = { colorscheme = "oldworld" }
vim.o.termguicolors = true

require('colorizer').setup()
require('oldworld').setup ({
  --  variant = "cooler"
})
require('vesper').setup ({
  --  variant = "cooler"
})

vim.cmd.colorscheme("vesper")

local colors = require('oldworld.palette')

local modecolor = {
    n = colors.red,
    i = colors.cyan,
    v = colors.purple,
    [""] = colors.purple,
    V = colors.red,
    c = colors.yellow,
    no = colors.red,
    s = colors.yellow,
    S = colors.yellow,
    [""] = colors.yellow,
    ic = colors.yellow,
    R = colors.green,
    Rv = colors.purple,
    cv = colors.red,
    ce = colors.red,
    r = colors.cyan,
    rm = colors.cyan,
    ["r?"] = colors.cyan,
    ["!"] = colors.red,
    t = colors.bright_red,
}

local theme = {
    normal = {
        a = { fg = colors.bg_dark, bg = colors.blue },
        b = { fg = colors.blue, bg = colors.white },
        c = { fg = colors.white, bg = colors.bg_dark },
        z = { fg = colors.white, bg = colors.bg_dark },
    },
    insert = { a = { fg = colors.bg_dark, bg = colors.orange } },
    visual = { a = { fg = colors.bg_dark, bg = colors.green } },
    replace = { a = { fg = colors.bg_dark, bg = colors.green } },
}

local space = {
    function()
        return " "
    end,
    color = { bg = colors.bg_dark, fg = colors.blue },
}

local filename = {
    "filename",
    color = { bg = colors.blue, fg = colors.bg, gui = "bold" },
    separator = { left = "", right = "" },
}

local filetype = {
    "filetype",
    icons_enabled = false,
    color = { bg = colors.gray2, fg = colors.blue, gui = "italic,bold" },
    separator = { left = "", right = "" },
}

local branch = {
    "branch",
    icon = "",
    color = { bg = colors.green, fg = colors.bg, gui = "bold" },
    separator = { left = "", right = "" },
}

local location = {
    "location",
    color = { bg = colors.yellow, fg = colors.bg, gui = "bold" },
    separator = { left = "", right = "" },
}

local diff = {
    "diff",
    color = { bg = colors.gray2, fg = colors.bg, gui = "bold" },
    separator = { left = "", right = "" },
    symbols = { added = " ", modified = " ", removed = " " },

    diff_color = {
        added = { fg = colors.green },
        modified = { fg = colors.yellow },
        removed = { fg = colors.red },
    },
}

local modes = {
    "mode",
    color = function()
        local mode_color = modecolor
        return { bg = mode_color[vim.fn.mode()], fg = colors.bg_dark, gui = "bold" }
    end,
    separator = { left = "", right = "" },
}

local function getLspName()
    local buf_clients = vim.lsp.get_clients()()
    local buf_ft = vim.bo.filetype
    if next(buf_clients) == nil then
        return "  No servers"
    end
    local buf_client_names = {}

    for _, client in pairs(buf_clients) do
        if client.name ~= "none-ls" then
            table.insert(buf_client_names, client.name)
        end
    end

    local lint_s, lint = pcall(require, "lint")
    if lint_s then
        for ft_k, ft_v in pairs(lint.linters_by_ft) do
            if type(ft_v) == "table" then
                for _, linter in ipairs(ft_v) do
                    if buf_ft == ft_k then
                        table.insert(buf_client_names, linter)
                    end
                end
            elseif type(ft_v) == "string" then
                if buf_ft == ft_k then
                    table.insert(buf_client_names, ft_v)
                end
            end
        end
    end

    local ok, conform = pcall(require, "conform")
    local formatters = table.concat(conform.list_formatters_for_buffer(), " ")
    if ok then
        for formatter in formatters:gmatch("%w+") do
            if formatter then
                table.insert(buf_client_names, formatter)
            end
        end
    end

    local hash = {}
    local unique_client_names = {}

    for _, v in ipairs(buf_client_names) do
        if not hash[v] then
            unique_client_names[#unique_client_names + 1] = v
            hash[v] = true
        end
    end
    local language_servers = table.concat(unique_client_names, ", ")

    return "  " .. language_servers
end

local dia = {
    "diagnostics",
    sources = { "nvim_diagnostic" },
    symbols = { error = " ", warn = " ", info = " ", hint = " " },
    diagnostics_color = {
        error = { fg = colors.red },
        warn = { fg = colors.yellow },
        info = { fg = colors.purple },
        hint = { fg = colors.cyan },
    },
    color = { bg = colors.gray2, fg = colors.blue, gui = "bold" },
    separator = { left = "" },
}

local lsp = {
    function()
        return getLspName()
    end,
    separator = { left = "", right = "" },
    color = { bg = colors.purple, fg = colors.bg, gui = "italic,bold" },
}

require("lualine").setup({
    options = {
        icons_enabled = true,
        theme = theme,
        component_separators = { left = "", right = "" },
        section_separators = { left = "", right = "" },
        disabled_filetypes = {
            statusline = {},
            winbar = {},
        },
        ignore_focus = {},
        always_divide_middle = true,
        globalstatus = true,
    },

    sections = {
        lualine_a = {
            modes,
        },
        lualine_b = {
            space,
        },
        lualine_c = {
            filename,
            filetype,
            space,
            branch,
            diff,
            space,
            location,
        },
        lualine_x = {
            space,
        },
        lualine_y = { space },
        lualine_z = {
            dia,
            lsp,
        },
    },
    inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { "filename" },
        lualine_x = { "location" },
        lualine_y = {},
        lualine_z = {},
    },
})

-- Vesper-themed CmpItemKind highlights
-- Pulled from vesper's actual color assignments in init.lua

local v = {
  bg       = "#101010",  -- vesper bg
  primary  = "#ff9940",  -- orange accent (operators, keywords, tags)
  purple   = "#a393eb",  -- functions, methods, constructors, exceptions
  green    = "#5ec46a",  -- strings
  greenL   = "#82e2a6",  -- booleans, properties, labels
  orange   = "#f5a26b",  -- types, @type, @property
  orangeL  = "#ffc799",  -- special chars
  white    = "#ffffff",  -- variables, constants
  symbol   = "#666666",  -- punctuation / misc
  comment  = "#555555",  -- comments
}

vim.api.nvim_set_hl(0, "CmpItemKindFunction",      { fg = v.bg, bg = v.purple })
vim.api.nvim_set_hl(0, "CmpItemKindConstructor",   { fg = v.bg, bg = v.purple })
vim.api.nvim_set_hl(0, "CmpItemKindMethod",        { fg = v.bg, bg = v.purple })
vim.api.nvim_set_hl(0, "CmpItemKindVariable",      { fg = v.bg, bg = v.white })
vim.api.nvim_set_hl(0, "CmpItemKindConstant",      { fg = v.bg, bg = v.white })
vim.api.nvim_set_hl(0, "CmpItemKindField",         { fg = v.bg, bg = v.greenL })
vim.api.nvim_set_hl(0, "CmpItemKindProperty",      { fg = v.bg, bg = v.orange })
vim.api.nvim_set_hl(0, "CmpItemKindEnumMember",    { fg = v.bg, bg = v.greenL })
vim.api.nvim_set_hl(0, "CmpItemKindKeyword",       { fg = v.bg, bg = v.primary })
vim.api.nvim_set_hl(0, "CmpItemKindOperator",      { fg = v.bg, bg = v.primary })
vim.api.nvim_set_hl(0, "CmpItemKindClass",         { fg = v.bg, bg = v.orange })
vim.api.nvim_set_hl(0, "CmpItemKindInterface",     { fg = v.bg, bg = v.orange })
vim.api.nvim_set_hl(0, "CmpItemKindStruct",        { fg = v.bg, bg = v.orange })
vim.api.nvim_set_hl(0, "CmpItemKindModule",        { fg = v.bg, bg = v.orange })
vim.api.nvim_set_hl(0, "CmpItemKindEnum",          { fg = v.bg, bg = v.orange })
vim.api.nvim_set_hl(0, "CmpItemKindTypeParameter", { fg = v.bg, bg = v.orange })
vim.api.nvim_set_hl(0, "CmpItemKindString",        { fg = v.bg, bg = v.green })
vim.api.nvim_set_hl(0, "CmpItemKindText",          { fg = v.bg, bg = v.comment })
vim.api.nvim_set_hl(0, "CmpItemKindSnippet",       { fg = v.bg, bg = v.greenL })
vim.api.nvim_set_hl(0, "CmpItemKindEvent",         { fg = v.bg, bg = v.primary })
vim.api.nvim_set_hl(0, "CmpItemKindUnit",          { fg = v.bg, bg = v.orangeL })
vim.api.nvim_set_hl(0, "CmpItemKindValue",         { fg = v.bg, bg = v.orangeL })
vim.api.nvim_set_hl(0, "CmpItemKindColor",         { fg = v.bg, bg = v.orangeL })
vim.api.nvim_set_hl(0, "CmpItemKindReference",     { fg = v.bg, bg = v.symbol })
vim.api.nvim_set_hl(0, "CmpItemKindFile",          { fg = v.bg, bg = v.symbol })
vim.api.nvim_set_hl(0, "CmpItemKindFolder",        { fg = v.bg, bg = v.symbol })

-- Vivid diff highlights for diffview (vesper ships muted versions)
vim.api.nvim_set_hl(0, "DiffAdd",                  { fg = "#5ec46a", bg = "#1a2e1a" })
vim.api.nvim_set_hl(0, "DiffDelete",               { fg = "#f87171", bg = "#2e1a1a" })
vim.api.nvim_set_hl(0, "DiffChange",               { fg = "#ffc799", bg = "#2e2a1a" })
vim.api.nvim_set_hl(0, "DiffText",                 { fg = "#ffffff", bg = "#4a3a10", bold = true })
vim.api.nvim_set_hl(0, "DiffviewDiffAdd",          { fg = "#5ec46a", bg = "#1a2e1a" })
vim.api.nvim_set_hl(0, "DiffviewDiffDelete",       { fg = "#f87171", bg = "#2e1a1a" })
vim.api.nvim_set_hl(0, "DiffviewDiffChange",       { fg = "#ffc799", bg = "#2e2a1a" })
vim.api.nvim_set_hl(0, "DiffviewDiffText",         { fg = "#ffffff", bg = "#4a3a10", bold = true })
