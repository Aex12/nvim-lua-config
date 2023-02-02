#!/bin/bash
if ! command -v npm &>/dev/null; then echo "required npm"; exit 1; fi
if ! command -v tree-sitter &>/dev/null; then npm install --global tree-sitter-cli; fi

# native
sudo dnf install fd-find ripgrep

echo Everything is set! Use lvi
