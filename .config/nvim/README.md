This is my Neovim configuration.

# Installation

## Core config

```shell
cd $HOME
mkdir git && cd git
git clone --bare https://github.com/knightjoel/dotfiles.git dotfiles
alias dotfiles="git --git-dir=$HOME/git/dotfiles/ --work-tree=$HOME"
cd $HOME
dotfiles config --local status.showUntrackedFiles no
dotfiles checkout
```

When you run nvim for the first time, it will complain about missing colorschemes,
plugins, etc. The package manager should run and install everything. Restart nvim
to properly load everything.

## Dependencies (optional)

CloudFormation snippets:

```shell
mkdir -p $HOME/.local/share/nvim
cd $HOME/.local/share/nvim
git clone --depth=1 https://github.com/dannysteenman/vscode-cloudformation-snippets.git
```

Terraform language server and linters:

_Mason.nvim doesn't support auto-installing these on OpenBSD or FreeBSD (yet)._

- Install `terraform-ls` using native package manager or manually by
[downloading a release](https://releases.hashicorp.com/terraform-ls/).
- Install `tflint` using ports or manually building.
- Install `tfsec` using ports or manually building.

# Configuration structure

- `init.lua` - Neovim starts here; I use this file to pull in all the other files
- `lua/user/` - Top directory for lua files
  - `plugins-setup.lua` - Load plugin manager and specify plugins to install
  - `core/` - Lua files for keymaps, options, and other core settings
  - `plugins/` - A file per plugin which loads and configures each plugin 
    - `lsp/` - Files for configuring LSP-related plugins

# FAQ

## How do I add a new keymap?

Edit `lua/user/core/keymaps.lua`. This file is organized as a module. Read the
comments in the file to understand how to properly create a new binding. This
file can be used to create core/standard bindings as well as bindings for
plugins.

## How do I pull in a new plugin?

1. Add the plugin to `plugin-setup.lua`.
2. Create a new file in `lua/user/plugins/`, call the plugin's `setup()`
   function, and do any configuration the plugin requires.
3. Load the file created in #2 by adding a new `require()` to `init.luad`. 

## How do I load a new language server?

1. Browse the
[list of servers and linters](https://github.com/williamboman/mason-lspconfig.nvim#available-lsp-servers)
available in mason-lspconfig.nvim.
2. Edit `lua/user/plugins/lsp/mason.lua`. Add the name of the LSP server to 
`mason_lspconfig.setup()`.
3. In Neovim, run `:MasonInstall`. It's also a good opportunity to run
`:MasonUpdate`.

## How do I use a linter/formatter which doesn't support the LSP spec?

While Mason supports LSP servers, not every tool supports that spec. For example,
CloudFormation linter is a CLI tool and doesn't speak the LSP spec. The
[null-ls.nvim](https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main) plugin
is the glue that brings such tools into the Neovim LSP ecosystem.

To install a non-LSP linter/formatter:

1. Look to see if null-ls supports the linter/formatter you want to use by reviewing
the null-ls
[BUILTINS](https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md).
2. Configure the builtin in `lua/user/plugins/lsp/null-ls.lua`.
3. Alternatively, configure a new linter/formatter by following the null-ls docs and
examples.

## How do I change options for an LSP server?

Edit `lua/user/plugins/lsp/lspconfig.lua`. 

## How do I add new snippets?

Edit `lua/user/plugins/nvim-cmp.lua`.

## How do I modify the sources for text completion?

Open `lua/user/plugins/nvim-cmp.lua` and edit the `sources` table in `cmp.setup()`.

## How do I get the alt/Option key working in iTerm2?

1. Open iTerm2
2. Navigate to Preferences, Profiles, Keys
3. For the Left and Right Option key, choose `Esc+`. (Note: even though I
prefer to use the left Option key, I had to modify the setting of the Right key)
