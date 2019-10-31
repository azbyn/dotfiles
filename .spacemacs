;; -*- mode: emacs-lisp -*-
;; This file is loaded by Spacemacs at startup.
;; It must be stored in your home directory.

(defun dotspacemacs/layers ()
  "Configuration Layers declaration.
You should not put any user code in this function besides modifying the variable
values."
  (setq-default
   ;; Base distribution to use. This is a layer contained in the directory
   ;; `+distribution'. For now available distributions are `spacemacs-base'
   ;; or `spacemacs'. (default 'spacemacs)
   dotspacemacs-distribution 'spacemacs
   ;; Lazy installation of layers (i.e. layers are installed only when a file
   ;; with a supported type is opened). Possible values are `all', `unused'
   ;; and `nil'. `unused' will lazy install only unused layers (i.e. layers
   ;; not listed in variable `dotspacemacs-configuration-layers'), `all' will
   ;; lazy install any layer that support lazy installation even the layers
   ;; listed in `dotspacemacs-configuration-layers'. `nil' disable the lazy
   ;; installation feature and you have to explicitly list a layer in the
   ;; variable `dotspacemacs-configuration-layers' to install it.
   ;; (default 'unused)
   dotspacemacs-enable-lazy-installation 'unused
   ;; If non-nil then Spacemacs will ask for confirmation before installing
   ;; a layer lazily. (default t)
   dotspacemacs-ask-for-lazy-installation t
   ;; If non-nil layers with lazy install support are lazy installed.
   ;; List of additional paths where to look for configuration layers.
   ;; Paths must have a trailing slash (i.e. `~/.mycontribs/')
   dotspacemacs-configuration-layer-path '()
   ;; List of configuration layers to load.
   dotspacemacs-configuration-layers
   '(
     ;; ----------------------------------------------------------------
     ;; Example of useful layers you may want to use right away.
     ;; Uncomment some layer names and press <SPC f e R> (Vim style) or
     ;; <M-m f e R> (Emacs style) to install them.
     ;; ----------------------------------------------------------------
     ivy
     auto-completion
     ;; better-defaults
     asm
     latex
     emacs-lisp
     ;; git
     ;; markdown
     org
     ;; (shell :variables
     ;;        shell-default-height 30
     ;;        shell-default-position 'bottom)
     ;; spell-checking
     syntax-checking
     (c-c++ :variables c-c++-enable-clang-support t)
     python
     ;; version-control
     )
   ;; List of additional packages that will be installed without being
   ;; wrapped in a layer. If you need some configuration for these
   ;; packages, then consider creating a layer. You can also put the
   ;; configuration in `dotspacemacs/user-config'.
   dotspacemacs-additional-packages '(base16-theme
                                      company-auctex
                                      highlight-escape-sequences)
   ;; A list of packages that cannot be updated.
   dotspacemacs-frozen-packages '()
   ;; A list of packages that will not be installed and loaded.
   dotspacemacs-excluded-packages '(exec-path-from-shell)
   ;; Defines the behaviour of Spacemacs when installing packages.
   ;; Possible values are `used-only', `used-but-keep-unused' and `all'.
   ;; `used-only' installs only explicitly used packages and uninstall any
   ;; unused packages as well as their unused dependencies.
   ;; `used-but-keep-unused' installs only the used packages but won't uninstall
   ;; them if they become unused. `all' installs *all* packages supported by
   ;; Spacemacs and never uninstall them. (default is `used-only')
   dotspacemacs-install-packages 'used-only))

(defun dotspacemacs/init ()
  "Initialization function.
This function is called at the very startup of Spacemacs initialization
before layers configuration.
You should not put any user code in there besides modifying the variable
values."
  ;; This setq-default sexp is an exhaustive list of all the supported
  ;; spacemacs settings.
  (setq-default
   ;; If non nil ELPA repositories are contacted via HTTPS whenever it's
   ;; possible. Set it to nil if you have no way to use HTTPS in your
   ;; environment, otherwise it is strongly recommended to let it set to t.
   ;; This variable has no effect if Emacs is launched with the parameter
   ;; `--insecure' which forces the value of this variable to nil.
   ;; (default t)
   dotspacemacs-elpa-https t
   ;; Maximum allowed time in seconds to contact an ELPA repository.
   dotspacemacs-elpa-timeout 5
   ;; If non nil then spacemacs will check for updates at startup
   ;; when the current branch is not `develop'. Note that checking for
   ;; new versions works via git commands, thus it calls GitHub services
   ;; whenever you start Emacs. (default nil)
   dotspacemacs-check-for-update nil
   ;; If non-nil, a form that evaluates to a package directory. For example, to
   ;; use different package directories for different Emacs versions, set this
   ;; to `emacs-version'.
   dotspacemacs-elpa-subdirectory nil
   ;; One of `vim', `emacs' or `hybrid'.
   ;; `hybrid' is like `vim' except that `insert state' is replaced by the
   ;; `hybrid state' with `emacs' key bindings. The value can also be a list
   ;; with `:variables' keyword (similar to layers). Check the editing styles
   ;; section of the documentation for details on available variables.
   ;; (default 'vim)
   dotspacemacs-editing-style 'hybrid
   ;; If non nil output loading progress in `*Messages*' buffer. (default nil)
   dotspacemacs-verbose-loading nil
   ;; Specify the startup banner. Default value is `official', it displays
   ;; the official spacemacs logo. An integer value is the index of text
   ;; banner, `random' chooses a random text banner in `core/banners'
   ;; directory. A string value must be a path to an image format supported
   ;; by your Emacs build.
   ;; If the value is nil then no banner is displayed. (default 'official)
   dotspacemacs-startup-banner 'official
   ;; List of items to show in startup buffer or an association list of
   ;; the form `(list-type . list-size)`. If nil then it is disabled.
   ;; Possible values for list-type are:
   ;; `recents' `bookmarks' `projects' `agenda' `todos'."
   ;; List sizes may be nil, in which case
   ;; `spacemacs-buffer-startup-lists-length' takes effect.
   dotspacemacs-startup-lists '((recents . 5)
                                (projects . 5))
   ;; True if the home buffer should respond to resize events.
   dotspacemacs-startup-buffer-responsive t
   ;; Default major mode of the scratch buffer (default `text-mode')
   dotspacemacs-scratch-mode 'text-mode
   ;; List of themes, the first of the list is loaded when spacemacs starts.
   ;; Press <SPC> T n to cycle to the next theme in the list (works great
   ;; with 2 themes variants, one dark and one light)
   dotspacemacs-themes '(base16-google-dark
                         spacemacs-dark)
   ;; If non nil the cursor color matches the state color in GUI Emacs.
   dotspacemacs-colorize-cursor-according-to-state t
   ;; Default font, or prioritized list of fonts. `powerline-scale' allows to
   ;; quickly tweak the mode-line size to make separators look not too crappy.
   dotspacemacs-default-font '("DejaVu Sans Mono"
                               :size 18
                               :weight normal
                               :width normal
                               :powerline-scale 1.1)
   ;; The leader key
   dotspacemacs-leader-key "SPC"
   ;; The key used for Emacs commands (M-x) (after pressing on the leader key).
   ;; (default "SPC")
   dotspacemacs-emacs-command-key "SPC"
   ;; The key used for Vim Ex commands (default ":")
   dotspacemacs-ex-command-key ":"
   ;; The leader key accessible in `emacs state' and `insert state'
   ;; (default "M-m")
   dotspacemacs-emacs-leader-key "M-m"
   ;; Major mode leader key is a shortcut key which is the equivalent of
   ;; pressing `<leader> m`. Set it to `nil` to disable it. (default ",")
   dotspacemacs-major-mode-leader-key ","
   ;; Major mode leader key accessible in `emacs state' and `insert state'.
   ;; (default "C-M-m")
   dotspacemacs-major-mode-emacs-leader-key "C-M-m"
   ;; These variables control whether separate commands are bound in the GUI to
   ;; the key pairs C-i, TAB and C-m, RET.
   ;; Setting it to a non-nil value, allows for separate commands under <C-i>
   ;; and TAB or <C-m> and RET.
   ;; In the terminal, these pairs are generally indistinguishable, so this only
   ;; works in the GUI. (default nil)
   dotspacemacs-distinguish-gui-tab nil
   ;; If non nil `Y' is remapped to `y$' in Evil states. (default nil)
   dotspacemacs-remap-Y-to-y$ nil
   ;; If non-nil, the shift mappings `<' and `>' retain visual state if used
   ;; there. (default t)
   dotspacemacs-retain-visual-state-on-shift t
   ;; If non-nil, J and K move lines up and down when in visual mode.
   ;; (default nil)
   dotspacemacs-visual-line-move-text nil
   ;; If non nil, inverse the meaning of `g' in `:substitute' Evil ex-command.
   ;; (default nil)
   dotspacemacs-ex-substitute-global nil
   ;; Name of the default layout (default "Default")
   dotspacemacs-default-layout-name "Default"
   ;; If non nil the default layout name is displayed in the mode-line.
   ;; (default nil)
   dotspacemacs-display-default-layout nil
   ;; If non nil then the last auto saved layouts are resume automatically upon
   ;; start. (default nil)
   dotspacemacs-auto-resume-layouts nil
   ;; Size (in MB) above which spacemacs will prompt to open the large file
   ;; literally to avoid performance issues. Opening a file literally means that
   ;; no major mode or minor modes are active. (default is 1)
   dotspacemacs-large-file-size 1
   ;; Location where to auto-save files. Possible values are `original' to
   ;; auto-save the file in-place, `cache' to auto-save the file to another
   ;; file stored in the cache directory and `nil' to disable auto-saving.
   ;; (default 'cache)
   dotspacemacs-auto-save-file-location 'cache
   ;; Maximum number of rollback slots to keep in the cache. (default 5)
   dotspacemacs-max-rollback-slots 5
   ;; If non nil, `helm' will try to minimize the space it uses. (default nil)
   dotspacemacs-helm-resize nil
   ;; if non nil, the helm header is hidden when there is only one source.
   ;; (default nil)
   dotspacemacs-helm-no-header nil
   ;; define the position to display `helm', options are `bottom', `top',
   ;; `left', or `right'. (default 'bottom)
   dotspacemacs-helm-position 'bottom
   ;; Controls fuzzy matching in helm. If set to `always', force fuzzy matching
   ;; in all non-asynchronous sources. If set to `source', preserve individual
   ;; source settings. Else, disable fuzzy matching in all sources.
   ;; (default 'always)
   dotspacemacs-helm-use-fuzzy 'always
   ;; If non nil the paste micro-state is enabled. When enabled pressing `p`
   ;; several times cycle between the kill ring content. (default nil)
   dotspacemacs-enable-paste-transient-state nil
   ;; Which-key delay in seconds. The which-key buffer is the popup listing
   ;; the commands bound to the current keystroke sequence. (default 0.4)
   dotspacemacs-which-key-delay 0.4
   ;; Which-key frame position. Possible values are `right', `bottom' and
   ;; `right-then-bottom'. right-then-bottom tries to display the frame to the
   ;; right; if there is insufficient space it displays it at the bottom.
   ;; (default 'bottom)
   dotspacemacs-which-key-position 'bottom
   ;; If non nil a progress bar is displayed when spacemacs is loading. This
   ;; may increase the boot time on some systems and emacs builds, set it to
   ;; nil to boost the loading time. (default t)
   dotspacemacs-loading-progress-bar t
   ;; If non nil the frame is fullscreen when Emacs starts up. (default nil)
   ;; (Emacs 24.4+ only)
   dotspacemacs-fullscreen-at-startup nil
   ;; If non nil `spacemacs/toggle-fullscreen' will not use native fullscreen.
   ;; Use to disable fullscreen animations in OSX. (default nil)
   dotspacemacs-fullscreen-use-non-native nil
   ;; If non nil the frame is maximized when Emacs starts up.
   ;; Takes effect only if `dotspacemacs-fullscreen-at-startup' is nil.
   ;; (default nil) (Emacs 24.4+ only)
   dotspacemacs-maximized-at-startup nil
   ;; A value from the range (0..100), in increasing opacity, which describes
   ;; the transparency level of a frame when it's active or selected.
   ;; Transparency can be toggled through `toggle-transparency'. (default 90)
   dotspacemacs-active-transparency 90
   ;; A value from the range (0..100), in increasing opacity, which describes
   ;; the transparency level of a frame when it's inactive or deselected.
   ;; Transparency can be toggled through `toggle-transparency'. (default 90)
   dotspacemacs-inactive-transparency 90
   ;; If non nil show the titles of transient states. (default t)
   dotspacemacs-show-transient-state-title t
   ;; If non nil show the color guide hint for transient state keys. (default t)
   dotspacemacs-show-transient-state-color-guide t
   ;; If non nil unicode symbols are displayed in the mode line. (default t)
   dotspacemacs-mode-line-unicode-symbols t
   ;; If non nil smooth scrolling (native-scrolling) is enabled. Smooth
   ;; scrolling overrides the default behavior of Emacs which recenters point
   ;; when it reaches the top or bottom of the screen. (default t)
   dotspacemacs-smooth-scrolling t
   ;; Control line numbers activation.
   ;; If set to `t' or `relative' line numbers are turned on in all `prog-mode' and
   ;; `text-mode' derivatives. If set to `relative', line numbers are relative.
   ;; This variable can also be set to a property list for finer control:
   ;; '(:relative nil
   ;;   :disabled-for-modes dired-mode
   ;;                       doc-view-mode
   ;;                       markdown-mode
   ;;                       org-mode
   ;;                       pdf-view-mode
   ;;                       text-mode
   ;;   :size-limit-kb 1000)
   ;; (default nil)
   dotspacemacs-line-numbers '(:relative t
                               :disabled-for-modes
                                         dired-mode
                                         doc-view-mode
                                         ;;markdown-mode
                                         ;;org-mode
                                         pdf-view-mode
                                         ;;text-mode
                                         :size-limit-kb 1000)

   ;; Code folding method. Possible values are `evil' and `origami'.
   ;; (default 'evil)
   dotspacemacs-folding-method 'evil
   ;; If non-nil smartparens-strict-mode will be enabled in programming modes.
   ;; (default nil)
   dotspacemacs-smartparens-strict-mode nil
   ;; If non-nil pressing the closing parenthesis `)' key in insert mode passes
   ;; over any automatically added closing parenthesis, bracket, quote, etc…
   ;; This can be temporary disabled by pressing `C-q' before `)'. (default nil)
   dotspacemacs-smart-closing-parenthesis nil
   ;; Select a scope to highlight delimiters. Possible values are `any',
   ;; `current', `all' or `nil'. Default is `all' (highlight any scope and
   ;; emphasis the current one). (default 'all)
   dotspacemacs-highlight-delimiters 'all
   ;; If non nil, advise quit functions to keep server open when quitting.
   ;; (default nil)
   dotspacemacs-persistent-server nil
   ;; List of search tool executable names. Spacemacs uses the first installed
   ;; tool of the list. Supported tools are `ag', `pt', `ack' and `grep'.
   ;; (default '("ag" "pt" "ack" "grep"))
   dotspacemacs-search-tools '("ag" "pt" "ack" "grep")
   ;; The default package repository used if no explicit repository has been
   ;; specified with an installed package.
   ;; Not used for now. (default nil)
   dotspacemacs-default-package-repository nil
   ;; Delete whitespace while saving buffer. Possible values are `all'
   ;; to aggressively delete empty line and long sequences of whitespace,
   ;; `trailing' to delete only the whitespace at end of lines, `changed'to
   ;; delete only whitespace for changed lines or `nil' to disable cleanup.
   ;; (default nil)
   dotspacemacs-whitespace-cleanup nil
   ))

(defun dotspacemacs/user-init ()
  "Initialization function for user code.
It is called immediately after `dotspacemacs/init', before layer configuration
executes.
 This function is mostly useful for variables that need to be set
before packages are loaded. If you are unsure, you should try in setting them in
`dotspacemacs/user-config' first."
  (setq-default base16-google-dark-colors
                '(:base00 "#1d1f21"
                          :base01 "#282a2e"
                          :base02 "#373b41"
                          :base03 "#7E807E"
                          :base04 "#b4b7b4"
                          :base05 "#c5c8c6"
                          :base06 "#e0e0e0"
                          :base07 "#FFFFFF"
                          :base08 "#CC342B"
                          :base09 "#F96A38"
                          :base0A "#FBA922"
                          :base0B "#198844"
                          :base0C "#3971ed" ;;:base0C "#12A59C"
                          :base0D "#3971ED"
                          :base0E "#A36AC7"
                          :base0F "#FBA922"))
  (setq-default evil-toggle-key "H-e")
  (setq-default base16-theme-256-color-source "base16-shell")
  )

(defun dotspacemacs/user-config ()
  "Configuration function for user code.
This function is called at the very end of Spacemacs initialization after
layers configuration.
This is the place where most of your configurations should be done. Unless it is
explicitly specified that a variable should be set before a package is loaded,
you should place your code here."
 ;;; Visual
  ;;"terminal" "base16-shell" "colors"
  ;;(menu-bar-mode t)
  ;;(setq powerline-default-separator 'arrow)
  (setq-default whitespace-line-column 80)
  (setq-default whitespace-style '(face
                                   ;;trailing
                                   tabs
                                   ;;spaces
                                   space-before-tab
                                   space-after-tab
                                   tab-mark
                                   ;;space-mark
                                   lines-tail))
  (add-hook 'prog-mode-hook 'whitespace-mode)
  (add-hook 'prog-mode-hook 'hes-mode)
  (add-hook 'latex-mode-hook 'show-paren-mode)
  (add-hook 'latex-mode-hook 'electric-pair-mode)

  (setq-default normal-auto-fill-function 'nil)



  (put 'hes-escape-backslash-face 'face-alias 'hes-escape-sequence-face)
  (put 'font-lock-comment-delimiter-face 'face-alias 'font-lock-comment-face)
  (defun is-in-terminal()
    (not (display-graphic-p)))
  (when (is-in-terminal)
        (setq spaceline-window-numbers-unicode nil))

  ;;; Keys
  (global-set-key (kbd "C-`") 'evil-search-highlight-persist-remove-all)

  (defun get-deletion-count (arg)
    "Return the amount of spaces to be deleted, ARG is indentation border."
    (if (eq (current-column) 0) 0
      (let ((result (mod (current-column) arg)))
        (if (eq result 0) arg
          result))))

  (defun backspace-some (arg)
    "Deletes some backspaces, ARG unused."
    (interactive "*P")
    (if (use-region-p) (backward-delete-char-untabify 1)
      (let ((here (point)))
        (if (eq 0 (skip-chars-backward " " (- (point) (get-deletion-count 4))))
            (backward-delete-char-untabify 1)
          (delete-region (point) here)))))
  ;;(setq-default indent-tabs-mode t)
  (global-set-key [backspace] 'backspace-some)
  (setq backward-delete-char-untabify-method 'hungry)

  (define-key minibuffer-local-map [escape] 'minibuffer-keyboard-quit)
  (define-key minibuffer-local-ns-map [escape] 'minibuffer-keyboard-quit)
  (define-key minibuffer-local-completion-map [escape] 'minibuffer-keyboard-quit)
  (define-key minibuffer-local-must-match-map [escape] 'minibuffer-keyboard-quit)
  (define-key minibuffer-local-isearch-map [escape] 'minibuffer-keyboard-quit)
  (define-key ivy-minibuffer-map [escape] 'minibuffer-keyboard-quit)
  ;;(define-key browse-kill-ring-mode-map (kbd "<escape>") 'browse-kill-ring-quit)
  (global-set-key [escape] 'keyboard-quit)

  (global-set-key (kbd "H-<up>") 'windmove-up)
  (global-set-key (kbd "H-<down>") 'windmove-down)
  (global-set-key (kbd "H-<left>") 'windmove-left)
  (global-set-key (kbd "H-<right>") 'windmove-right)

  (global-set-key (kbd "H-M-<right>") 'enlarge-window-horizontally)
  (global-set-key (kbd "H-M-<left>") 'shrink-window-horizontally)
  ;(global-set-key (kbd "H-M-<down>") 'balance-windows)
  (global-set-key (kbd "H-M-<up>") 'evil-window-rotate-upwards)
  (global-set-key (kbd "H-M-<down>") 'evil-window-rotate-downwards)

  (global-set-key (kbd "H-S-<right>") 'evil-window-move-far-right)
  (global-set-key (kbd "H-S-<left>") 'evil-window-move-far-left)
  (global-set-key (kbd "H-S-<down>") 'evil-window-move-very-bottom)
  (global-set-key (kbd "H-S-<up>") 'evil-window-move-very-top)
  (global-set-key (kbd "<H-f11>") 'maximize-buffer)
  (global-set-key (kbd "<H-q>") 'delete-window)
  (global-set-key (kbd "<H-space>") 'maximize-buffer)
  (global-set-key (kbd "<H-return>") 'split-window-right)
  (global-set-key (kbd "<H-S-return>") 'split-window-right-and-focus)


  (global-set-key (kbd "M-c") 'kill-ring-save)
  (global-set-key (kbd "M-v") 'yank)
  ;;(define-key evil-visual-state-map (kbd "M-c") 'kill-ring-save)
  (define-key evil-visual-state-map (kbd "C-x") 'kill-region)
  ;;(define-key evil-visual-state-map (kbd "M-v") 'yank)
  (define-key evil-hybrid-state-map (kbd "C-v") 'yank)
  (global-set-key (kbd "H-r") 'dotspacemacs/sync-configuration-layers)
  (global-set-key (kbd "H-M-v") 'browse-kill-ring)
  (global-set-key (kbd "H-s") 'save-buffer)
  ;(global-set-key (kbd "H-q") 'kill-emacs)
  (global-set-key (kbd "H-M-r") 'spacemacs/restart-emacs-resume-layouts)
  ;(global-set-key (kbd "H-t") 'spacemacs/cycle-spacemacs-theme)
  (global-set-key (kbd "H-f") 'flycheck-list-errors)
  (global-set-key (kbd "C-z") 'undo)


  (global-set-key (kbd "H-,") 'hide-subtree)
  (global-set-key (kbd "H-.") 'show-subtree)
  (global-set-key (kbd "H-<") 'hide-body)

  (global-set-key (kbd "H-SPC") 'flyspell-region)
  (global-set-key (kbd "H-M-SPC") 'flyspell-buffer)
  (global-set-key (kbd "H-S-SPC") 'ispell-buffer)


  ;(setq-default compilation-read-command nil)
  (global-set-key (kbd "H-c") (lambda () (interactive)
                                  (compile "make")))

  (setq compile-clean "make clean")
  (global-set-key (kbd "H-x") (lambda () (interactive)
                                (compile "make clean; make")))


  (global-set-key (kbd "M-<tab>") 'ff-find-other-file)
  ;; (global-set-key (kbd "M-<tab>") 'projectile-find-other-file)
  (global-set-key (kbd "C-<tab>") 'clang-format-region)
  (global-set-key (kbd "<C-iso-lefttab>") 'clang-format-buffer)
  
  (defun open-projects ()
    (interactive)
    (dired (expand-file-name "~/Projects/")))
  (global-set-key (kbd "H-p") 'open-projects)
  ;;(defun edit-config ()
  ;;  (interactive)
  ;;  (evil-edit (expand-file-name "~/.spacemacs")))
  (global-set-key (kbd "H-d") 'spacemacs/find-dotfile)

  ;;; Config
  (c-add-style "my-style"
               '("stroustrup"
                 (c-basic-offset . 4)
                 (indent-tabs-mode . nil)
                 (c-offsets-alist
                  (innamespace . -))))
  (push '(other . "my-style") c-default-style)

  (setq-default dfmt-flags '("--brace_style=stroustrup"))
  (defun dformat ()
    (local-set-key (kbd "C-<tab>") 'dfmt-region-or-buffer)
    (local-set-key (kbd "<C-iso-lefttab>") 'dfmt-buffer))
  (add-hook 'd-mode-hook 'dformat)

  (setq-default comment-column 15)
  (setq evil-vsplit-window-right t)
  (setq undo-tree-auto-save-history t)
  (setq undo-tree-history-directory-alist '(("." . "~/.emacs.d/undo")))
  (setq scroll-margin 3
        scroll-conservatively 9999
        scroll-step 1)


  (setq-default tab-width 4)
  ;(setq-default dfmt-command "dfmt")

  (with-eval-after-load 'flycheck
    (setq-default flycheck-disabled-checkers
                  '(c/c++-cppcheck c/c++-gcc)))
  (add-to-list 'auto-mode-alist '("\\.h\\'" . c++-mode))
  (add-to-list 'auto-mode-alist '("\\.tpp\\'" . c++-mode))
  ;;(add-hook 'c++-mode-hook 'ggtags-mode)
  ;;(add-hook 'c-mode-hook 'ggtags-mode)
  (add-hook 'c++-mode-hook 'irony-mode)
  (add-hook 'c-mode-hook 'irony-mode)
  (add-hook 'objc-mode-hook 'irony-mode)

  (add-hook 'irony-mode-hook 'irony-cdb-autosetup-compile-options)

  (visual-line-mode t)

  )

(setq custom-file (expand-file-name "~/.emacs.d/custom.el"))

;;(setq custom-file (expand-file-name "~/.spacemacs.d/custom.el"))
(load custom-file 'no-error 'no-message)
