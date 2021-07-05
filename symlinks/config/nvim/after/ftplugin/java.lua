require('jdtls').start_or_attach {
  cmd = {'jdtls-startup.sh'};
  on_attach = require'lsp.servers'.jdtls_on_attach;
}
