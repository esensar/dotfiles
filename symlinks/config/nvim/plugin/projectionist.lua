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
	"[LICENSE NAME](LICENSE)",
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
	"vim:tw=78:ts=2:ft=help:norl:",
}

local flutter_config = {
	["*"] = {
		start = "flutter run",
		dispatch = "flutter test",
	},
	["lib/*.dart"] = {
		alternate = "test/{}_test.dart",
		type = "source",
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
			"}",
		},
	},
}

local python_config = {
	["*.py"] = {
		alternate = "tests/{dirname}/test_{basename}.py",
		type = "source",
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
			'if __name__ == "__main__":',
			"    unittest.main()",
		},
	},
}

local dotnet_solution_config = {
	["src/**/Controllers/*.cs"] = {
		type = "controller",
		alternate = {
			"tests/{dirname}.Tests/Controllers/{basename}Tests.cs",
			"tests/{dirname}.IntegrationTests/Controllers/{basename}Tests.cs",
		},
	},
	["src/**/Models/*.cs"] = {
		type = "model",
		alternate = "tests/{dirname}.Tests/Models/{basename}Tests.cs",
	},
	["src/**/Views/*.cshtml"] = {
		type = "view",
		alternate = "tests/{dirname}.Tests/Views/{basename}Tests.cs",
	},
	["src/**/Services/*.cs"] = {
		type = "service",
		alternate = "tests/{dirname}.Tests/Services/{basename}Tests.cs",
	},
	["src/**/Extensions/*.cs"] = {
		type = "extension",
		alternate = "tests/{dirname}.Tests/Extensions/{basename}Tests.cs",
	},
	["*.csproj"] = {
		type = "project",
	},
	["src/**/appsettings*json"] = {
		type = "appsettings",
	},
	["src/*.cs"] = {
		type = "source",
		alternate = "tests/{dirname}.Tests/{basename}Tests.cs",
		template = {
			"using System;",
			"",
			"namespace {dirname|dot}",
			"{",
			"    public class {basename}",
			"    {",
			"    }",
			"}",
		},
	},
	["tests/**.IntegrationTests/Controllers/*Tests.cs"] = {
		type = "test",
		alternate = "src/{dirname}/Controllers/{basename}.cs",
	},
	["tests/**.Tests/Controllers/*Tests.cs"] = {
		type = "test",
		alternate = "src/{dirname}/Controllers/{basename}.cs",
	},
	["tests/**.Tests/Views/*Tests.cs"] = {
		type = "test",
		alternate = "src/{dirname}/Views/{basename}.cs",
	},
	["tests/**.Tests/Models/*Tests.cs"] = {
		type = "test",
		alternate = "src/{dirname}/Models/{basename}.cs",
	},
	["tests/**.Tests/Services/*Tests.cs"] = {
		type = "test",
		alternate = "src/{dirname}/Services/{basename}.cs",
	},
	["tests/**.Tests/Extensions/*Tests.cs"] = {
		type = "test",
		alternate = "src/{dirname}/Extensions/{basename}.cs",
	},
	["tests/*Tests.cs"] = {
		type = "test",
		alternate = "src/{dirname}/{basename}.cs",
		template = {
			"using System;",
			"",
			"namespace {dirname|dot}",
			"{",
			"    public class {basename}Tests",
			"    {",
			"    }",
			"}",
		},
	},
}

local vim_plugin_config = {
	["doc/*.txt"] = {
		type = "help",
		template = vim_doc_template,
	},
	["autoload/*.vim"] = {
		type = "autoload",
		alternate = "test/{}.vader",
	},
	["test/*.vader"] = {
		type = "test",
		altername = "autoload/{}.vim",
	},
	["plugin/*.vim"] = {
		type = "plugin",
		template = {
			'if exists("g:loaded_{}") || &cp | finish | endif',
			"",
			"let g:loaded_{} = 1",
		},
	},
	["README.md"] = {
		template = vim_readme_template,
	},
}

local lua_vim_plugin_config = {
	["doc/*.txt"] = {
		type = "help",
		template = vim_doc_template,
	},
	["plugin/*.vim"] = {
		type = "plugin",
		template = {
			'if exists("g:loaded_{}") || &cp | finish | endif',
			"",
			"let g:loaded_{} = 1",
		},
	},
	["lua/*.lua"] = {
		type = "source",
		alternate = "tests/{}_spec.lua",
	},
	["tests/*_spec.lua"] = {
		type = "test",
		alternate = "lua/{}.lua",
		template = {
			'local subject = require("{dot}")',
			"",
			'describe("{dot}:", function()',
			"end)",
		},
	},
	["README.md"] = {
		template = vim_readme_template,
	},
}

