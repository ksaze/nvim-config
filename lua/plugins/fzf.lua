return {
    "ibhagwan/fzf-lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
        local fzf = require("fzf-lua")
        fzf.setup({
            winopts = {
                height = 0.85,
                width = 0.80,
                row = 0.35,
                col = 0.50,
            },

            files = {
                prompt = "Files> ",
                cmd = "fd --type f --hidden --follow --exclude .git",
            },
        })

        vim.keymap.set("n", "<leader>ff", fzf.files, { desc = "Search files in current directory" })

        vim.keymap.set("n", "<leader>fh", function()
            fzf.files({ cmd = "fd --type f --hidden --follow --exclude .git", cwd = "~" })
        end, { desc = "Search files in home directory" })

        vim.keymap.set("n", "<leader>fp", function()
            fzf.files({ 
                cmd = "fd --type f --hidden --follow --exclude .git", 
                cwd = vim.fn.system("git rev-parse --show-toplevel 2>/dev/null || pwd"):gsub("\n", "")
            })
        end, { desc = "Search files in project root" })


        vim.keymap.set("n", "<leader>fc", function()
            fzf.files({ cmd = "fd --type f --hidden --follow --exclude .git", cwd = "~/.config" })
        end, { desc = "Search files in ~/.config" })

        vim.keymap.set("n", "<leader>fw", function()
            fzf.files({ cmd = "fd --type f --hidden --follow --exclude .git", cwd = "~/workspace" })
        end, { desc = "Search files in ~/workspace" })
    end
}
