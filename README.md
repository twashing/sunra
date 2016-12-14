# Sunra

Yet another .emacs.d

![Sun Ra](http://media.npr.org/assets/img/2014/05/21/sun-ra-in-text1-cb4036fa5068a4f9afd4b56bf6c55bb176415eaf-s900-c85.jpg)

> The Music is different here. The vibrations are different. Not like Planet Earth.


## Introduction

Sunra emacs is an attempt to make a light, fast-loading ***.emacs.d*** . It leverages the functionality in John Wiegley's [use-package](https://github.com/jwiegley/use-package).

Just git clone (or download) this repo, to your `~/.emacs.d` directory. With that, initial use will download all necessary packages. Afterwards, emacs loading should be fast (aiming for under 2 seconds).


## Requirements

- emacs 24+
- package.el (bundled with emacs 24)
- clojure's cider package requires `[cider/cider-nrepl "0.9.0-SNAPSHOT"]` in ***.lein/profiles***


## Commands

| Command Group   | Binding       |
|-----------------|---------------|
| Move            | `C-c m`       |
| Transpose       | `C-c t r`     |
| Goto            | `C-c G`       |
| Window          | `C-c w`       |
| Projectile      | `C-c P` main  |
|                 | `C-c O` other |
| Smartparens     | `C-c S`       |
|                 | `C-c S / a`   |  *sp-splice-sexp*
|                 | `C-c S / da`  |  *sp-splice-sexp-killing-around*
|                 | `C-c S / df`  |  *sp-splice-sexp-killing-forward*
|                 | `C-c S / db`  |  *sp-splice-sexp-killing-backward*
| Multiplecursors | `C-c M`       |
|                 | `C-?`         |  *mc/mark-next-lines*
|                 | `C-M-?`       |  *mc/mark-all-in-region*
| Iedit           | `C-c ;`       |
| Yasnippet       | `C-c Y`       |
| Helm            | `\\` inlined  |
| Ivy             | `C-c i`       |


| Navigation                   | Binding   |
|------------------------------|-----------|
| crux-move-beginning-of-line  | `C-a`     |
| buf-move-up                  | `M-U`     |
| buf-move-down                | `M-D`     |
| crux-smart-open-line-above   | `C-x M-o` |
| crux-smart-open-line         | `C-x o`   |
| sp-kill-sexp                 | `C-d`     |
| copy-sexp-at-point           | `C-M-k`   |
| search-symbol-at-point       | `C-x M-x` |
| search project (helm-ag)     | `C-/`     |
| grep-find                    | `C-x C-g` |
| magit-status                 | `C-x C-m` |
| ace-select-window            | `M-[`     |
| ace-swap-window              | `C-c M-p` |
| ace-delete-window            | `C-x M-p` |
| browse-kill-ring             | `M-y`     |
| delete-whitespace-except-one | `M-SPC`   |
| scroll-other-window-down     | `C-M-[`   |
| scroll-other-window          | `C-M-]`   |
| expand-region                | `M-h`     |
| contract-region              | `C-M-h`   |


| Other                        | Binding      |
|------------------------------|--------------|
| projectile-replace           | `C-,`        |
| projectile-replace-regexp    | `C-M-,`      |
| crux-kill-other-buffers      | C-<backtick> | 
| crux-rename-buffer-and-file  | `C-<`        |
| crux-delete-buffer-and-file  | `C->`        |


| Clojure      | Binding      |
|--------------|--------------|
| clj-refactor | `C-c C-b hh` |
| cheatsheet   | `C-c C-h`    |


## Todo

- Themes (on desktop vs terminal)
- Zenburn
- Cyberpunk (current)
- Solarized
- Documentation for All Modes:
- User Localization (~/.sunra.d/)
- Navigation
