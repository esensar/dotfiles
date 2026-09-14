;; Melpa setup
(with-eval-after-load 'package
 (setq package-archives
  '(("gnu"   . "https://elpa.gnu.org/packages/")
    ("melpa" . "https://melpa.org/packages/")))
 (push 'company      package-selected-packages)
 (push 'flycheck     package-selected-packages)
 (push 'lsp-mode     package-selected-packages)
 (push 'lsp-ui       package-selected-packages)
 (push 'lsp-treemacs package-selected-packages))

;; Install evil-mode and enable by default
(use-package evil
  :ensure t
  :init
  (setq evil-want-integration t) ;; This is optional since it's already set to t by default.
  (setq evil-want-keybinding nil)
  :config
  (evil-mode 1))

(use-package evil-collection
  :after evil
  :ensure t
  :custom
  (evil-collection-setup-minibuffer t)
  (setq evil-collection-key-blacklist '("C-y"))
  :config
  (evil-collection-init))

;; Projectile
(use-package projectile
  :ensure t
  :config
  (projectile-mode +1)
  (define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map))

(use-package rust-mode
  :ensure t)

(load-theme 'gruvbox)

(with-eval-after-load 'prog-mode
 (add-hook 'prog-mode-hook #'hl-line-mode)
 (add-hook 'prog-mode-hook #'display-line-numbers-mode)
 (add-hook 'prog-mode-hook #'electric-layout-mode)
 (add-hook 'prog-mode-hook #'electric-pair-mode)
 (add-hook 'prog-mode-hook #'company-mode)
 (add-hook 'prog-mode-hook #'flycheck-mode)
 (add-hook 'prog-mode-hook #'flyspell-prog-mode)
 (add-hook 'prog-mode-hook #'show-paren-mode)
 (add-hook 'prog-mode-hook #'eldoc-mode))

(with-eval-after-load 'flycheck
 (define-key flycheck-mode-map (kbd "] w") #'flycheck-next-error)
 (define-key flycheck-mode-map (kbd "[ w") #'flycheck-previous-error)
 (setq flycheck-checker-error-threshold nil)
 (setq flycheck-check-syntax-automatically
  '(idle-change new-line mode-enabled idle-buffer-switch))
 (setq flycheck-idle-change-delay 0.25)
 (setq flycheck-idle-buffer-switch-delay 0.25))

(with-eval-after-load 'company
 (setq company-backends '((company-capf company-files company-keywords)))
 (setq completion-ignore-case t)
 (setq company-minimum-prefix-length 1)
 (setq company-selection-wrap-around t)
 (define-key company-mode-map (kbd "C-y") #'company-indent-or-complete-common))

(with-eval-after-load 'lsp-mode
 (define-key lsp-mode-map (kbd "C-c f") #'lsp-format-buffer)
 (define-key lsp-mode-map (kbd "C-c g") #'lsp-format-region)
 (define-key lsp-mode-map (kbd "SPC r n") #'lsp-rename)
 (define-key lsp-mode-map (kbd "K") #'lsp-describe-thing-at-point)
 (define-key lsp-mode-map (kbd "C-="  ) #'lsp-extend-selection)
 (define-key lsp-mode-map (kbd "M-RET") #'lsp-execute-code-action)
 (define-key lsp-mode-map (kbd "C-c e") #'lsp-treemacs-errors-list)
 (define-key lsp-mode-map (kbd "C-c s") #'lsp-treemacs-symbols)
 (define-key lsp-mode-map (kbd "C-c c") #'lsp-treemacs-call-hierarchy)
 (define-key lsp-mode-map (kbd "C-c t") #'lsp-treemacs-type-hierarchy)
 (add-hook 'lsp-mode-hook #'lsp-treemacs-sync-mode)
 (setq lsp-progress-prefix "  Progress: ")
 (setq lsp-completion-provider :none) ; Company-capf is already set
 (setq lsp-headerline-breadcrumb-enable t)
 (setq lsp-restart 'auto-restart)
 (setq lsp-enable-snippet nil)
 (setq lsp-keymap-prefix "C-c")
 (setq lsp-idle-delay 0.1)
 (setq lsp-file-watch-threshold nil)
 (setq lsp-enable-semantic-highlighting t)
 (setq lsp-enable-indentation t)
 (setq lsp-enable-on-type-formatting t)
 (setq lsp-before-save-edits nil)
 (setq lsp-auto-configure t)
 (setq lsp-signature-render-documentation t)
 (setq lsp-modeline-code-actions-enable nil)
 (setq lsp-log-io nil)
 (setq lsp-enable-imenu nil))

(with-eval-after-load 'lsp-headerline
 (setq lsp-headerline-breadcrumb-icons-enable nil))

(with-eval-after-load 'lsp-semantic-tokens
 (setq lsp-semantic-tokens-apply-modifiers t))

(with-eval-after-load 'lsp-clangd
 (setq lsp-clients-clangd-args
  '("--header-insertion-decorators"
    "--all-scopes-completion"
    "--clang-tidy"
    "--completion-style=detailed"
    "--header-insertion=never"
    "--inlay-hints"
    "--limit-results=1000"
    "-j=4"
    "--malloc-trim"
    "--pch-storage=memory"))
 (with-eval-after-load 'cc-mode
  (define-key c-mode-base-map (kbd "<f2>") #'lsp-clangd-find-other-file)))

(with-eval-after-load 'treemacs-interface
 (global-set-key (kbd "<f12>") #'treemacs-delete-other-windows))

(with-eval-after-load 'treemacs-customization
 (setq treemacs-width 70))

(with-eval-after-load 'treemacs-mode
 (add-hook 'treemacs-mode-hook #'toggle-truncate-lines))

(with-eval-after-load 'lsp-ui-flycheck
 (setq lsp-ui-flycheck-enable t))

(with-eval-after-load 'lsp-ui-doc
 ; Disable on-the-fly showing of rendered documentation.
 (setq lsp-ui-doc-enable nil)
 (setq lsp-ui-doc-alignment 'frame)
 (setq lsp-ui-doc-header t)
 (setq lsp-ui-doc-include-signature t)
 (setq lsp-ui-doc-max-height 30)
 (setq lsp-ui-doc-use-webkit t))

(with-eval-after-load 'lsp-ui-peek
 (setq lsp-ui-peek-list-width 30)
 (setq lsp-ui-peek-always-show t))

(with-eval-after-load 'lsp-ui-sideline
 (setq lsp-ui-sideline-enable nil))

(with-eval-after-load 'lsp-ui
 (define-key lsp-ui-mode-map (kbd "M-."    ) #'lsp-ui-peek-find-definitions)
 (define-key lsp-ui-mode-map (kbd "M-?"    ) #'lsp-ui-peek-find-references)
 (define-key lsp-ui-mode-map (kbd "M-I"    ) #'lsp-ui-peek-find-implementation)
 (define-key lsp-ui-mode-map (kbd "C-c d"  ) #'lsp-ui-doc-show)
 (define-key lsp-ui-mode-map (kbd "C-c ! l") #'lsp-ui-flycheck-list))

(defmacro set-up-c-style-comments ()
 "Set up C-style /* ... */ comments."
 `(with-eval-after-load 'newcomment
   (setq-local comment-style 'extra-line)))

(with-eval-after-load 'cc-mode
 (add-hook 'c-mode-common-hook #'lsp))

(with-eval-after-load 'cc-vars
 (setq c-mark-wrong-style-of-comment t)
 (setq c-default-style '((other . "user")))
 (setq c-basic-offset 2)
 (add-hook 'c-mode-common-hook (lambda nil (progn (set-up-c-style-comments)))))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("218c71361fdada068c64beb05005cfd646981a0a9b583f93cb904b01daf9471c"
     default))
 '(package-selected-packages '(## evil-collection projectile rust-mode)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
