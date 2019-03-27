;;; re-jump.el --- emacs navigation for re-frame projects

;; Copyright © 2017 Oliver Hine
;;
;; Author: Oliver Hine

;; This program is free software: you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;; This file is not part of GNU Emacs.

;;; Commentary:

;; Jump to registrations of re-frame subscriptions, event handlers and fx

;;; Code:
(require 'cider-util)
(require 'cider-resolve)
(require 'cider-client)
(require 'cider-common)
(require 'cider-find)
(require 'clojure-mode)

(defun re-frame-jump-to-reg ()
  (interactive)
  (let* ((kw (cider-symbol-at-point 'look-back))
         (ns-qualifier (and
                        (string-match "^:+\\(.+\\)/.+$" kw)
                        (match-string 1 kw)))
         (kw-ns (if ns-qualifier
                    (cider-resolve-alias (cider-current-ns) ns-qualifier)
                  (cider-current-ns)))
         (kw-to-find (concat "::" (replace-regexp-in-string "^:+\\(.+/\\)?" "" kw))))

    (when (and ns-qualifier (string= kw-ns (cider-current-ns)))
      (error "Could not resolve alias \"%s\" in %s" ns-qualifier (cider-current-ns)))

    (progn (cider-find-ns "-" kw-ns)
           (search-forward-regexp (concat "reg-[a-zA-Z-]*[ \\\n]+" kw-to-find) nil 'noerror))))

(global-set-key (kbd "M->") 're-frame-jump-to-reg)

(provide 're-jump)
;;; re-jump.el ends here
