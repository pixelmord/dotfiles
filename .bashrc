[ -n "$PS1" ] && source ~/.bash_profile
# tabtab source for serverless package
# uninstall by removing these lines or running `tabtab uninstall serverless`
[ -f /Users/andreassahle/workspace/technews/node_modules/tabtab/.completions/serverless.bash ] && . /Users/andreassahle/workspace/technews/node_modules/tabtab/.completions/serverless.bash
# tabtab source for sls package
# uninstall by removing these lines or running `tabtab uninstall sls`
[ -f /Users/andreassahle/workspace/technews/node_modules/tabtab/.completions/sls.bash ] && . /Users/andreassahle/workspace/technews/node_modules/tabtab/.completions/sls.bash
# tabtab source for slss package
# uninstall by removing these lines or running `tabtab uninstall slss`
[ -f /Users/andreassahle/workspace/technews/node_modules/tabtab/.completions/slss.bash ] && . /Users/andreassahle/workspace/technews/node_modules/tabtab/.completions/slss.bash
export VOLTA_HOME="$HOME/.volta"
export PATH="$VOLTA_HOME/bin:$PATH"
