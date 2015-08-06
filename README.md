# company-emoji.el

[company-mode](https://github.com/company-mode/company-mode/) backend
providing autocompletion for emoji. 🆒💦

## setup

Add `company-emoji.el` to your load-path, then add something like the
following to your init file (`company-emoji-init` doesn’t start
company-mode):

```elisp
(require 'company-emoji)
(add-hook 'markdown-mode-hook 'company-mode)
(add-hook 'markdown-mode-hook 'company-emoji-init)
```

After selecting an emoji-word from the completion-list, it will be
replaced by the real unicode emoji (`:cactus:` becomes 🌵, `:cat:`
becomes 🐱, etc.)

### cocoa/ns emacs

If you’re using the cocoa version of Emacs (i.e., if built
 `‐-with-ns`, or `--with-cocoa` using Homebrew), you’ll need to add
 something like this to your init file (thanks [@waymondo](https://github.com/waymondo)!):

```elisp
(defun darwin-set-emoji-font (frame)
"Adjust the font settings of FRAME so Emacs NS/Cocoa can display emoji properly."
  (if (eq system-type 'darwin)
    (set-fontset-font t 'symbol (font-spec :family "Apple Color Emoji") frame 'prepend)))
;; For when emacs is started with Emacs.app
(darwin-set-emoji-font nil)
;; Hook for when a cocoa frame is created with emacsclient
;; see https://www.gnu.org/software/emacs/manual/html_node/elisp/Creating-Frames.html
(add-hook 'after-make-frame-functions 'darwin-set-emoji-font)
```
