# company-emoji.el

[![Melpa Status](http://melpa.org/packages/company-emoji-badge.svg)](http://melpa.org/#/company-emoji)
[![Melpa Stable Status](http://stable.melpa.org/packages/company-emoji-badge.svg)](http://stable.melpa.org/#/company-emoji)

[company-mode](https://github.com/company-mode/company-mode/) backend
providing autocompletion for emoji. 🆒💦

## setup

Add `company-emoji.el` to your load-path, then add something like the
following to your init file:

```elisp
(require 'company-emoji)
(add-to-list 'company-backends 'company-emoji)
```

After selecting an emoji-word from the completion-list, it will be
replaced by the real unicode emoji (`:cactus:` becomes 🌵, `:cat:`
becomes 🐱, etc.)

### emoji font support

If you’re on Linux, or on Mac OS X and using the Cocoa version of
Emacs (i.e., if built `‐-with-ns`, or `--with-cocoa` using Homebrew),
you’ll need to add something like this to your init file (thanks to
[@syohex](https://github.com/syohex) and
[@waymondo](https://github.com/waymondo)):

```elisp
(defun --set-emoji-font (frame)
  "Adjust the font settings of FRAME so Emacs can display emoji properly."
  (if (eq system-type 'darwin)
      ;; For NS/Cocoa
      (set-fontset-font t 'symbol (font-spec :family "Apple Color Emoji") frame 'prepend)
    ;; For Linux
    (set-fontset-font t 'symbol (font-spec :family "Symbola") frame 'prepend)))

;; For when Emacs is started in GUI mode:
(--set-emoji-font nil)
;; Hook for when a frame is created with emacsclient
;; see https://www.gnu.org/software/emacs/manual/html_node/elisp/Creating-Frames.html
(add-hook 'after-make-frame-functions '--set-emoji-font)
```

[Symbola](https://zhm.github.io/symbola/) can be installed with `apt-get`:

```sh
apt-get install ttf-ancient-fonts
```

**NB:** The `set-fontset-font` function is apparently only available
 when Emacs has been compiled with a window system.

### custom variables

#### aliases

You can add shortcode aliases by modifying `company-emoji-aliases`.
Run `M-x customize-variable [RET] company-emoji-aliases` to bring up
company-emoji’s customization pane, then add or remove aliases to your
taste:

```
Hide Company Emoji Aliases:
[INS] [DEL] Symbol: :man-woman-boy:
            String: :family:
[INS] [DEL] Symbol: :woman-kiss-man:
            String: :couplekiss:
[INS] [DEL] Symbol: :woman_man_holding_hands:
            String: :couple:
[INS] [DEL] Symbol: :woman-heart-man:
            String: :couple_with_heart:
[INS] [DEL] Symbol: :oop:
            String: :speak_no_evil:
[INS]
```

(“Symbol” designates the user-defined alias, and “string” designates
the original shortcode you want your alias to mimick.)

Occasionally new default aliases may be added (like `:middle-finger:`
for 🖕). If you’re upgrading and have modified the
`company-emoji-alises` variable, the new aliases will be ignored;
you’ll need to add them manually.

#### unicode replacement

By default, `:cat:` is replaced with 🐱 upon completion, but that can
be turned off by setting the variable `company-emoji-insert-unicode`
to `nil`.
