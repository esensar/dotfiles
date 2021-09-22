local configs = require 'lspconfig/configs'
local util = require 'lspconfig/util'

configs.cucumberls = {
  default_config = {
    cmd = { 'cucumber-language-server', '--stdio' },
    filetypes = { 'cucumber' },
    root_dir = util.root_pattern('.git'),
  },
  docs = {
    description = [[
https://www.npmjs.com/package/@cucumber/language-server
Cucumber Language Server
]],
    default_config = {
      root_dir = [[root_pattern(".git")]],
    },
  },
}
