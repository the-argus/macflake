#!/bin/sh

sudo nix run --extra-experimental-features nix-command --extra-experimental-features flakes nix-darwin -- switch --flake .
