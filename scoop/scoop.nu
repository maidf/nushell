export alias sc = scoop

export def "sc i" [...apps: string] {
    scoop install ...$apps
}

export def "sc s" [...apps: string] {
    scoop search ...$apps
}

export def "sc ui" [...apps: string] {
    scoop uninstall ...$apps
}

export def "sc ls" [] {
    scoop list
}

export def "sc up" [] {
    scoop update
}