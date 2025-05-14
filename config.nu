$env.config = {
	# main configuration
	show_banner: false,
	render_right_prompt_on_last_line: true,
	hooks: {
		pre_execution: [
			{ chcp 65001 | complete | ignore }
		]
	}
#   hooks: {
#     pre_prompt: [{ ||
#       if (which direnv | is-empty) {
#         return
#       }

#       direnv export json | from json | default {} | load-env
#       if 'ENV_CONVERSIONS' in $env and 'PATH' in $env.ENV_CONVERSIONS {
#         $env.PATH = do $env.ENV_CONVERSIONS.PATH.from_string $env.PATH
#       }
#     }]
#   }
}

use bun *
use java *
use scoop *

alias ll = ls -l
alias la = ls -a
alias lla = ll -a
alias l = la
alias ndev = nix develop
alias repl = nix repl
alias neo = fastfetch
alias nv = nvim


def gc [] {
    sudo nix store gc --debug
    sudo nix-collect-garbage --delete-old
}

# 寻找一个可用端口
def sp [
    use_port: int=10032  # 端口寻址起始位置 10032
    --middleware (-m)  # 中间件默认值 11032
] {
    mut port = $use_port
    if $middleware {
        $port = 11032
    }
    while (ss $port | str contains "is in use") {
        $port += 1
    }
    $port
}

def ss [port: int] {
    let os = $env.os
    if $os == "Windows_NT" {
        let result = netstat -ano | findstr $port | is-empty
        if $result {
            $"Port ($port) is available"
        } else {
            $"Port ($port) is in use by: ($result)"
        }
    } else {
        let result = lsof -i :$port | is-empty
        if $result {
            $"Port ($port) is available"
        } else {
            $"Port ($port) is in use by: ($result)"
        }
    }
}

def greet1 [name = 'ru', ...ex] {
  $"hello ($name) (...$ex)"
}


def greet2 [name?: string = "ru"] {
  $"hello ($name)"
}

def greet3 [name: string = "ru"] {
  $"hello ($name)"
}

def greet4 [name: string] {
  $"hello ($name)"
}
