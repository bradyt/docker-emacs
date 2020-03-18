
(setq package-archives
      '(("gnu" . "https://elpa.gnu.org/packages/")
        ("melpa" . "https://melpa.org/packages/")))

(package-refresh-contents)

(dolist (pkg '(dart-mode
               lsp-mode
               dart-server))
  (package-install pkg))
