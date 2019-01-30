;;
;;  _____ __  __    _    ____ ____    _       _ _         _
;; | ____|  \/  |  / \  / ___/ ___|  (_)_ __ (_) |_   ___| |
;; |  _| | |\/| | / _ \| |   \___ \  | | '_ \| | __| / _ \ |
;; | |___| |  | |/ ___ \ |___ ___) | | | | | | | |_ |  __/ |
;; |_____|_|  |_/_/   \_\____|____/  |_|_| |_|_|\__(_)___|_|
;;

;; list the repositories containing them
(setq package-archives '(("gnu" . "https://elpa.gnu.org/packages/")
                         ("marmalade" . "https://marmalade-repo.org/packages/")
                         ("melpa" . "http://melpa.org/packages/")))

;; activate all the packages (in particular autoloads)
(package-initialize)

;; fetch the list of packages available
(unless package-archive-contents
  (package-refresh-contents))

;; ;; install the missing packages
;; (dolist (package package-list)
;;   (unless (package-installed-p package)
;;     (package-install package)))

;;
;;  _____ __  __    _    ____ ____    ____            _          _   _   _
;; | ____|  \/  |  / \  / ___/ ___|  |  _ \ ___   ___| | _____  | | | | | |
;; |  _| | |\/| | / _ \| |   \___ \  | |_) / _ \ / __| |/ / __| | | | | | |
;; | |___| |  | |/ ___ \ |___ ___) | |  _ < (_) | (__|   <\__ \ |_| |_| |_|
;; |_____|_|  |_/_/   \_\____|____/  |_| \_\___/ \___|_|\_\___/ (_) (_) (_)
;;
;;  _   _                 _____                    _
;; | | | |___  ___ _ __  |_   _|_      _____  __ _| | _____
;; | | | / __|/ _ \ '__|   | | \ \ /\ / / _ \/ _` | |/ / __|
;; | |_| \__ \  __/ |      | |  \ V  V /  __/ (_| |   <\__ \
;;  \___/|___/\___|_|      |_|   \_/\_/ \___|\__,_|_|\_\___/
;;

;; Highlight line
(add-hook 'after-init-hook 'global-hl-line-mode)

;; Enable line numbers
(add-hook 'after-init-hook 'global-linum-mode)
(setq linum-format "%4d \u2502")

;; Change font size
(set-face-attribute 'default nil :height 80)

;; disable the tool bar
(tool-bar-mode -1)
(menu-bar-mode -1)

;; Delete selection mode
(delete-selection-mode 1)

;; json indent to 2-spaces
(add-hook 'json-mode-hook
          (lambda ()
            (make-local-variable 'js-indent-level)
            (setq js-indent-level 2)))

;; Disable line-wrapping
(setq-default truncate-lines t)

;; Set the default auto-backup directory
(setq backup-directory-alist `(("." . "~/.saves")))

;; Set transparency
;; (set-frame-parameter (selected-frame) 'alpha '(90 . 90))
;; (add-to-list 'default-frame-alist '(alpha 90 90))

;; Delete duplicate line command
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

;;                 _                  _
;;   ___ _   _ ___| |_ ___  _ __ ___ | | _____ _   _ ___
;;  / __| | | / __| __/ _ \| '_ ` _ \| |/ / _ \ | | / __|
;; | (__| |_| \__ \ || (_) | | | | | |   <  __/ |_| \__ \
;;  \___|\__,_|___/\__\___/|_| |_| |_|_|\_\___|\__, |___/
;;                                             |___/
;; Expand region
(global-set-key (kbd "C-x +") 'er/expand-region)

;; Make window taller
(global-set-key (kbd "C-x '") 'enlarge-window)

;;                   _                              _
;;   ___  _ __ __ _ (_) ___  _   _ _ __ _ __   __ _| |
;;  / _ \| '__/ _` || |/ _ \| | | | '__| '_ \ / _` | |
;; | (_) | | | (_| || | (_) | |_| | |  | | | | (_| | |
;;  \___/|_|  \__, |/ |\___/ \__,_|_|  |_| |_|\__,_|_|
;;            |___/__/
;;
(org-version) ;; Required for including org-journal
(require 'org-journal)

;;
;;                           _
;;  ___ _ __ ___   __ _ _ __| |_ _ __   __ _ _ __ ___ _ __  ___
;; / __| '_ ` _ \ / _` | '__| __| '_ \ / _` | '__/ _ \ '_ \/ __|
;; \__ \ | | | | | (_| | |  | |_| |_) | (_| | | |  __/ | | \__ \
;; |___/_| |_| |_|\__,_|_|   \__| .__/ \__,_|_|  \___|_| |_|___/
;;                              |_|
;;
(require 'smartparens-config)
(add-hook 'prog-mode-hook 'smartparens-mode)
(add-hook 'yaml-mode-hook 'smartparens-mode)

;; Rainbow delimeters
(require 'rainbow-delimiters)
(add-hook 'prog-mode-hook 'rainbow-delimiters-mode)


;;  _           _            _        _   _
;; (_)_ __   __| | ___ _ __ | |_ __ _| |_(_) ___  _ __
;; | | '_ \ / _` |/ _ \ '_ \| __/ _` | __| |/ _ \| '_ \
;; | | | | | (_| |  __/ | | | || (_| | |_| | (_) | | | |
;; |_|_| |_|\__,_|\___|_| |_|\__\__,_|\__|_|\___/|_| |_|
;;
;; Indentation guides
(setq highlight-indent-guides-method 'character)
(setq highlight-indent-guides-auto-enabled nil)
(add-hook 'prog-mode-hook 'highlight-indent-guides-mode)
(setq-default indent-tabs-mode nil)
(setq-default tab-width 4) ; Assuming you want your tabs to be four spaces wide
(defvaralias 'c-basic-offset 'tab-width)

(add-hook 'perl-mode-hook
          '(lambda()
             (setq indent-tabs-mode 1)))
(add-hook 'prog-mode-hook 'whitespace-cleanup-mode)

;; Fill Column Indicator
(require 'fill-column-indicator)
(setq-default fci-rule-column 80)
(setq-default fci-rule-character 58)
(setq-default fci-rule-character-color "white")
(add-hook 'prog-mode-hook 'fci-mode)
(add-hook 'text-mode-hook 'fci-mode)
(add-hook 'conf-unix-mode-hook 'fci-mode)

;; Fill-column
(setq-default fill-column 80)
(add-hook 'markdown-mode-hook 'auto-fill-mode)
(add-hook 'org-mode-hook 'auto-fill-mode)

;;  __  __       _ _   _       _         ____
;; |  \/  |_   _| | |_(_)_ __ | | ___   / ___|   _ _ __ ___  ___  _ __ ___
;; | |\/| | | | | | __| | '_ \| |/ _ \ | |  | | | | '__/ __|/ _ \| '__/ __|
;; | |  | | |_| | | |_| | |_) | |  __/ | |__| |_| | |  \__ \ (_) | |  \__ \
;; |_|  |_|\__,_|_|\__|_| .__/|_|\___|  \____\__,_|_|  |___/\___/|_|  |___/
;;                      |_|
(global-set-key (kbd "C-c C-<") 'mc/edit-lines)
(global-set-key (kbd "C-^") 'mc/mark-next-like-this)
(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-c C->") 'mc/mark-all-like-this)
(global-set-key (kbd "C-c C-S-c") 'mc/edit-lines)

;;
;;                        _                  _
;;  _   _  __ _ ___ _ __ (_)_ __  _ __   ___| |_ ___
;; | | | |/ _` / __| '_ \| | '_ \| '_ \ / _ \ __/ __|
;; | |_| | (_| \__ \ | | | | |_) | |_) |  __/ |_\__ \
;;  \__, |\__,_|___/_| |_|_| .__/| .__/ \___|\__|___/
;;  |___/                  |_|   |_|
;;
(require 'yasnippet)
(yas-global-mode 1)

;;
;;                    ___
;;  _ __   ___ _ __  ( _ )
;; | '_ \ / _ \ '_ \ / _ \
;; | |_) |  __/ |_) | (_) |
;; | .__/ \___| .__/ \___/
;; |_|        |_|
;;
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

;;              _                          ___
;;  _ _ _ _   _| |_ ___  _ __   ___ _ __  ( _ )
;; /  _` | | | | __/ _ \| '_ \ / _ \ '_ \ / _ \
;; | (_| | |_| | || (_) | |_) |  __/ |_) | (_) |
;;  \__,_|\__,_|\__\___/| .__/ \___| .__/ \___/
;;                      |_|        |_|
(require 'py-autopep8)

;;
;;  _   _      _
;; | | | | ___| |_ __ ___
;; | |_| |/ _ \ | '_ ` _ \
;; |  _  |  __/ | | | | | |
;; |_| |_|\___|_|_| |_| |_|
;;
;;
(require 'helm-config)
(global-set-key (kbd "M-x") 'helm-M-x)
(global-set-key (kbd "M-y") 'helm-show-kill-ring)
(global-set-key (kbd "C-x b") 'helm-mini)
(global-set-key (kbd "C-x C-f") 'helm-find-files)
(global-set-key (kbd "C-c C-h g") 'helm-google-suggest)
(global-set-key (kbd "C-c C-h o") 'helm-occur)
(define-key minibuffer-local-map (kbd "C-c C-h h") 'helm-minibuffer-history)
(helm-mode 1)

;;   ___ ___  _ __ ___  _ __   __ _ _ __  _   _
;;  / __/ _ \| '_ ` _ \| '_ \ / _` | '_ \| | | |
;; | (_| (_) | | | | | | |_) | (_| | | | | |_| |
;;  \___\___/|_| |_| |_| .__/ \__,_|_| |_|\__, |
;;                     |_|                |___/
;;
(require 'company)
(require 'company-go)
(add-hook 'after-init-hook 'global-company-mode)
; bigger popup window
(setq company-tooltip-limit 20)
; decrease delay before autocompletion popup shows
(setq company-idle-delay .3)
; remove annoying blinking
(setq company-echo-delay 0)
; start autocompletion only after typing
(setq company-begin-commands '(self-insert-command))
(setq exec-path (append exec-path '("/home/bdebyl/gocode/bin")))
;; Using auto-complete in place of company
(add-hook 'go-mode-hook
          (lambda ()
            (set (make-local-variable 'company-backends) '(company-go))
            (company-mode)))

;;               _                         _
;; __      _____| |__  _ __ ___   ___   __| | ___
;; \ \ /\ / / _ \ '_ \| '_ ` _ \ / _ \ / _` |/ _ \
;;  \ V  V /  __/ |_) | | | | | | (_) | (_| |  __/
;;   \_/\_/ \___|_.__/|_| |_| |_|\___/ \__,_|\___|
;;
(add-to-list 'auto-mode-alist '("\\.css$" . web-mode))
(add-to-list 'auto-mode-alist '("\\.html$" . web-mode))
(add-to-list 'auto-mode-alist '("\\.js$" . web-mode))
(add-to-list 'auto-mode-alist '("\\.etlua$" . web-mode))

;;    _ _        _       ____
;;   (_|_)_ __  (_) __ _|___ \
;;   | | | '_ \ | |/ _` | __) |
;;   | | | | | || | (_| |/ __/
;;  _/ |_|_| |_|/ |\__,_|_____|
;; |__/       |__/
(add-to-list 'auto-mode-alist '("\\.j2$" . jinja2-mode))

;;      _ _              _
;;   __| (_)_ __ ___  __| |
;;  / _` | | '__/ _ \/ _` |
;; | (_| | | | |  __/ (_| |
;;  \__,_|_|_|  \___|\__,_|
;;
;;
;; force dired to reuse dired buffer instead of opening a new one
(add-hook 'dired-mode-hook (lambda () (local-set-key [return] 'dired-single-buffer)))
(add-hook 'dired-mode-hook
          (lambda () (local-set-key "^" (function
                                         (lambda nil
                                           (interactive)
                                           (dired-single-buffer ".."))))))
;; syntax highlighting in dired mode
(add-hook 'dired-mode-hook #'(lambda () (font-lock-mode 1)))
;; load dired extras
(add-hook 'dired-load-hoo (function (lambda () (load "dired-x"))))

;;                        _                           _
;;  _   _  __ _ _ __ ___ | |      _ __ ___   ___   __| | ___
;; | | | |/ _` | '_ ` _ \| |_____| '_ ` _ \ / _ \ / _` |/ _ \
;; | |_| | (_| | | | | | | |_____| | | | | | (_) | (_| |  __/
;;  \__, |\__,_|_| |_| |_|_|     |_| |_| |_|\___/ \__,_|\___|
;;  |___/
;;
(require 'yaml-mode)
(add-to-list 'auto-mode-alist '("\\.yml$" . yaml-mode))
(add-hook 'yaml-mode-hook
          '(lambda ()
             (define-key yaml-mode-map "\C-m" 'newline-and-indent)))

;;   __ _       _      _
;;  / _(_) __ _| | ___| |_
;; | |_| |/ _` | |/ _ \ __|
;; |  _| | (_| | |  __/ |_
;; |_| |_|\__, |_|\___|\__|
;;        |___/
(setq figlet-default-font "standard")

;;                                            _
;;   ___  _ __ __ _       _ __ ___   ___   __| | ___
;;  / _ \| '__/ _` |_____| '_ ` _ \ / _ \ / _` |/ _ \
;; | (_) | | | (_| |_____| | | | | | (_) | (_| |  __/
;;  \___/|_|  \__, |     |_| |_| |_|\___/ \__,_|\___|
;;            |___/
;;
(setq org-default-notes-file "~/org/notes.org")
(define-key global-map "\C-cc" 'org-capture)
(setq org-capture-templates
      '(("t" "Todo" entry
         (file+headline "~/org/gtd.org" "Tasks") "* TODO %?\n  %i\n  %a")
        ("j" "Journal" entry
         (file+datetree "~/org/journal.org") "* %?\nEntered on %U\n  %i\n  %a")))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(bm-face ((t (:background "#000087" :foreground "#ffffff"))))
 '(ethan-wspace-face ((t (:background "#cd0000"))))
 '(font-lock-comment-face ((t (:foreground "#808080"))))
 '(font-lock-constant-face ((t (:foreground "#00d7ff"))))
 '(font-lock-function-name-face ((t (:foreground "#ffff00"))))
 '(font-lock-string-face ((t (:foreground "#00afd7"))))
 '(helm-ff-directory ((t (:foreground "#cd00cd"))))
 '(helm-ff-dirs ((t (:inherit font-lock-function-name-face))))
 '(helm-ff-dotted-directory ((t (:foreground "blue"))))
 '(helm-ff-symlink ((t (:foreground "green"))))
 '(helm-selection ((t (:background "#5e5e02"))))
 '(highlight ((t (:background "#5fd7d7"))))
 '(hl-line ((t (:background "#4d4d4d"))))
 '(linum ((t (:foreground "#00cd00"))))
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
 '(sp-pair-overlay-face ((t (:background "magenta")))))


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (org-journal whitespace-cleanup-mode git-commit flymd yaml-mode web-mode tablist sudo-edit smartparens seq rainbow-delimiters pkg-info pep8 nginx-mode multiple-cursors mmm-mode markdown-mode magit let-alist latex-preview-pane json-mode jinja2-mode highlight-indent-guides helm figlet expand-region dockerfile-mode dired-single ctable concurrent company-web company-lua company-go company-ghci company-ghc company-auctex company-ansible auto-complete))))
