{ lib, pkgs, ... }:
let
  kotlinLsp = pkgs.callPackage ../deps/kotlin-lsp.nix { };
in
{

  extraPackages = [
    pkgs.qt6.qtdeclarative
     pkgs.bash-language-server           
  ];

  plugins.lsp = {
    enable = true;
    capabilities = ''
      capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)
      capabilities.workspace = vim.tbl_deep_extend("force", capabilities.workspace or {}, {
        didChangeWatchedFiles = {
          dynamicRegistration = true,
        },
      })
    '';
    onAttach = ''
      if client.server_capabilities.documentSymbolProvider then
        require("nvim-navic").attach(client, bufnr)
          end
    '';

    servers = {
      lua_ls = {
        enable = true;
        package = pkgs.lua-language-server;
        settings = {
          Lua = {
            runtime.version = "LuaJIT";
            workspace.library = lib.nixvim.mkRaw "vim.api.nvim_get_runtime_file('', true)";
            diagnostics = {
              globals = [ "vim" ];
              disable = [ "spell-check" ];
            };
          };
        };
      };

      rust_analyzer = {
        enable = true;
        installCargo = false;
        installRustc = false;
      };
      
      qmlls = {
        enable = true;
        packageFallback = true;
      };

      jdtls.enable = true;

      nil_ls = {
        enable = true;
        rootMarkers = [
          "flake.nix"
          "default.nix"
        ];
      };

      bashls = {
       enable = true;
        settings = {
          command = [ "bash-language-server" "start" ];
          filetypes = [ "bash" "sh" ];

        };
      };


      kotlin_lsp = {
        enable = false;
        package = kotlinLsp;
        extraOptions = {
          init_options = {
            kotlinLSP = {
              jdkForSymbolResolution = "${pkgs.jdk21}";
            };
          };
          on_attach = lib.nixvim.mkRaw ''
            function(client, bufnr)
              vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
            end
          '';
        };
      };

      vtsls = {
        enable = true;
        rootMarkers = [
          "tsconfig.json"
          "package.json"
          "jsconfig.json"
        ];
        settings = {
          typescript = {
            preferences = {
              includePackageJsonAutoImports = "auto";
            };
          };
          vtsls = {
            autoUseWorkspaceTsdk = true;
          };
        };
      };

      angularls.enable = false;
      tsgo.enable = false;
    };
  };
  extraConfigLua = ''
    vim.lsp.enable("rust_analyzer")

    vim.lsp.handlers["workspace/configuration"] = function(_, params, ctx)
      local client = vim.lsp.get_client_by_id(ctx.client_id)
      if not client then return {} end
      local result = {}
      for _, item in ipairs(params.items) do
        if item.section then
          local ok, val = pcall(function()
            return vim.tbl_get(client.config.settings or {}, unpack(vim.split(item.section, ".", { plain = true })))
          end)
          table.insert(result, (ok and val) or vim.NIL)
        end
      end
      return result
    end

    vim.diagnostic.config({
      virtual_text = {
        filter = function(diagnostic)
          return diagnostic.code ~= "CLASSIFIER_REDECLARATION" 
            and diagnostic.code ~= "PackageDirectoryMismatch"
        end
      }
    })
  '';
}
