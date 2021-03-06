# Necessary additions to path
if which brew &> /dev/null; then
  export PATH="/$(brew --prefix)/bin:$(brew --prefix)/sbin:$PATH";
fi

# Load the shell dotfiles, and then some:
# * ~/.path can be used to extend `$PATH`.
# * ~/.extra can be used for other settings you don’t want to commit.
for file in ~/.{bash_prompt,exports,path,aliases,functions,extra}; do
	[ -r "$file" ] && [ -f "$file" ] && source "$file";
done;
unset file;

# Case-insensitive globbing (used in pathname expansion)
shopt -s nocaseglob;

# Append to the Bash history file, rather than overwriting it
shopt -s histappend;

# Autocorrect typos in path names when using `cd`
shopt -s cdspell;

# Enable some Bash 4 features when possible:
# * `autocd`, e.g. `**/qux` will enter `./foo/bar/baz/qux`
# * Recursive globbing, e.g. `echo **/*.txt`
for option in autocd globstar; do
	shopt -s "$option" 2> /dev/null;
done;

# Add tab completion for many Bash commands
if which brew &> /dev/null && [ -f "$(brew --prefix)/share/bash-completion/bash_completion" ]; then
	source "$(brew --prefix)/share/bash-completion/bash_completion";
elif [ -f /etc/bash_completion ]; then
	source /etc/bash_completion;
fi;

# Enable tab completion for `g` by marking it as an alias for `git`
if type _git &> /dev/null && [ -f /usr/local/etc/bash_completion.d/git-completion.bash ]; then
	complete -o default -o nospace -F _git g;
fi;

# Add tab completion for SSH hostnames based on ~/.ssh/config, ignoring wildcards
[ -e "$HOME/.ssh/config" ] && complete -o "default" -o "nospace" -W "$(grep "^Host" ~/.ssh/config | grep -v "[?*]" | cut -d " " -f2- | tr ' ' '\n')" scp sftp ssh;

# Add tab completion for `defaults read|write NSGlobalDomain`
# You could just use `-g` instead, but I like being explicit
complete -W "NSGlobalDomain" defaults;

# nvm & avn
if [ -f "$(brew --prefix)/opt/nvm/nvm.sh" ]; then
    . "$(brew --prefix)/opt/nvm/nvm.sh";
fi

# chruby
if [ -f "$(brew --prefix)/opt/chruby/share/chruby/chruby.sh" ]; then
    source "$(brew --prefix)/opt/chruby/share/chruby/chruby.sh";
    source "$(brew --prefix)/opt/chruby/share/chruby/auto.sh";
fi

# pyenv
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)";
  eval "$(pyenv virtualenv-init -)";
fi

# jenv
if command -v jenv 1>/dev/null 2>&1; then
  eval "$(jenv init -)";
fi

# phpenv
if command -v phpenv 1>/dev/null 2>&1; then
  eval "$(phpenv init -)";
fi

# plenv
if command -v plenv 1>/dev/null 2>&1; then
  eval "$(plenv init -)";
fi

# z
if [ -f $(brew --prefix)/etc/profile.d/z.sh ]; then
    . "$(brew --prefix)/etc/profile.d/z.sh";
fi
