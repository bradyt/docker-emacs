
(require 'package)

;; (unless package-archive-contents
;;   (package-refresh-contents))

;;; --- BEGIN Ansible addition ---
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.

 '(package-archives
   '(("gnu" . "http://elpa.gnu.org/packages/")
     ("melpa-stable" . "http://stable.melpa.org/packages/")))
 '(haskell-program-name "ghci")
 '(inferior-lisp-program "clisp" t)
 '(inhibit-startup-screen t)
 '(menu-bar-mode 0)
 '(next-line-add-newlines t)
 '(org-agenda-files '("~/.notes"))
 '(scheme-program-name "guile")
)
(menu-bar-mode 0)
(package-initialize)

(unless package-archive-contents
  (package-refresh-contents))

(mapc 'package-install
      (seq-remove 'package-installed-p '(use-package)))

;;; --- END Ansible addition ---
(set-terminal-coding-system 'utf-8)

;; haskell specific below here

;; haskell
(use-package haskell-mode
  :ensure t
  :init
  (progn
    (add-hook 'haskell-mode-hook 'turn-on-haskell-doc-mode)
    (add-hook 'haskell-mode-hook 'turn-on-haskell-indent)
    (add-hook 'haskell-mode-hook 'interactive-haskell-mode)
    (setq haskell-process-args-cabal-new-repl
	  '("--ghc-options=-ferror-spans -fshow-loaded-modules"))
    (setq haskell-process-type 'cabal-new-repl)
    (setq haskell-stylish-on-save 't)
    (setq haskell-tags-on-save 't)
    ))

(use-package flycheck-haskell
  :ensure t
  :config
  (add-hook 'flycheck-mode-hook #'flycheck-haskell-setup)
  (eval-after-load 'haskell-mode-hook 'flycheck-mode))


(use-package flymake-hlint
  :ensure t
  :config
  (add-hook 'haskell-mode-hook 'flymake-hlint-load))

(defconst newline-string "\012")
(defconst newline-string-2 (concat newline-string newline-string))
(defun unfill-paragraph ()
  (interactive)
  (backward-paragraph)
  (skip-chars-forward newline-string)
  (let ((start (point)))
    (forward-paragraph)
    (skip-chars-backward newline-string)
    (let ((end (point)))
      (goto-char start)
      (while (search-forward newline-string end t)
        (replace-match " " nil t)))))

(defun unfill-region (start end)
  (interactive "r")
  (if (equal mode-name "Shell")
      (error "this doesn't work in shell mode"))
  (save-excursion
    (save-restriction
      (narrow-to-region start end)
      (goto-char (point-min))
      (let ((pat (concat newline-string newline-string "+")))
          (while (re-search-forward pat nil t)
            (replace-match "<p>" nil nil)))
      (goto-char (point-min))
      (save-excursion
        (unfill-paragraph)
        (if (listp current-prefix-arg)
            (replace-string "<p>" newline-string-2 nil (point-min) (point-max))))
      (x-select-text
       (buffer-substring-no-properties
        (point-min) (point-max))))))

(defun insert-timestamp ()
  (interactive)
  (insert (format-time-string "%a %b %d %T %Z %Y\n")))

(setq gnutls-min-prime-bits 2048)

;; The following lines are always needed.  Choose your own keys.
;; (add-hook 'org-mode-hook 'turn-on-font-lock) ; not needed when global-font-lock-mode is on
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cb" 'org-iswitchb)

(defvar org-directory "~/org")
(defvar org-default-notes-file (concat org-directory "/notes.org"))
(define-key global-map "\C-cc" 'org-capture)
(defvar org-log-done t)

(put 'narrow-to-region 'disabled nil)

(put 'erase-buffer 'disabled nil)
(setq-default indent-tabs-mode nil)

(defun wipe ()
  (interactive)
  (let ((inhibit-read-only t))
    (erase-buffer)))

(defun remove-region-read-only (begin end)
  (interactive "r")
  (let ((inhibit-read-only t))
    (remove-text-properties begin end '(read-only t))))
(put 'downcase-region 'disabled nil)
