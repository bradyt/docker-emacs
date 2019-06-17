(setq package-archives
      '(("gnu" . "https://elpa.gnu.org/packages/")
        ("melpa" . "https://melpa.org/packages/")))
(package-initialize)

(unless package-archive-contents
  (package-refresh-contents))

(mapc 'package-install
      (seq-remove 'package-installed-p '(lsp-java)))

(add-hook 'java-mode-hook (defun my-set-java-tab-width () (setq tab-width 2)))
(setq lsp-java-format-settings-url "https://raw.githubusercontent.com/google/styleguide/gh-pages/eclipse-java-google-style.xml")
(setq lsp-java-format-settings-profile "GoogleStyle")

(require 'cc-mode)

(setcdr (assoc 'java-mode c-default-style) "java-google-style-indentation")

(c-add-style "java-google-style-indentation"
             '((c-basic-offset . 2)
               (c-offsets-alist
                (topmost-intro . 0)
                (inclass . +)
                (defun-block-intro . +)
                (inexpr-class . 0)
                (case-label . +)
                (statement-case-intro . +)
                (statement-block-intro . +)
                (statement-cont . ++))))
