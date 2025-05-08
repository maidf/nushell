
use git *

def create_left_prompt [] {
    let dir = match $env.OS {
		"Windows_NT" => { $env.PWD | str replace $"($env.HOMEDRIVE)($env.HOMEPATH)" '~' },
		_ => { $env.PWD | str replace $env.HOME '~' }
	}
    let user = whoami
    let host = uname | get nodename

    let path_color = (if (is-admin) { ansi red_bold } else { ansi green_bold })
    let separator_color = (if (is-admin) { ansi light_red_bold } else { ansi light_green_bold })
    let path_segment = $"(ansi reset)($path_color)($dir)(ansi reset)"

    let user_color = (if (is-admin) { ansi blue_bold } else { ansi blue_bold })
    let user_segment = $"(ansi reset)($user_color)($user)(ansi reset)"

    let host_color = (if (is-admin) { ansi red_bold } else { ansi red_bold })
    let host_segment = $"(ansi reset)($host_color)($host)(ansi reset)"

    let r_path = $path_segment | str replace --all (char path_sep) $"($separator_color)(char path_sep)($path_color)"
    let r_user = $user_segment
    let r_host = $host_segment

    $"[ ($r_user)@($r_host)][ ($r_path)]"
}

def create_right_prompt [] {
    # create a right prompt in magenta with green separators and am/pm underlined
    let time_segment = ([
        (ansi reset)
        (ansi magenta)
        (date now | format date '%X') # try to respect user's locale
    ] | str join | str replace --regex --all "([/:])" $"(ansi green)${1}(ansi magenta)" |
        str replace --regex --all "([AP]M)" $"(ansi magenta_underline)${1}")

    let last_exit_code = if ($env.LAST_EXIT_CODE != 0) {([
        (ansi rb)
        ($env.LAST_EXIT_CODE)
    ] | str join)
    } else { "" }

    ([$last_exit_code, (char space), $time_segment] | str join)
}


$env.PROMPT_COMMAND = {|| 
    let left = create_left_prompt
    basic-git-left-prompt $left
}

$env.PROMPT_COMMAND_RIGHT = {|| create_right_prompt }


$env.PROMPT_INDICATOR = {|| " $" }
$env.PROMPT_INDICATOR_VI_INSERT = {|| ": " }
$env.PROMPT_INDICATOR_VI_NORMAL = {|| " $" }
$env.PROMPT_MULTILINE_INDICATOR = {|| "::: " }