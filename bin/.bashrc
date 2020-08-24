if command -v cardano-cli >/dev/null 2>&1 ; then
    source <(cardano-cli  --bash-completion-script cardano-cli)
fi

if command -v cardano-node >/dev/null 2>&1 ; then
    source <(cardano-node --bash-completion-script cardano-node)
fi
