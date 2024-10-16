vim.api.nvim_create_user_command("T", ":split | term", {})
vim.api.nvim_create_user_command("Comp", function()
    local filename = ".out"
    local comp_cmd = vim.fn.input("Compile command: ")
    local bufe = vim.fn.bufexists(filename)
    local bufnr = vim.fn.bufwinnr(filename)
    if (bufe ~= 0) then
        if (bufnr == -1) then
            vim.cmd('sbuffer '..filename)
            vim.cmd("q!")
        else
            vim.cmd(bufnr.."winc w")
            vim.cmd("q!")
        end
    end
    vim.cmd('new '..filename..' | r ! '..comp_cmd)
end, {})
vim.api.nvim_create_user_command("C", ":Comp", {})
