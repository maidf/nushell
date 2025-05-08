export def ga [msg: string='upd'] {
	git add .
	git commit -m $msg
}

export def gp [msg: string='upd'] {
	git push
}