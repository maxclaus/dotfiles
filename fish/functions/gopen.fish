# Based on https://github.com/dalloriam/dotfiles/blob/master/config/fish/functions/repo.fish
function gopen
	set base_url (git config --get remote.origin.url)
	set base_url (string replace ".git" "" $base_url)

	set base_url (string replace "git@github.com:" "https://github.com/" $base_url)
	set base_url (string replace "git://github.com" "https://github.com" $base_url)
	set base_url (string replace "git@bitbucket.org:" "https://bitbucket.org/" $base_url)
	set base_url (string replace "git@gitlab.com" "https://gitlab.com" $base_url)

	if not git branch  2>/dev/null 1>&2
		echo "Not a git repo!"
		exit 1
	end

	set rel_path (git rev-parse --show-cdup)
	set git_base_path (cd ./$rel_path; pwd)

	set git_where (git name-rev --name-only --no-undefined --always HEAD) 2>/dev/null

	set branch (string replace "refs" "heads" $git_where)
	set branch (string replace "remotes/origin/" "" $branch)

	if test (string match -r ".*bitbucket.*" $base_url)
		set tree "branch"
	else
		set tree "tree"
	end


	set url $base_url/$tree/$branch
	open $url 1>/dev/null 2>/dev/null
end
