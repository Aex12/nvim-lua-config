#!/bin/bash
if ! command -v npm &>/dev/null; then echo "required npm"; exit 1; fi
if ! command -v tree-sitter &>/dev/null; then npm install --global tree-sitter-cli; fi

# native deps
unameOut="$(uname -s)"
case "${unameOut}" in
    Linux*)     machine=Linux;;
    Darwin*)    machine=Mac;;
    *)          machine="UNKNOWN:${unameOut}"
esac

if [ "$machine" == "Mac" ]; then
  brew install fd ripgrep
else 
  sudo dnf install fd-find ripgrep
fi
echo Everything is set! Use lvi
