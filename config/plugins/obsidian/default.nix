{ ... }:

        settings = {
            workspaces = [
            {
                name = "vault";
                path = "~/Vault";
            }
            ];

            log_level = { __raw = "vim.log.levels.INFO"; };

            daily_notes = {
                folder = "Relatorio";
                template = "Relatório.md";
            };

            completion = {
                nvim_cmp = true;
                min_chars = 2;
            };

            new_notes_location = "Notas";

            link = {
                style = "wiki";
            };

            open = {
                func = {
                    __raw = ''
                        function(uri)
                        vim.ui.open(uri)
                        end
                        '';
                };
            };

            templates = {
                folder = "Templates";
                date_format = "%Y-%m-%d";
                time_format = "%Hh%M";
                substitutions = { };
            };

            picker = {
                name = "telescope.nvim";
                note_mappings = {
                    new = "<C-x>";
                    insert_link = "<C-l>";
                };
                tag_mappings = {
                    tag_note = "<C-x>";
                    insert_tag = "<C-l>";
                };
            };

            search = {
                sort_by = "modified";
                sort_reversed = true;
                max_lines = 1000;
            };

            open_notes_in = "current";

            legacy_commands = false;

            callbacks = {
                post_setup = { __raw = "function(client) end"; };
                enter_note = { __raw = "function(client, note) end"; };
                leave_note = { __raw = "function(client, note) end"; };
                pre_write_note = { __raw = "function(client, note) end"; };
                post_set_workspace = { __raw = "function(client, workspace) end"; };
            };

            checkbox = {
                order = [ " " "x" "/" ">" "<" "-" "!" "?" "i" "\"" "S" "*" "$" "n" "#" "b" "l" "t" "L" "p" "c" "u" "d" "r" "T" ];
            };

            ui = {
                enable = true;
                update_debounce = 50;
                max_file_length = 500000;
                checkboxes = {
                    " " = { char = "󰄱"; hl_group = "ObsidianTodo"; };
                    "x" = { char = ""; hl_group = "ObsidianDone"; };
                    "/" = { char = "󰡖"; hl_group = "ObsidianInProgress"; };
                    ">" = { char = ""; hl_group = "ObsidianRightArrow"; };
                    "<" = { char = ""; hl_group = "ObsidianLeftArrow"; };
                    "-" = { char = "󰰱"; hl_group = "ObsidianTilde"; };
                    "!" = { char = ""; hl_group = "ObsidianImportant"; };
                    "?" = { char = ""; hl_group = "ObsidianQuestion"; };
                    "i" = { char = ""; hl_group = "ObsidianInfo"; };
                    "\"" = { char = ""; hl_group = "ObsidianQuote"; };
                    "S" = { char = ""; hl_group = "ObsidianPrice"; };
                    "*" = { char = "󰓏"; hl_group = "ObsidianStar"; };
                    "$" = { char = "󰤱"; hl_group = "ObsidianPinnable"; };
                    "n" = { char = "󰐃"; hl_group = "ObsidianPin"; };
                    "#" = { char = ""; hl_group = "ObsidianBookmarkable"; };
                    "b" = { char = ""; hl_group = "ObsidianBooknark"; };
                    "l" = { char = ""; hl_group = "ObsidianLocation"; };
                    "t" = { char = "󱑀"; hl_group = "ObsidianTime"; };
                    "L" = { char = ""; hl_group = "ObsidianTime"; };
                    "p" = { char = ""; hl_group = "ObsidianPros"; };
                    "c" = { char = ""; hl_group = "ObsidianCons"; };
                    "u" = { char = "󰔵"; hl_group = "ObsidianTrendUp"; };
                    "d" = { char = "󰔳"; hl_group = "ObsidianTrendDown"; };
                    "r" = { char = ""; hl_group = "ObsidianRule"; };
                    "T" = { char = ""; hl_group = "ObsidianTelephone"; };
                };
                external_link_icon = { char = ""; hl_group = "ObsidianExtLinkIcon"; };
                reference_text = { hl_group = "ObsidianRefText"; };
                highlight_text = { hl_group = "ObsidianHighlightText"; };
                tags = { hl_group = "ObsidianTag"; };
                block_ids = { hl_group = "ObsidianBlockID"; };
            };

            attachments = {
                folder = "Mídias";
                img_name_func = {
                    __raw = ''
                        function()
                        return string.format("%s-", os.time())
                        end
                        '';
                };
                img_text_func = {
                    __raw = ''
                        function(client, path)
                        path = client:vault_relative_path(path) or path
                        return string.format("![%s](%s)", path.name, path)
                        end
                        '';
                };
            };
        };
    };

    plugins.obsidian-bridge.enable = true;

    keymaps = [
    {
        mode = "n";
        key = "gf";
        action.__raw = ''
            function()
            return require("obsidian").util.gf_passthrough()
            end
            '';
        options = { noremap = false; expr = true; buffer = true; };
    }
    {
        mode = "n";
        key = "<leader>ch";
        action.__raw = ''
            function()
            return require("obsidian").util.toggle_checkbox()
            end
            '';
        options.buffer = true;
    }
    {
        mode = "n";
        key = "<S-CR>";
        action.__raw = ''
            function()
            return require("obsidian").util.smart_action()
            end
            '';
        options = { buffer = true; expr = true; };
    }
    ];
}
