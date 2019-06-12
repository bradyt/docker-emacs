(setq package-archives
      '(("gnu" . "https://elpa.gnu.org/packages/")
        ("melpa" . "https://melpa.org/packages/")
        ("org" . "https://orgmode.org/elpa/")))
(package-initialize)

(unless package-archive-contents
  (package-refresh-contents))

(mapc 'package-install
      (seq-remove 'package-installed-p '(put
                                         your
                                         list
                                         of
                                         packages
                                         here)))
