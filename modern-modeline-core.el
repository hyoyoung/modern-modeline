;;; modern-modeline-core.el --- The core libraries for modern-modeline -*- lexical-binding: t; -*-

;; Copyright (C) 2019  Eder Elorriaga

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

;; The core libraries for modern-modeline.

;;; Code:

(defgroup modern-modeline nil
  "A Modern mode line."
  :prefix "modern-modeline-"
  :group 'mode-line)

(defvar modern-modeline--default-mode-line mode-line-format
  "The former value of `mode-line-format'.")

;;
;; Faces
;;

(defface modern-modeline-unimportant
  '((t (:inherit (shadow))))
  "Face used for less important mode-line elements.")

(defface modern-modeline-status-modified
  '((t (:inherit (font-lock-variable-name-face))))
  "Face used for the 'modified' indicator symbol in the mode-line.")

(defface modern-modeline-status-info
  '((t (:inherit (font-lock-string-face))))
  "Face used for generic status indicators in the mode-line.")

(defface modern-modeline-status-success
  '((t (:inherit (success))))
  "Face used for success status indicators in the mode-line.")

(defface modern-modeline-status-warning
  '((t (:inherit (warning))))
  "Face for warning status indicators in the mode-line.")

(defface modern-modeline-status-error
  '((t (:inherit (error))))
  "Face for error stauts indicators in the mode-line.")

;;
;; Helpers
;;

(defmacro modern-modeline-create-segment (name doc &rest body)
  "Create a new segment with NAME, DOC and BODY function for `modern-modeline-mode'."
  (let ((segment (intern (format "modern-modeline-segment-%s" name)))
        (toggle (intern (format "modern-modeline-toggle-%s" name)))
        (show (intern (format "modern-modeline-show-%s" name))))
    `(progn
       (defcustom ,show t
         ,(format "Visibility of the %s segment of the mode-line." name)
         :group 'modern-modeline
         :type 'boolean)
       (defun ,toggle ()
         ,(format "Toggle visibility of %s segment of the mode-line." name)
         (interactive)
         (customize-save-variable (quote ,show) (not ,show)))
       (defalias
         (quote ,segment)
         (lambda ()
           (when ,show
             ,@body))
         ,doc))))

(defun modern-modeline--format (left-segments right-segments)
  "Return a string of `window-width' length containing LEFT-SEGMENTS and RIGHT-SEGMENTS, aligned respectively."
  (let* ((left (modern-modeline--format-segments left-segments))
         (right (modern-modeline--format-segments right-segments))
         (reserve (length right)))
    (concat
     left
     (propertize " " 'display `((space :align-to (- right ,reserve))))
     right)))

(defun modern-modeline--format-segments (segments)
  "Return a string from a list of SEGMENTS."
  (format-mode-line (mapcar
                     (lambda (segment)
                       `(:eval (,segment)))
                     segments)))

(provide 'modern-modeline-core)
;;; modern-modeline-core.el ends here
