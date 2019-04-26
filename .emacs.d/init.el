
(require 'package)
(setq package-archives
      '(("gnu" . "https://elpa.gnu.org/packages/")
        ("melpa" . "https://melpa.org/packages/")))
(package-initialize)

(setq dart-debug t)
(define-advice dart--run-process (:override (executable &rest args) return-nil)
  nil)

(unless (package-installed-p 'dart-mode)
    (package-refresh-contents)
    (package-install 'dart-mode))
