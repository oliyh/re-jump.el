(require 'cider-util)
(require 'cider-resolve)
(require 'cider-client)
(require 'cider-common)
(require 'cider-interaction)

(defun re-frame-jump-to-reg ()
  (interactive)
  (let* ((kw (cider-symbol-at-point 'look-back))
         (ns-qualifier (and
                        (string-match "^:+\\(.+\\)/.+$" kw)
                        (match-string 1 kw)))
         (kw-ns (or (and ns-qualifier
                         (cider-resolve-alias (cider-current-ns) ns-qualifier))
                    (cider-current-ns)))
         (target-file (cider-sync-request:ns-path kw-ns))
         (kw-to-find (concat "::" (replace-regexp-in-string "^:+\\(.+/\\)?" "" kw)))
         (buffer (cider--find-buffer-for-file target-file)))

    (if buffer
        (progn (cider-jump-to buffer)
               (search-forward-regexp (concat "reg-[a-zA-Z-]*[ \\\n]+" kw-to-find) nil 'noerror))
      (error (concat "No source location")))))
      
(global-set-key (kbd "M->") 're-frame-jump-to-reg)
      
(provide 're-jump)