local csharp_project_config = {
	["*"] = {
		start = "dotnet run",
		console = "dotnet fsi",
	},
}

local java_project_config = {
	["src/main/java/*.java"] = {
		type = "source",
		template = {
			"package {dirname|dot};",
			"",
			"public class {basename} {open}",
			"{close}",
		},
		alternate = "src/test/java/{}Test.java",
	},
	["src/test/java/*Test.java"] = {
		type = "test",
		template = {
			"package {dirname|dot};",
			"",
			"public class {basename}Test {open}",
			"{close}",
		},
		alternate = "src/main/java/{}.java",
	},
	["src/main/java/module-info.java"] = {
		type = "moduleinfo",
	},
	["src/main/java/**/package-info.java"] = {
		type = "packageinfo",
	},
	["src/main/resources/*"] = {
		type = "resource",
	},
	["src/main/resources/META-INF/MANIFEST.MF"] = {
		type = "manifest",
	},
	["src/test/resources/*"] = {
		type = "testresource",
	},
}

local kotlin_project_config = {
	["src/main/kotlin/*.kt"] = {
		type = "source",
		template = {
			"package {dirname|dot}",
			"",
			"class {basename} {open}",
			"{close}",
		},
		alternate = "src/test/kotlin/{}Test.kt",
	},
	["src/main/java/*.kt"] = {
		type = "source",
		template = {
			"package {dirname|dot}",
			"",
			"class {basename} {open}",
			"{close}",
		},
		alternate = "src/test/java/{}Test.kt",
	},
	["src/test/kotlin/*Test.kt"] = {
		type = "test",
		template = {
			"package {dirname|dot}",
			"",
			"class {basename}Test {open}",
			"{close}",
		},
		alternate = "src/main/kotlin/{}.kt",
	},
	["src/test/java/*Test.kt"] = {
		type = "test",
		template = {
			"package {dirname|dot}",
			"",
			"class {basename}Test {open}",
			"{close}",
		},
		alternate = "src/main/java/{}.kt",
	},
	["src/main/resources/*"] = {
		type = "resource",
	},
	["src/test/resources/*"] = {
		type = "testresource",
	},
}

local maven_project_config = {
	["*"] = {
		start = "mvn package",
	},
	["pom.xml"] = {
		type = "pom",
	},
}

local gradle_project_config = {
	["*"] = {
		start = "./gradlew assemble",
	},
	["build.gradle"] = {
		type = "build",
	},
	["build.gradle.kts"] = {
		type = "build",
	},
	["settings.gradle"] = {
		type = "settings",
	},
	["gradle.properties"] = {
		type = "properties",
	},
	["local.properties"] = {
		type = "localproperties",
	},
}

local mint_config = {
	["*"] = {
		start = "mint start",
		dispatch = "mint test",
	},
	["source/*.mint"] = {
		type = "source",
		template = {
			"component {basename} {open}",
			"  style {basename|camelcase} {open}",
			"  {close}",
			"",
			"  fun render : Html {open}",
			"  {close}",
			"{close}",
		},
		alternate = "tests/{}.mint",
	},
	["tests/*.mint"] = {
		type = "test",
		template = {
			'suite "{basename}" {open}',
			'  test "A test" {open}',
			"    with Test.Html {open}",
			"    {close}",
			"  {close}",
			"{close}",
		},
		alternate = "source/{}.mint",
	},
}

local crystal_config = {
	["*"] = {
		start = "crystal run",
		dispatch = "crystal spec",
		console = "crystal eval",
	},
	["src/*.cr"] = {
		type = "source",
		template = {
			"module {capitalize|colons}",
			"end",
		},
		alternate = "spec/{}_spec.cr",
	},
	["spec/*_spec.cr"] = {
		type = "spec",
		template = {
			"describe {capitalize|colons} do",
			"  # TODO Write tests",
			"",
			'  it "works" do',
			"    false.should eq(true)",
			"  end",
			"end",
		},
		alternate = "src/{}.cr",
	},
}

