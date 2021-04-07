local vim_readme_template = {
  "# Name",
  "",
  "## Requirements",
  "",
  "## Installation",
  "",
  "## Usage",
  "",
  "### Commands",
  "",
  "### Keymaps",
  "",
  "## License",
  "",
  "[LICENSE NAME](LICENSE)"
}

local vim_doc_template = {
  "*{}.txt* Description",
  "",
  "INTRODUCTION                                     *{}*",
  "",
  "Description",
  "",
  "CONTENTS                                         *{}-contents*",
  "",
  "  1.  Overview                                   |{}-overview|",
  "  2.  Requirements                               |{}-requirements|",
  "  3.  Installation                               |{}-installation|",
  "  4.  Usage                                      |{}-usage|",
  "  5.  Commands                                   |{}-commands|",
  "  6.  Functions                                  |{}-functions|",
  "  7.  Mappings                                   |{}-mappings|",
  "  8.  Plugs                                      |{}-plugs|",
  "  9.  Options                                    |{}-options|",
  "  10. Issues                                     |{}-issues|",
  "  11. Contributing                               |{}-contributing|",
  "  12. Version                                    |{}-version|",
  "  13. License                                    |{}-license|",
  "",
  "OVERVIEW                                         *{}-overview*",
  "",
  "REQUIREMENTS                                     *{}-requirements*",
  "",
  "INSTALLATION                                     *{}-installation*",
  "",
  "  1. Plug <https://github.com/junegunn/vim-plug>",
  "",
  "     Add the following to your vimrc, or something sourced therein: >",
  "",
  "     Plug 'esensar/{}'",
  "<",
  "     Then install via `:PlugInstall`",
  "",
  "  2. Pathogen <https://github.com/tpope/vim-pathogen> >",
  "",
  "     cd ~/.vim/bundle",
  "     git clone https://github.com/esensar/{}.git",
  "<",
  "     Then run `:Helptags`",
  "",
  "  3. Manual",
  "",
  "     Clone this repository and copy the files in plugin/, autoload/, and doc/",
  "     to their respective directories in your vimfiles, or copy the text from",
  "     the github repository into new files in those directories. Make sure to",
  "     run `:helptags`.",
  "",
  "USAGE                                            *{}-usage*",
  "",
  "COMMANDS                                         *{}-commands*",
  "",
  "FUNCTIONS                                        *{}-functions*",
  "",
  "MAPPINGS                                         *{}-mappings*",
  "",
  "PLUGS                                            *{}-plugs*",
  "",
  "OPTIONS                                          *{}-options*",
  "",
  "ISSUES                                           *{}-issues*",
  "",
  "If you experience issues using {}, please report them at",
  "<https://github.com/esensar/{}/issues>.",
  "",
  "CONTRIBUTING                                     *{}-contributing*",
  "",
  "Feel free to look at already reported issues at ",
  "<https://github.com/esensar/{}/issues>.",
  "If available, check out CONTRIBUTING.md in the repository.",
  "Otherwise, feel free to create a new issue or pull request.",
  "",
  "VERSION                                          *{}-version*",
  "",
  "Version 1.0.0",
  "",
  "LICENSE                                          *{}-license*",
  "",
  "vim:tw=78:ts=2:ft=help:norl:"
}

local flutter_config = {
  ["*"] = {
    start = "flutter run"
  },
  ["lib/*.dart"] = {
    alternate = "test/{}_test.dart",
    type = "source"
  },
  ["test/*_test.dart"] = {
    alternate = "lib/{}.dart",
    type = "test",
    template = {
      "import 'package:flutter_test/flutter_test.dart';",
      "",
      "import 'package:flutter_template/{}.dart';",
      "",
      "void main() {",
      "  testWidgets('', (WidgetTester tester) async {",
      "  });",
      "}"
    }
  }
}

local python_config = {
  ["*.py"] = {
    alternate = "tests/{dirname}/test_{basename}.py",
    type = "source"
  },
  ["tests/**/test_*.py"] = {
    alternate = "{dirname}/{basename}.py",
    type = "test",
    template = {
      "import unittest",
      "from unittest import mock",
      "",
      "class {dirname|underscore|camelcase|capitalize}{basename|camelcase|capitalize}Test(unittest.TestCase):",
      "    pass",
      "",
      "",
      "if __name__ == \"__main__\":",
      "    unittest.main()"
    }
  }
}

local dotnet_config = {}

local vim_plugin_config = {
  ["doc/*.txt"] = {
    type = "help",
    template = vim_doc_template
  },
  ["autoload/*.vim"] = {
    type = "autoload",
    alternate = "test/{}.vader"
  },
  ["test/*.vader"] = {
    type = "test",
    altername = "autoload/{}.vim"
  },
  ["plugin/*.vim"] = {
    type = "plugin",
    template = {
      "if exists(\"g:loaded_{}\") || &cp | finish | endif",
      "",
      "let g:loaded_{} = 1"
    }
  },
  ["README.md"] = {
    template = vim_readme_template
  }
}

local lua_vim_plugin_config = {
  ["doc/*.txt"] = {
    type = "help",
    template = vim_doc_template
  },
  ["plugin/*.vim"] = {
    type = "plugin",
    template = {
      "if exists(\"g:loaded_{}\") || &cp | finish | endif",
      "",
      "let g:loaded_{} = 1"
    }
  },
  ["lua/*.lua"] = {
    type = "source",
    alternate = "test/{}.lua"
  },
  ["test/*.lua"] = {
    type = "test",
    alternate = "lua/{}.lua"
  },
  ["README.md"] = {
    template = vim_readme_template
  }
}

vim.g.projectionist_heuristics = {
  ["pubspec.yaml"] = flutter_config,
  ["requirements.txt|pyproject.toml"] = python_config,
  ["*.csproj"] = dotnet_config,
  ["plugin/|autoload/"] = vim_plugin_config,
  ["lua/"] = lua_vim_plugin_config
}
