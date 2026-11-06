# Usage: pr_mark_viewed <pr-url> [all|noise]
# noise = only tests, mocks, snapshots, generated files, lockfiles
function pr_mark_viewed
    set -l url $argv[1]
    set -l scope all
    test (count $argv) -ge 2; and set scope $argv[2]

    if not string match -rq 'github\.com/([^/]+)/([^/]+)/pull/(\d+)' -- $url
        echo "Usage: pr_mark_viewed <pr-url> [all|noise]" >&2
        return 1
    end
    set -l m (string match -r 'github\.com/([^/]+)/([^/]+)/pull/(\d+)' -- $url)
    set -l owner $m[2]
    set -l repo $m[3]
    set -l number $m[4]

    if not contains -- $scope all noise
        echo "Unknown scope '$scope', expected: all, noise" >&2
        return 1
    end

    set -l noise_re '(_test\.go$|\.(test|spec)\.[jt]sx?$|(^|/)(mocks?|__mocks__|__snapshots__|testdata|fixtures)/|(^|/)mock_[^/]+\.go$|_mock\.go$|\.snap$|\.stories\.[jt]sx?$|\.gen\.go$|\.pb\.go$|(^|/)docs/(swagger|openapi)[^/]*$|(^|/)(package-lock\.json|yarn\.lock|pnpm-lock\.yaml|go\.sum)$)'

    set -l pr_id (gh api graphql -f query='query($o:String!,$r:String!,$n:Int!){repository(owner:$o,name:$r){pullRequest(number:$n){id}}}' -F o=$owner -F r=$repo -F n=$number --jq .data.repository.pullRequest.id)
    or return 1

    set -l files (gh api --paginate repos/$owner/$repo/pulls/$number/files --jq '.[].filename')
    or return 1

    set -l selected
    for f in $files
        if test $scope = noise; and not string match -rq $noise_re -- $f
            continue
        end
        set -a selected $f
    end

    set -l total (count $selected)
    echo "PR has "(count $files)" files, marking $total as viewed ($scope)"
    set -l batch_size 50
    set -l count 0
    test $total -gt 0; and for start in (seq 1 $batch_size $total)
        set -l end_idx (math "min($start + $batch_size - 1, $total)")
        set -l chunk $selected[$start..$end_idx]
        set -l decls
        set -l body
        set -l args -f id=$pr_id
        for i in (seq (count $chunk))
            set -a decls "\$p$i:String!"
            set -a body "f$i:markFileAsViewed(input:{pullRequestId:\$id,path:\$p$i}){clientMutationId}"
            set -a args -f "p$i=$chunk[$i]"
        end
        set -l query "mutation(\$id:ID!,"(string join , $decls)"){"(string join ' ' $body)"}"
        echo "Batch: marking "(count $chunk)" files ($start-$end_idx of $total)"
        if gh api graphql -f query=$query $args >/dev/null
            set count (math $count + (count $chunk))
        else
            echo "Failed batch of files $start-$end_idx" >&2
        end
    end
    echo "Marked $count of "(count $files)" files as viewed ($scope)"
end
