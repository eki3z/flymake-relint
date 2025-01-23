# Flymake-relint

[![License GPL 3](https://img.shields.io/badge/license-GPL_3-green.svg?style=flat)](LICENSE)
[![MELPA](http://melpa.org/packages/flymake-relint.svg)](http://melpa.org/#/flymake-relint)

Flymake is the built-in Emacs package to support on-the-fly syntax checking.
This library provides a Flymake backend for rx and string regular expressions in Emacs Lisp files, using [relint][relint].

Ported from [flycheck-relint](https://github.com/purcell/flycheck-relint)

It requires Emacs 26 at least.

<!-- markdown-toc start -->

## Contents

- [Flymake-relint](#flymake-relint)
  - [Install](#install)
    - [dependencies](#dependencies)
    - [package](#package)
  - [Usage](#usage)

<!-- markdown-toc end -->

## Install

### dependencies

- emacs, version >= 28.1
- [relint][relint]

### package

- Manually

Clone and add to `load-path`, require the package.

- Melpa

This package is available on [MELPA][melpa].
Install with `M-x package-install` `RET` `flymake-relint` within Emacs.

## Usage

```emacs-lisp
(require 'flymake-relint)
(add-hook 'emacs-lisp-mode-hook #'flymake-relint-setup)
(add-hook 'lisp-interaction-mode-hook #'flymake-relint-setup)
```

[relint]: https://github.com/mattiase/relint
[melpa]: http://melpa.org/#/flymake-relint
