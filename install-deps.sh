#!/bin/bash
if ! command -v npm &>/dev/null; then echo "required npm"; exit 1; fi
if ! command -v tree-sitter &>/dev/null; then npm install --global tree-sitter-cli; fi

# native deps
unameOut="$(uname -s)"
case "${unameOut}" in
    Linux*)     MACHINE_OS=Linux;;
    Darwin*)    MACHINE_OS=Darwin;;
    *)          MACHINE_OS="UNKNOWN:${unameOut}"
esac

if [ "$MACHINE_OS" == "Linux"]; then
  RCFILE="~/.bashrc"
  sudo dnf install fd-find ripgrep
elif [ "$MACHINE_OS" == "Darwin" ]; then
  RCFILE="~/.zshrc"
  brew install fd ripgrep
else
  echo "OS Not Supported ${unameOut}"
  exit 1
fi

pip3 install neovim-remote

mkdir -p ~/.local/bin
cp lvi ~/.local/bin/lvi
chmod +x ~/.local/bin/lvi

if ! command -v lvi &>/dev/null; then
  echo "export PATH=\"\$PATH:~/.local/bin\"" >> "$RCFILE"
fi

echo Everything is set! Use lvi
