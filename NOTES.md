# nvim config — notes

Everything here goes in `~/.config/nvim/`. Back up first:

```fish
mv ~/.config/nvim ~/.config/nvim.backup
```

Note the `after/` directory sits **directly under** `~/.config/nvim/`, not
inside `lua/`. `lua/` is the module system (`require()`); `after/`,
`plugin/`, `ftplugin/` and `lsp/` are nvim's own runtimepath conventions,
which predate Lua entirely.

---

## What changed from the in-session version

### Treesitter was configured against the wrong branch

`main = "nvim-treesitter"` selects the `main` branch, which is a full
incompatible rewrite. On it, `ensure_installed`, `highlight = { enable =
true }` and `indent = { enable = true }` **do not exist**. The whole `opts`
table was inert — which is why `:TSUpdate` reported everything up to date
while nothing had been requested, and why highlighting never auto-started.
The `FileType` autocmd calling `vim.treesitter.start()` is the correct
mechanism on this branch, not a workaround.

Also: `styled_components` was never a real parser name.

### The styled-components injection was missing `#offset!`

This is the actual root cause of `d<is>play` and `padd<in>g`. Your own
diagnostic dump contained `{ "offset!", 2, "0", "1", "0", "-1" }` — the
built-in query stripping the backticks. Without it the parser's first
character is a backtick, which is an immediate error, and **in error
recovery tree-sitter's lexer will match keyword tokens inside identifiers**.
Not grammar immaturity.

SCSS is the right permanent choice, for a real reason: styled-components
bodies are bare declaration lists with no enclosing rule block, which is
invalid at CSS's top level. SCSS's grammar permits them.

`injection.include-children` was removed — it feeds `${...}` interpolations
to the SCSS parser as if they were SCSS.

`;; extends` does nothing when passed to `vim.treesitter.query.set()`; it's
parsed by the runtimepath file loader, not the query compiler. The
in-session `query.set` call therefore **replaced** nvim-treesitter's
typescript injections wholesale, losing the built-in html/graphql/sql
handling. These are files now.

### mason's kill-switch wasn't connected

`automatic_installation` was removed in mason-lspconfig v2. The real option
is `automatic_enable`, and it **defaults to true** — so without it mason
auto-enables every installed server, exactly the overeagerness you wanted
gone. Also note mason v2 lives under the `mason-org` org.

### conform was self-contradictory

The ft entries asked for the LSP first while `format_on_save` forbade the
LSP entirely, so JS/TS was never formatted at all. `lsp_fallback` is also
the deprecated spelling.

### ts_ls formatting is stripped via LspAttach, not `after/lsp/`

`after/lsp/*.lua` files are deep-merged with lspconfig's defaults, and a deep
merge **replaces** functions rather than composing them. An `on_attach`
there would silently clobber lspconfig's own.

### Deprecated diagnostic API

`vim.diagnostic.goto_next` / `goto_prev` are deprecated as of 0.11.
`vim.diagnostic.jump({ count = ±1 })` replaces them.

Also worth knowing: nvim 0.11+ **ships default LSP keymaps** — `K` (hover),
`grn` (rename), `gra` (code action), `grr` (references), `gri`
(implementation), `gO` (document symbols). Several bindings here
re-implement built-ins.

### snacks: picker re-enabled

The explorer is built on the picker. Disabling one while enabling the other
is contradictory, and every highlight group you inspected came back as
`SnacksPicker*` — the picker was running regardless. This may resolve the
explorer theming you gave up on.

### The kitty background number was wrong

You were told to match kitty to `#221f22`. `Normal`'s background is
`#2d2a2e`; `#221f22` is the darker secondary. Matching `#221f22` would have
*guaranteed* the seam. Use `#2d2a2e`.

---

## Two things needing your assent

**`<leader>e` moved to `<leader>E` for the explorer.** `<leader>e` is now the
diagnostics group. Having both mapped meant every `<leader>ev` waited out
`timeoutlen` first. Swap them if you'd rather the explorer keep the short
key — just move the diagnostics group with it.

**`<leader>dd` was never solved.** `:verbose nmap <leader>d` returning "No
mapping found" means the mapping was never registered — most likely
`require("keymaps")` wasn't in `init.lua`. It is now. (Separately: the
earlier `<leader>cd` output was misread. neo-tree had mapped `<Space>`
*itself* to `toggle_node` buffer-locally, so every `<leader>x` died in a
neo-tree buffer. Not a `<leader>c` prefix claim.)

---

## Unverified

- **`plugins = { snacks = true }`** was dropped from the monokai-pro setup;
  I couldn't confirm that option name. Check monokai-pro's README.
- **`ft = { "snacks_picker_list" }`** in claude-code.lua — the snacks
  explorer's filetype string is a guess. Run `:set filetype?` in the
  explorer and correct it.
- **Cypher parser availability.** `:TSInstall cypher` may not exist in the
  registry. Test the comment-injection mechanism with `// language=json`
  first. `language=sql` gets you ~70% of Cypher if there's no dedicated
  parser.
- **`raw_string_literal` node shape** — see the comment in
  `after/queries/rust/injections.scm`.

---

## First run

```fish
brew install fd ripgrep tree-sitter-cli
```

`tree-sitter-cli` is the one that bit you: Homebrew's `tree-sitter` formula
is the library only, with no binary.
