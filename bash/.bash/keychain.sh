#/usr/bin/env bash
# MFL's bash profile config for keychain, pgp-agent, and ssh-agent

## keychain
KEYFILE="$HOME/.keys"
KEYFILEGPG="$HOME/.keys-gpg"
if type keychain &>/dev/null; then
    # check for keyfile
    if [ -f "$KEYFILE" ] || [ -f "$KEYFILEGPG" ]; then
        # initialize keychain
        [ -f "$KEYFILE" ] && keychain --agents ssh --eval "$( cat $KEYFILE )" 2>&1 | sed '/keychain/d;/^$/d;s/^ \* /keychain - /'
        [ -f "$KEYFILEGPG" ] && keychain --agents gpg --eval "$( cat $KEYFILEGPG )" 2>&1 | sed '/keychain/d;/^$/d;s/^ \* /keychain - /'
        # load keychain environment
        [ -f "$HOME/.keychain/$HOSTNAME-sh" ] \
            && . "$HOME/.keychain/$HOSTNAME-sh"
        [ -f "$HOME/.keychain/$HOSTNAME-sh-gpg" ] \
            && . "$HOME/.keychain/$HOSTNAME-sh-gpg"
    else
        echo "keychain - keyfile does not exist!"
    fi
else
    # couldn't start keychain
    echo "keychain not available! Attempting ssh-agent / gpg-agent..."

    ## ssh-agent
    if type ssh-agent &>/dev/null; then
        # check that ssh-agent is not already running
        if [ -z "$SSH_AUTH_SOCK" ]; then
            # start ssh-agent
            eval $(ssh-agent -s) &>/dev/null
            # clean up when we exit
            trap "kill $SSH_AGENT_PID" 0
        fi
        echo "ssh-agent - running $SSH_AUTH_SOCK"
    else
        echo "ssh-agent - not available!?"
    fi

    ## gpg-agent
    if type gpg-agent &>/dev/null; then
        # set file name for env file
        GPG_FILE="$HOME/.gpg-agent-info"
        # check that env file exists
        if [ -f "$GPG_FILE" ] && kill -0 "$(cut -d: -f2 $GPG_FILE)" 2>/dev/null; then
            # get pid from file
            GPG_AGENT_INFO="$(cut -d= -f2 "$GPG_FILE")"
        else
            # start gpg-agent
            # TODO - investigate use of 'enable-ssh-support' here
            eval "$(gpg-agent --daemon --write-env-file "$GPG_FILE")"
        fi
        export GPG_AGENT_INFO
        echo "gpg-agent - running $GPG_AGENT_INFO"
    else
        echo "gpg-agent - not available!?"
    fi
fi
