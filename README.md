# Sunra

Yet another .emacs.d 

![Sun Ra](http://www.sensitiveskinmagazine.com/wp-content/images/blog/sun-ra.jpg)

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
| Goto            | `C-c g`       |
| Wind-w          | `C-c w`       |
| Proj-ctile      | main `C-c P`  |
|                 | other `C-c O` |
| Smar-parens     | `C-c S`       |
| Mult-plecursors | `C-c M`       |
| Yasn-ppet       | `C-c Y`       |
| Helm            | inlined `\\`  |


## TODO

- Themes (on desktop vs terminal)
  - Zenburn
  - Cyberpunk (current)
  - Solarized
- Documentation for All Modes: 
  - User Localization (~/.sunra.d/)
  - Navigation
