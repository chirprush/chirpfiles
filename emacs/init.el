;; Initialization
(scroll-bar-mode 0)
(tool-bar-mode 0)
(menu-bar-mode 0)
(show-paren-mode 1)
(blink-cursor-mode 0)
(setq inhibit-startup-message t)
(setq make-backup-files nil)
(set-face-attribute 'default nil :font "JetBrainsMono Nerd Font" :height 120)
(set-face-attribute 'variable-pitch nil :font "Arial" :height 120)

;; Package manager
(require 'package)
(setq package-archives '(("melpa" . "https://melpa.org/packages/")
						 ("elpa" . "https://elpa.gnu.org/packages/")
						 ("org" . "https://orgmode.org/elpa/")))
(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))

(require 'use-package)
(setq use-package-always-ensure t)
(setq custom-file "~/.emacs.d/custom.el")

;; Indenting
(setq-default tab-width 4)
(setq-default indent-tabs-mode t)

;; Modeline
(use-package doom-modeline
  :init (doom-modeline-mode 1)
  :custom (doom-modeline-height 15))
(column-number-mode)

;; Tabline
(use-package centaur-tabs
  :demand
  :config
  (centaur-tabs-mode t)
  :custom
  (centaur-tabs-gray-out-icons 'buffer)
  (centaur-tabs-style "bar")
  (centaur-tabs-height 30)
  (centaur-tabs-set-icons t)
  (centaur-tabs-set-bar 'left)
  (centaur-tabs-set-modified-marker t)
  (centaur-tabs-modified-marker "●")
  :bind
  (("M-[" . #'centaur-tabs-backward)
   ("M-]" . #'centaur-tabs-forward)))

;; Theme
(use-package doom-themes
  :init (load-theme 'doom-dracula t))

;; Rainbow Paren
;; (use-package rainbow-delimiters
;;   :hook (prog-mode . rainbow-delimiters-mode))

;; Color Identifiers
(use-package color-identifiers-mode
  :config (global-color-identifiers-mode 1)
  :hook (prog-mode . color-identifiers:refresh))

;; Ivy
(use-package ivy
  ;; :bind (("M-SPC" . swiper-all))
  :config
  (ivy-mode 1))

;; Counsel
(use-package counsel
  :bind (("M-x" . counsel-M-x)
		 ("C-x b" . counsel-ibuffer)
		 ("C-x C-f" . counsel-find-file)))

;; Projectile
(use-package projectile
  :config
  (projectile-mode 1)
  (add-to-list 'projectile-globally-ignored-directories "*__pycache__")
  (setq projectile-project-search-path '("~/Projects/")))

;; Snippets
(use-package yasnippet
  :config
  (setq yas-snippet-dirs
		'("~/.emacs.d/snippets"))
  (setq yas-triggers-in-field t)
  (setq yas-indent-line 'auto)
  (setq yas-also-auto-indent-first-line t)
  (yas-global-mode 1))

;; Evil
(defun kill-line-contents ()
  (interactive)
  (move-beginning-of-line nil)
  (kill-line nil))

(use-package evil
  :init
  (setq evil-want-keybinding nil)
  :config
  (evil-mode 1)
  (define-key evil-normal-state-map (kbd "SPC") 'projectile-command-map)
  (define-key evil-insert-state-map (kbd "C-u") 'kill-line-contents)
  (define-key evil-normal-state-map (kbd "C-u") 'evil-scroll-page-up)
  (define-key evil-normal-state-map (kbd "M-.") 'xref-find-definitions)
  (evil-global-set-key 'motion "j" 'evil-next-visual-line)
  (evil-global-set-key 'motion "k" 'evil-previous-visual-line))

(use-package evil-collection
  :after evil
  :ensure t
  :config
  (evil-collection-init))

;; Key-chord for evil
(use-package key-chord
  :init
  (setq key-chord-two-keys-delay 0.10)
  :config
  (key-chord-mode 1))

(key-chord-define evil-insert-state-map "fd" 'evil-normal-state)
(global-set-key (kbd "<escape>") 'keyboard-escape-quit)
(global-set-key (kbd "C-u") 'kill-whole-line)

;; Filetype specific
(setq python-shell-interpreter "python3")

(setq c-basic-offset 4)
(c-set-offset 'brace-list-intro '+)
(c-set-offset 'arglist-intro '+)
(c-set-offset 'arglist-close 0)

(add-hook 'c-mode-hook (lambda ()
						 (setq indent-tabs-mode t)))

(use-package clojure-mode)

(setq-default markdown-header-scaling t)
(use-package markdown-mode)
(add-hook 'markdown-mode-hook (lambda ()
								(visual-line-mode)))

(use-package mixed-pitch
  :hook (markdown-mode . mixed-pitch-mode))

(use-package visual-fill-column
  :hook (markdown-mode . visual-fill-column-mode))

(add-hook 'markdown-mode-hook (lambda ()
								(setq visual-fill-column-center-text t)))

(use-package lua-mode)

(use-package rust-mode)
(add-hook 'rust-mode-hook (lambda ()
							(setq indent-tabs-mode nil)
							(color-identifiers-mode nil)))

(use-package hindent)
(add-hook 'haskell-mode-hook #'hindent-mode)

(use-package org-bullets
  :hook (org-mode-hook . org-bullets-mode))

(setq org-todo-keywords
	  '((sequence "TODO" "STARTED" "|" "DONE" "DROPPED")))

(add-hook 'org-mode-hook (lambda ()
						   (setq indent-tabs-mode nil)
						   (visual-line-mode)
						   (org-bullets-mode)))

;; Misc stuff
(defun edit-init-file ()
  (interactive)
  (find-file "~/.emacs.d/init.el"))

(add-hook 'after-change-major-mode-hook
		  (lambda ()
			(modify-syntax-entry ?_ "w")))

(bind-key "C-x k" 'kill-current-buffer)
(bind-key "C-x C-k" 'kill-buffer)
(bind-key "C-c e" 'edit-init-file)

(add-hook 'prog-mode-hook 'electric-pair-mode)

(setq redisplay-dont-pause t
  scroll-margin 1
  scroll-step 1
  scroll-conservatively 10000
  scroll-preserve-screen-position 1)

(setq browse-url-browser-function 'browse-url-generic
      browse-url-generic-program "firefox")
