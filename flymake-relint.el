;;; flymake-relint.el --- A relint Flymake backend -*- lexical-binding: t -*-

;; Copyright (C) 2023-2025 Eki Zhang

;; Author: Eki Zhang <liuyinz95@gmail.com>
;; Maintainer: Eki Zhang <liuyinz95@gmail.com>
;; Version: 0.1.0
;; Package-Requires: ((emacs "26.1") (relint "1.23"))
;; Keywords: lisp
;; Homepage: https://github.com/eki3z/flymake-relint

;; This file is not a part of GNU Emacsl.

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <https://www.gnu.org/licenses/>.

;;; Commentary:

;; Ported from https://github.com/purcell/flycheck-relint

;; Flymake is the built-in Emacs package to support on-the-fly syntax
;; checking.  This library adds support for flymake to `relint'.
;; It requires Emacs 26.

;; Enable it by calling `flymake-relint-setup' from a
;; file-visiting buffer.  To enable in all `emacs-lisp-mode' buffers:

;; (add-hook 'emacs-lisp-mode-hook #'flymake-relint-setup)

;;; Code:

(eval-when-compile
  (require 'cl-lib))
(require 'flymake)
(require 'relint)

(declare-function flymake-make-diagnostic "flymake")

(defun flymake-relint (report-fn &rest _args)
  "A Flymake backend for `relint'.
Use `relint-flymake-setup' to add this to
`flymake-diagnostic-functions'.  Calls REPORT-FN directly."
  (let ((collection (relint-buffer (current-buffer))))
    (cl-loop for diag in collection
             collect
             (flymake-make-diagnostic
              (current-buffer)
              (relint-diag-beg-pos diag)
              (relint-diag-end-pos diag)
              (cl-case (relint-diag-severity diag)
                (error :error)
                (warning :warning)
                (info :note))
              (relint-diag-message diag))
             into diags
             finally (funcall report-fn diags))))

;;;###autoload
(defun flymake-relint-setup ()
  "Setup relint integration with Flymake."
  (interactive)
  (if (< emacs-major-version 26)
      (error "Package-lint-flymake requires Emacs 26 or later")
    (add-hook 'flymake-diagnostic-functions #'flymake-relint nil t)
    (flymake-mode)))

(provide 'flymake-relint)
;;; flymake-relint.el ends here
