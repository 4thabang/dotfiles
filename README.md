## My .dotfiles

These `.dotfiles` use a git bare repo to keep track of them in a maintainable manner.

Link: [Git Dotfiles Bare Repo](https://www.atlassian.com/git/tutorials/dotfiles)

```bash
# Initial Setup

git init --bare $HOME/.dotfiles

echo "alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'" >> $HOME/.zshrc # or .bashrc

source ~/.zshrc # or, ~/.bashrc

dotfiles config --local status.showUntrackedFiles no
```
```bash
# Usage + Commit

dotfiles status

dotfiles add init.lua

dotfiles commit -m "ft: add init.lua"

dotfiles remote add origin https://github.com/<USERNAME>/dotfiles.git

dotfiles push origin main
```

```bash
# Usage on New System

echo "alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'" >> $HOME/.zshrc # or .bashrc

source ~/.zshrc # or, ~/.bashrc

echo ".dotfiles" >> .gitignore

git clone --bare https://github.com/<USERNAME>/dotfiles.git $HOME/.dotfiles

dotfiles checkout

dotfiles config --local status.showUntrackedFiles no
```
---
**DISCLAIMER**: Note that if you already have some of the files you'll get an error message. You can either (1) delete them or (2) back them up somewhere else.
