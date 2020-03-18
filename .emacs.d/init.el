
(require 'package)
(setq package-archives
      '(("gnu" . "https://elpa.gnu.org/packages/")
        ("melpa" . "https://melpa.org/packages/")))
(package-initialize)

(setq dart-debug t)

(setq lsp-dart-sdk-dir "/usr/lib/dart/")

(let ((packages-to-install
       (seq-remove 'package-installed-p
                   '(dart-mode
                     dart-server))))
  (when packages-to-install
    (package-refresh-contents)
    (dolist (package packages-to-install)
      (package-install package))))