local function c_project_config(source_extension, header_extension)
	return {
		["*"] = {
			start = "make run",
			dispatch = "make test",
		},
		["src/*." .. source_extension] = {
			type = "source",
			alternate = {
				"src/{}." .. header_extension,
				"test/{}." .. source_extension,
				"include/{project|basename}/{}." .. header_extension,
			},
		},
		["test/*." .. source_extension] = {
			type = "test",
			alternate = {
				"src/{}." .. header_extension,
			},
		},
		["src/*." .. header_extension] = {
			type = "header",
			alternate = {
				"src/{}." .. source_extension,
			},
		},
		["include/{project|basename}/*." .. header_extension] = {
			type = "header",
			alternate = {
				"src/{}." .. header_extension,
			},
		},
	}
end

local rust_config = {
	["*"] = {
		start = "cargo run",
		dispatch = "cargo test",
	},
	["Cargo.toml"] = {
		type = "crate",
	},
	["src/*.rs"] = {
		type = "source",
	},
	["tests/*.rs"] = {
		type = "test",
	},
	["benches/*.rs"] = {
		type = "bench",
	},
}

local zig_config = {
	["*"] = {
		start = "zig build run",
		dispatch = "zig test",
	},
	["src/*.zig"] = {
		type = "source",
	},
}

local lein_config = {
	["*"] = {
		start = "lein run",
		dispatch = "lein test",
		console = "lein repl",
	},
	["src/*.clj"] = {
		type = "source",
		alternate = {
			"test/{}_test.clj",
		},
	},
	["src/*.cljs"] = {
		type = "source",
		alternate = {
			"test/{}_test.cljs",
		},
	},
	["src/*.cljc"] = {
		type = "source",
		alternate = {
			"test/{}_test.cljc",
		},
	},
	["test/*_test.clj"] = {
		type = "test",
		alternate = {
			"src/{}.clj",
		},
	},
	["test/*_test.cljs"] = {
		type = "test",
		alternate = {
			"src/{}.cljs",
		},
	},
	["test/*_test.cljc"] = {
		type = "test",
		alternate = {
			"src/{}.cljc",
		},
	},
}

local clojure_config = {
	["*"] = {
		dispatch = "clj -M:test",
		console = "clj -M:dev",
	},
	["src/clj/*.clj"] = {
		type = "source",
		alternate = {
			"test/clj/{}_test.clj",
		},
	},
	["src/clj/*.cljs"] = {
		type = "source",
		alternate = {
			"test/clj/{}_test.cljs",
		},
	},
	["src/clj/*.cljc"] = {
		type = "source",
		alternate = {
			"test/clj/{}_test.cljc",
		},
	},
	["test/clj/*_test.clj"] = {
		type = "test",
		alternate = {
			"src/clj/{}.clj",
		},
	},
	["test/clj/*_test.cljs"] = {
		type = "test",
		alternate = {
			"src/clj/{}.cljs",
		},
	},
	["test/clj/*_test.cljc"] = {
		type = "test",
		alternate = {
			"src/clj/{}.cljc",
		},
	},
}

local golang_config = {
	["*"] = {
		start = "go run .",
		dispatch = "go test ./...",
	},
	["*.go"] = {
		type = "source",
		alternate = {
			"{}_test.go",
		},
	},
	["*_test.go"] = {
		type = "test",
		alternate = {
			"{}.go",
		},
	},
}

local playdate_config = {
	["*"] = {
		start = "pdc Source output.pdx && PlaydateSimulator output.pdx",
		dispatch = "pdc Source output.pdx && PlaydateSimulator.debug output.pdx",
	},
	["Source/pdxinfo"] = {
		type = "metadata",
	},
	["Source/*.lua"] = {
		type = "source",
	},
}

vim.g.projectionist_heuristics = {
	["pubspec.yaml"] = flutter_config,
	["requirements.txt|pyproject.toml"] = python_config,
	["*.sln"] = dotnet_solution_config,
	["*.csproj"] = csharp_project_config,
	["plugin/|autoload/"] = vim_plugin_config,
	["src/*.cpp|test/*.cpp"] = c_project_config("cpp", "hpp"),
	["src/*.c|test/*.c"] = c_project_config("c", "h"),
	["lua/"] = lua_vim_plugin_config,
	["build.gradle|pom.xml"] = java_project_config,
	["build.gradle|build.gradle.kts"] = kotlin_project_config,
	["build.gradle|build.gradle.kts|settings.gradle"] = gradle_project_config,
	["pom.xml"] = maven_project_config,
	["mint.json"] = mint_config,
	["shard.yml"] = crystal_config,
	["Cargo.toml"] = rust_config,
	["go.mod"] = golang_config,
	["build.zig"] = zig_config,
	["project.clj"] = lein_config,
	["deps.edn"] = clojure_config,
	["Source/main.lua|Source/pdxinfo"] = playdate_config,
}
