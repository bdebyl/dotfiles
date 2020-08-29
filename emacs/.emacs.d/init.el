(require 'package)
(setq package-enable-at-startup nil)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/"))
(package-initialize)

;; Fetch the list of packages available
(unless package-archive-contents
  (package-refresh-contents))

;;                     _                   _
;;  _  _ ___ ___ _ _  | |___ __ _____ __ _| |__ ___
;; | || (_-</ -_) '_| |  _\ V  V / -_) _` | / /(_-<
;;  \_,_/__/\___|_|    \__|\_/\_/\___\__,_|_\_\/__/
;; Highlight line
(add-hook 'after-init-hook 'global-hl-line-mode)

;; Enable line numbers
(add-hook 'after-init-hook 'global-linum-mode)

;; Change font size
(set-face-attribute 'default nil :height 80)

;; disable the tool bar
(tool-bar-mode -1)
(menu-bar-mode -1)

;; delete selection mode
(delete-selection-mode 1)

;; JSON indent to 2-spaces
(add-hook 'json-mode-hook
          (lambda ()
            (make-local-variable 'js-indent-level)
            (setq js-indent-level 2)))

;; Recent file mode
(recentf-mode 1)

;; Fix for TRAMP to use ssh-agent
(setenv "SSH_AUTH_SOCK" (concat (getenv "HOME") "/.ssh_auth_sock"))


;;          _               _
;;  _____ _| |_ ___ _ _  __(_)___ _ _  ___
;; / -_) \ /  _/ -_) ' \(_-< / _ \ ' \(_-<
;; \___/_\_\\__\___|_||_/__/_\___/_||_/__/
;; crontab-mode
(add-to-list 'auto-mode-alist '("\\.crontab\\'" . crontab-mode))

;; conf-mode
(add-to-list 'auto-mode-alist '("\\.bash.*\\'" . conf-mode))
(add-to-list 'auto-mode-alist '("config\\'" . conf-mode))
(add-to-list 'auto-mode-alist '("\\..*rc\\'" . conf-mode))

;; web-mode
(add-to-list 'auto-mode-alist '("\\.css$" . web-mode))
(add-to-list 'auto-mode-alist '("\\.html$" . web-mode))
(add-to-list 'auto-mode-alist '("\\.js$" . web-mode))
(add-to-list 'auto-mode-alist '("\\.etlua$" . web-mode))

;; jinja2-mode
(add-to-list 'auto-mode-alist '("\\.j2$" . jinja2-mode))

;; perl-mode
(add-to-list 'auto-mode-alist '("\\.mc$" . perl-mode))

;; yaml-mode
(add-to-list 'auto-mode-alist '("\\.yml$" . yaml-mode))

;; ansible-mode
(add-hook 'yaml-mode-hook '(lambda () (ansible 1)))

;;             _                _      __
;;  __ _  _ __| |_ ___ _ __  __| |___ / _|___
;; / _| || (_-<  _/ _ \ '  \/ _` / -_)  _(_-<
;; \__|\_,_/__/\__\___/_|_|_\__,_\___|_| /__/
(defun uniq-lines (beg end)
  "Unique lines in region.
Called from a program, there are two arguments:
BEG and END (region to sort)."
  (interactive "r")
  (save-excursion
    (save-restriction
      (narrow-to-region beg end)
      (goto-char (point-min))
      (while (not (eobp))
        (kill-line 1)
        (yank)
        (let ((next-line (point)))
          (while
              (re-search-forward
               (format "^%s" (regexp-quote (car kill-ring))) nil t)
            (replace-match "" nil nil))
          (goto-char next-line))))))

(defun add-hook-multi (function hooks)
  "Allow adding multiple hooks to one mode"
  (mapc (lambda (hook)
          (add-hook hook function))
        hooks))

;;             _             _
;;  __ _  _ __| |_ ___ _ __ | |_____ _  _ ___
;; / _| || (_-<  _/ _ \ '  \| / / -_) || (_-<
;; \__|\_,_/__/\__\___/_|_|_|_\_\___|\_, /__/
;;                                   |__/
;; Expand region
(global-set-key (kbd "C-x +") 'er/expand-region)

;; Make window taller
(global-set-key (kbd "C-x '") 'enlarge-window)

;; Init file shortcut
(global-set-key (kbd "C-c I") (lambda ()
                                (interactive)
                                (find-file user-init-file)))

;; Multiple Cursors
(global-set-key (kbd "<M-down>") 'mc/mark-next-like-this)
(global-set-key (kbd "<M-up>") 'mc/mark-previous-like-this)


;; Show recent opened files
(global-set-key (kbd "C-x C-r") 'recentf-open-files)

;; Smex
(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "M-X") 'smex-major-mode-commands)


;;                    _
;;  ____ __  __ _ _ _| |_ _ __  __ _ _ _ ___ _ _  ___
;; (_-< '  \/ _` | '_|  _| '_ \/ _` | '_/ -_) ' \(_-<
;; /__/_|_|_\__,_|_|  \__| .__/\__,_|_| \___|_||_/__/
;;                       |_|
(require 'smartparens-config)
(add-hook-multi
 'smartparens-mode
 '(prog-mode-hook
   markdown-mode-hook
   yaml-mode-hook
   org-mode-hook))

;; Rainbow delimeters
(require 'rainbow-delimiters)
(add-hook 'prog-mode-hook 'rainbow-delimiters-mode)


;;  _         _         _        _   _
;; (_)_ _  __| |___ _ _| |_ __ _| |_(_)___ _ _
;; | | ' \/ _` / -_) ' \  _/ _` |  _| / _ \ ' \
;; |_|_||_\__,_\___|_||_\__\__,_|\__|_\___/_||_|
(add-hook 'prog-mode-hook 'highlight-indent-guides-mode)
(defvaralias 'c-basic-offset 'tab-width)

(add-hook 'perl-mode-hook
          '(lambda()
             (setq indent-tabs-mode 1)))
(add-hook 'before-save-hook 'whitespace-cleanup)

;; Fill-column
(add-hook-multi
 'auto-fill-mode
 '(markdown-mode-hook org-mode-hook fundamental-mode-hook))

;; Spell Check for Markdown
(add-hook 'markdown-mode-hook 'flyspell-mode)


;;                    _                _
;;  _  _ __ _ ____ _ (_)_ __ _ __  ___| |_
;; | || / _` (_-< ' \| | '_ \ '_ \/ -_)  _|
;;  \_, \__,_/__/_||_|_| .__/ .__/\___|\__|
;;  |__/               |_|  |_|
(require 'yasnippet)
(yas-global-mode 1)


;;                  ___
;;  _ __  ___ _ __ ( _ )
;; | '_ \/ -_) '_ \/ _ \
;; | .__/\___| .__/\___/
;; |_|       |_|
(require 'py-autopep8)
(defun my-pep8 ()
  "run pep8 and jump to first message"
  (interactive)
  (pep8)
  (sleep-for 2) ; a bit of a hack but easier than using a sentinal
  (balance-windows)
  (enlarge-window (/ (window-height (next-window)) 2))
  (other-window 1)
  (goto-line 5)
  (if (> (length (thing-at-point 'word)) 0)
      (execute-kbd-macro (kbd "C-m"))
    (progn (previous-line)
           (other-window 1)))
  )
;;
(defun next-pep8-error ()
  "jump to the next pep8 error on the list"
  (interactive)
  (other-window 1)
  (next-line)
                                        ; if not a blank line hit return
  (if (> (length (thing-at-point 'word)) 0)
      (execute-kbd-macro (kbd "C-m"))
    (progn (previous-line)
           (other-window 1)))
  )


;;  _    _       _
;; (_)__| |___ _| |_ ____ __  _____ __
;; | / _` / _ \_   _(_-< '  \/ -_) \ /
;; |_\__,_\___/ |_| /__/_|_|_\___/_\_\
(require 'smex)
(require 'ido-vertical-mode)
(ido-mode 1)
(ido-vertical-mode 1)
(setq ido-vertical-define-keys 'C-n-and-C-p-only)
(smex-initialize)


;;  __ ___ _ __  _ __  __ _ _ _ _  _
;; / _/ _ \ '  \| '_ \/ _` | ' \ || |
;; \__\___/_|_|_| .__/\__,_|_||_\_, |
;;              |_|             |__/
(require 'company)
(add-hook 'after-init-hook 'global-company-mode)
(define-key company-active-map (kbd "C-n") 'company-select-next)
(define-key company-active-map (kbd "C-p") 'company-select-previous)
(define-key company-search-map (kbd "C-n") 'company-select-next)
(define-key company-search-map (kbd "C-p") 'company-select-previous)
(define-key company-search-map (kbd "C-t") 'company-search-toggle-filtering)

(add-to-list 'company-backends '(company-irony-c-headers
                                 company-irony
                                 company-go
                                 company-web-html))

(add-hook-multi 'irony-mode
                '(c++-mode-hook
                  c-mode-hook
                  objc-mode-hook))
;; (add-hook 'c++-mode-hook 'irony-mode)
;; (add-hook 'c-mode-hook 'irony-mode)
;; (add-hook 'objc-mode-hook 'irony-mode)

(add-hook 'irony-mode-hook 'irony-cdb-autosetup-compile-options)

;;                  _
;;  _  _ __ _ _ __ | |
;; | || / _` | '  \| |
;;  \_, \__,_|_|_|_|_|
;;  |__/
(require 'yaml-mode)
(add-hook 'yaml-mode-hook
          '(lambda ()
             (define-key yaml-mode-map "\C-m" 'newline-and-indent)))


;;                                 _
;;  ___ _ _ __ _ ___ _ __  ___  __| |___
;; / _ \ '_/ _` |___| '  \/ _ \/ _` / -_)
;; \___/_| \__, |   |_|_|_\___/\__,_\___|
;;         |___/
(org-version)
(require 'org-journal)
(require 'org-brain)
(define-key global-map "\C-cc" 'org-capture)
(setq org-capture-templates
      '(("t" "Todo" entry
         (file+headline "~/org/gtd.org" "Tasks") "* TODO %?\n  %i\n  %a")
        ("j" "Journal" entry
         (file+datetree "~/org/journal.org") "* %?\nEntered on %U\n  %i\n  %a")))


;;             _                        _
;;  __ _  _ __| |_ ___ _ __ ___ ___ ___| |_
;; / _| || (_-<  _/ _ \ '  \___(_-</ -_)  _|
;; \__|\_,_/__/\__\___/_|_|_|  /__/\___|\__|
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(font-lock-comment-face ((t (:foreground "#808080"))))
 '(font-lock-constant-face ((t (:foreground "#00d7ff"))))
 '(font-lock-function-name-face ((t (:foreground "#ffff00"))))
 '(font-lock-keyword-face ((t (:foreground "#cc55ff"))))
 '(font-lock-string-face ((t (:foreground "#00afd7"))))
 '(font-lock-variable-name-face ((t (:foreground "#a1c454"))))
 '(highlight ((t (:background "#5fd7d7"))))
 '(highlight-indent-guides-character-face ((t (:foreground "color-244"))))
 '(hl-line ((t (:background "#4d4d4d"))))
 '(linum ((t (:foreground "#00cd00"))))
 '(magit-reflog-commit ((t (:foreground "#005500"))))
 '(minibuffer-prompt ((t (:foreground "brightblue"))))
 '(mode-line ((t (:background "#4d4d4d" :foreground "#5fffaf"))))
 '(mode-line-highlight ((t (:box (:line-width 2 :color "#5fff87")))))
 '(rainbow-delimiters-depth-1-face ((t (:foreground "#ffffff"))))
 '(rainbow-delimiters-depth-2-face ((t (:foreground "#cdbe70"))))
 '(rainbow-delimiters-depth-3-face ((t (:foreground "#ffa500"))))
 '(rainbow-delimiters-depth-4-face ((t (:foreground "#cdcd00"))))
 '(rainbow-delimiters-depth-5-face ((t (:foreground "#cdcd00"))))
 '(rainbow-delimiters-depth-6-face ((t (:foreground "#87cefa"))))
 '(rainbow-delimiters-depth-7-face ((t (:foreground "#ee82ee"))))
 '(rainbow-delimiters-depth-8-face ((t (:foreground "#bebebe"))))
 '(rainbow-delimiters-depth-9-face ((t (:foreground "#ff6347"))))
 '(rainbow-delimiters-unmatched-face ((t (:foreground "#ff0000"))))
 '(region ((t (:background "green" :foreground "black"))))
 '(shadow ((t (:foreground "grey60"))))
 '(smerge-refined-added ((t (:inherit smerge-refined-change :background "red"))))
 '(sp-pair-overlay-face ((t (:background "magenta"))))
 '(web-mode-html-tag-bracket-face ((t (:foreground "green")))))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(backup-directory-alist `(("." . "~/.saves")))
 '(company-echo-delay 0 t)
 '(company-idle-delay 0.3)
 '(company-tooltip-limit 20)
 '(css-indent-offset 2)
 '(fill-column 80)
 '(highlight-indent-guides-auto-enabled nil)
 '(highlight-indent-guides-method 'character)
 '(ido-enable-flex-matching t)
 '(ido-everywhere t)
 '(indent-tabs-mode nil)
 '(ispell-program-name "/usr/bin/aspell")
 '(linum-format "%4d │")
 '(org-default-notes-file "~/org/notes.org")
 '(org-journal-dir "~/org/journal/")
 '(org-journal-file-format "%Y/%m/%d.org")
 '(package-selected-packages
   '(edit-indirect irony spice-mode ansible ansible-doc ansible-vault company-shell company company-jedi crontab-mode company-terraform groovy-mode terraform-mode web-mode-edit-element ido-vertical-mode smex org-brain yasnippet-snippets org-journal whitespace-cleanup-mode git-commit flymd yaml-mode web-mode tablist sudo-edit smartparens seq rainbow-delimiters pkg-info pep8 nginx-mode multiple-cursors mmm-mode markdown-mode magit let-alist latex-preview-pane json-mode jinja2-mode highlight-indent-guides figlet expand-region dockerfile-mode ctable concurrent company-web company-lua company-go company-ghci company-ghc company-ansible))
 '(recentf-max-menu-items 25)
 '(sudo-edit-indicator-mode t)
 '(tab-width 4)
 '(truncate-lines t)
 '(vc-follow-symlinks t)
 '(web-mode-markup-indent-offset 2))
(put 'dired-find-alternate-file 'disabled nil)
