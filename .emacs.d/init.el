(setq package-archives
      '(("gnu" . "https://elpa.gnu.org/packages/")
        ("melpa" . "https://melpa.org/packages/")))
(package-initialize)

(unless package-archive-contents
  (package-refresh-contents))

(mapc 'package-install
      (seq-remove 'package-installed-p '(helm)))

(helm-mode)
