#!/usr/bin/env bash

parse_git_branch() {
    git rev-parse --git-dir &> /dev/null
    git_status="$(git status 2>/dev/null | sed 1q)"
    branch_pattern="^On branch ([^${IFS}]*)"
    remote_pattern="Your branch is (.*) of"
    diverge_pattern="Your branch and (.*) have diverged"
    checkout_pattern="HEAD detached at (.*)"
    if [[ ! ${git_status} =~ "working directory clean" ]]; then
        state=" √"
    fi
    # add an else if or two here if you want to get more specific
    if [[ ${git_status} =~ ${remote_pattern} ]]; then
        if [[ ${BASH_REMATCH[1]} == "ahead" ]]; then
            remote="↑"
        else
            remote="↓"
        fi
    fi
    if [[ ${git_status} =~ ${diverge_pattern} ]]; then
        remote="↕"
    fi
    if [[ ${git_status} =~ ${branch_pattern} ]]; then
        branch=${BASH_REMATCH[1]}
        printf " [ %s ]" "${branch}${remote}${state}"
    fi
    if [[ ${git_status} =~ ${checkout_pattern} ]]; then
        checkout=${BASH_REMATCH[1]}
        printf " [ detached: %s ]" "${checkout}"
    fi
}
