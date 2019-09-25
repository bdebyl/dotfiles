#!/bin/bash
usage() {
    echo "usage:"
    echo "    taglog.sh -t <git-tag>      Format the git-log tags up to tag specified tag (e.g. '1.2.3')"
    echo "    taglog.sh -h                Display this help message."
}

while getopts ":ht:" opt; do
    case ${opt} in
        t)
            while read -r line; do
                if [[ $line =~ "$OPTARG" ]]; then
                    break
                else
                    echo $line | perl -nE '/tag: ([\w.]+).*from\s+\w+\/(\w+\-\d+|noticket)_(.*)/ && say "| $1 | $2 | $3 |"'
                fi
            done < <(git log --no-walk --tags --oneline --pretty="%D %s")
            exit 0
            ;;
        h)
            usage && exit 0
            ;;
        \?)
            echo "invalid option: -$OPTARG" 1>&2
            usage && exit 1
            ;;
    esac
done
shift $((OPTIND -1))

if [ -z "$line" ]; then
    echo "invalid usage" && usage && exit 1
fi
