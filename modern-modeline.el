;;; modern-modeline.el --- A Modern mode-line configuration for Emacs -*- lexical-binding: t; -*-

;; Author: Eder Elorriaga <gexplorer8@gmail.com>
;; URL: https://github.com/gexplorer/simple-modeline
;; Keywords: mode-line faces
;; Version: 1.1
;; Package-Requires: ((emacs "26.1"))

;; Copyright (C) 2019  Eder Elorriaga

;; Author: Eder Elorriaga <gexplorer8@gmail.com>
;; URL: https://github.com/gexplorer/simple-modeline
;; Keywords: mode-line
;; Version: 1.0

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

;; A Modern mode-line configuration for Emacs.
;; To enable, put this code in your init file:
;; (require 'modern-modeline)
;; (modern-modeline-mode 1)
;; or
;; (use-package modern-modeline
;;   :ensure t
;;   :hook (after-init . modern-modeline-mode))
;;

;;; Code:

(require 'modern-modeline-core)
(require 'modern-modeline-segments)

(defvar modern-modeline--mode-line
  '((:eval
     (modern-modeline--format
      '(modern-modeline-segment-modified
        modern-modeline-segment-buffer-name
        modern-modeline-segment-position)
      '(modern-modeline-segment-minions-mode
        modern-modeline-segment-minor-modes
        modern-modeline-segment-input-method
        modern-modeline-segment-eol
        modern-modeline-segment-encoding
        modern-modeline-segment-vc
        modern-modeline-segment-misc-info
        modern-modeline-segment-process
        modern-modeline-segment-major-mode)))))

;;;###autoload
(define-minor-mode modern-modeline-mode
  "Minor mode to get a modern mode line.

When called interactively, toggle
`modern-modeline-mode'.  With prefix ARG, enable
`modern-modeline--mode' if ARG is positive, otherwise
disable it.

When called from Lisp, enable `modern-modeline-mode' if ARG is omitted,
nil or positive.  If ARG is `toggle', toggle `modern-modeline-mode'.
Otherwise behave as if called interactively."
  :init-value nil
  :keymap nil
  :lighter ""
  :group 'modern-modeline
  :global t
  (if modern-modeline-mode
      (progn
        ;; Set the new mode-line-format
        (setq-default mode-line-format '(:eval modern-modeline--mode-line)))
    (progn
      ;; Restore the original mode-line format
      (setq-default mode-line-format modern-modeline--default-mode-line))))

(provide 'modern-modeline)
;;; modern-modeline.el ends here
