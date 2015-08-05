# company-emoji.el

[company-mode](https://github.com/company-mode/company-mode/) backend
providing autocompletion for emoji. 🆒💦

## setup

Add `company-emoji.el` to your load-path, then add something like the
following to your init file:

```elisp
(require 'company-emoji)
(add-hook 'markdown-mode-hook 'company-emoji-init)
(add-hook 'mail-mode-hook 'company-emoji-init)
(add-hook 'text-mode-hook 'company-emoji-init)
```

After selecting an emoji-word from the completion-list, it will be
replaced by the real unicode emoji (`:cactus:` becomes 🌵, `:cat:`
becomes 🐱, etc.)

*NB:*  I haven’t been able to get the cocoa version of Emacs to handle
 emoji (i.e., if built `‐-with-ns`, or `--with-cocoa` using
 Homebrew).  It should work in the terminal or with X11, though.
