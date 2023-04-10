-- TODO: REMOVE THIS UNNECESSARY FILE
return function(_, opts)
  local mason_null_ls = require "mason-null-ls"
  local formatting = mason_null_ls.builtins.formatting
  local diagnostics = mason_null_ls.builtins.diagnostics
  local code_actions = mason_null_ls.builtins.code_actions
  mason_null_ls.setup(opts)
  mason_null_ls.setup({
    debug = true,
    sources = {
      diagnostics.twigcs,
      diagnostics.phpstan.with({
        command = "./vendor/bin/phpstan"
      }),
      diagnostics.yamllint.with({
        extra_args = { "-d { extends: default, rules: {line-length: {max: 120}}}" }
      }),
      diagnostics.psalm.with({
        method = mason_null_ls.methods.DIAGNOSTICS_ON_SAVE,
        extra_args = { "--config=.psalm-nvim.xml" },
        condition = function(utils)
          return utils.root_has_file({ ".psalm-nvim.xml" })
        end,
        timeout = 20000,
        command = "./vendor/bin/psalm"
      }),
      diagnostics.phpcs.with({
        extra_args = { "--standard=PSR12" }
      }),
      code_actions.eslint,
      formatting.json_tool,
      diagnostics.eslint,
      formatting.eslint,
      formatting.xmllint,
      diagnostics.stylelint,
      formatting.stylelint,
      formatting.black.with({ extra_args = { "--fast" } }),
      formatting.stylua,
      formatting.yamlfmt,
      formatting.phpcbf.with({ extra_args = { "--standard=PSR12" } }),
      formatting.phpcsfixer,
      formatting.shfmt,
    },
  })
end
