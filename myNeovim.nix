pkgs:
let
  myNeovim = pkgs.neovim.override {
    configure = {
      customRC = ''
        lua vim.g.is_nix = true
        lua vim.opt.rtp:prepend("${./.}")
        luafile ${./.}/init.lua
      '';

      packages.myPackages = with pkgs.vimPlugins; {
        start = [
          catppuccin-nvim
          conform-nvim
          lazydev-nvim
          mini-nvim
          nvim-lint
          nvim-lspconfig
          nvim-treesitter.withAllGrammars
          vim-sleuth

          # hardtime-nvim
          # nui-nvim
          # plenary-nvim

          # nvim-treesitter-context
          # nvim-treesitter-textobjects
        ];
      };
    };
  };
in
pkgs.writeShellApplication {
  name = "nvim";
  runtimeInputs = with pkgs; [
    clang-tools
    clippy
    lua-language-server
    nixfmt-rfc-style
    rust-analyzer
    stylua
  ];
  text = ''
    ${myNeovim}/bin/nvim "$@"
  '';
}
