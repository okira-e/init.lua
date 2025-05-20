local ls = require("luasnip")
local s = ls.snippet
local i = ls.insert_node
local f = ls.function_node

return {
    s("cslog", {
        f(function()
            local ft = vim.bo.filetype
            if ft == "python" then
                return 'print("'
            elseif ft == "javascript" or ft == "typescript" or ft == "javascriptreact" or ft == "typescriptreact" then
                return 'console.log(`'
            elseif ft == "go" then
                return 'fmt.Println("'
            elseif ft == "rust" then
                return 'println!("'
            elseif ft == "zig" then
                return 'std.debug.print("'
            else
                return 'print("'
            end
        end, {}),
        i(1, ""),
        f(function()
            local ft = vim.bo.filetype
            if ft == "rust" then
                return '{}", );'
            elseif ft == "zig" then
                return '{}\\n, .{});'
            elseif ft == "go" then
                return '")'
            elseif ft == "javascript" or ft == "typescript" or ft == "javascriptreact" or ft == "typescriptreact" then
                return '`);'
            elseif ft == "python" then
                return '")'
            end
        end, {}),
    }),
}
