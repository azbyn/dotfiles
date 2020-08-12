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
     lua
     ;;typescript
     ;rust
     javascript
     sql
     d
     csharp
     octave
     go
     html
     php
     java
     ;;kotlin
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
     (spell-checking :variables spell-checking-enable-by-default nil)
   ;;spell-checking
     syntax-checking
     (c-c++ :variables c-c++-enable-clang-support t)
     python
     haskell
     )
   ;; List of additional packages that will be installed without being
   ;; wrapped in a layer. If you need some configuration for these
   ;; packages, then consider creating a layer. You can also put the
   ;; configuration in `dotspacemacs/user-config'.
   dotspacemacs-additional-packages '(base16-theme
                                      dirtree
                                      xterm-color
                                      find-file-in-project
                                      ;; treemacs
                                      ;; treemacs-evil
                                      shackle
                                      openwith
                                      ranger
                                      ;eyebrowse
                                      lsp-mode
                                      nyan-mode
                                      ;;frames-only-mode
                                      ;;auctex
                                      flycheck-kotlin
                                      typescript-mode
                                      kotlin-mode
                                      impatient-mode
                                      company-auctex
                                      highlight-escape-sequences)
   ;; A list of packages that cannot be updated.
   dotspacemacs-frozen-packages '()
   ;; A list of packages that will not be installed and loaded.
   dotspacemacs-excluded-packages '(
                                    exec-path-from-shell
                                    company-tern
                                    )
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
   dotspacemacs-editing-style 'emacs;;'hybrid
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
   dotspacemacs-startup-lists '((recents . 7)
                                (projects . 6))
   ;; True if the home buffer should respond to resize events.
   dotspacemacs-startup-buffer-responsive t
   ;; Default major mode of the scratch buffer (default `text-mode')
   dotspacemacs-scratch-mode 'emacs-lisp-mode
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
   doGtspacemacs-fullscreen-use-non-native nil
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
   ;; '(:relative t
   ;;   :disabled-for-modes dired-mode
   ;;                       doc-view-mode
   ;;                       markdown-mode
   ;;                       org-mode
   ;;                       pdf-view-mode
   ;;                       text-mode
   ;;   :size-limit-kb 1000)
   ;; (default nil)
   dotspacemacs-line-numbers '(:relative nil
                               :disabled-for-modes
                                         dired-mode
                                         doc-view-mode
                                         ;;markdown-mode
                                         ;;org-mode
                                         image-mode
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
    (setq-default evil-toggle-key "H-M-e")
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
  ;(setq debug-on-error t)
  (require 'poetry-mode)
  ;;"terminal" "base16-shell" "colors"
  ;;(menu-bar-mode t)
  ;;(setq powerline-default-separator 'arrow)
  ;;we don't need this anymore since our emacs is 80 wide when in side by side mode

  ;; (add-hook 'poetry-mode-hook
  ;;           (lambda ()

  ;;             (local-set-key (kbd "H-c")
  ;;                            (lambda ()
  ;;                              (interactive)
  ;;                              ;;(save-buffer)
  ;;                              (compile (message "poetrizer -c \"%s\" %d"
  ;;                                                (buffer-file-name)
  ;;                                                (line-number-at-pos)))
  ;;                              ))

  ;;             ))
  (eyebrowse-mode t)
  ;(setq eyebrowse-new-workspace t)
  ;;todo pers-mode.el
  (define-key winum-keymap (kbd "M-1") nil)
  (define-key winum-keymap (kbd "M-2") nil)
  (define-key winum-keymap (kbd "M-3") nil)
  (define-key winum-keymap (kbd "M-4") nil)

  (global-set-key (kbd "M-1") 'eyebrowse-switch-to-window-config-1)
  (global-set-key (kbd "M-2") 'eyebrowse-switch-to-window-config-2)
  (global-set-key (kbd "M-3") 'eyebrowse-switch-to-window-config-3)
  (global-set-key (kbd "M-4") 'eyebrowse-switch-to-window-config-4)

  ;;(global-set-key (kbd "C-c k")
  ;;                 (lambda () (call-interactively 'eyebrowse-close-window-config)))

  (setq-default whitespace-line-column 180)
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


  (define-key minibuffer-local-map [escape] 'minibuffer-keyboard-quit)
  (define-key minibuffer-local-ns-map [escape] 'minibuffer-keyboard-quit)
  (define-key minibuffer-local-completion-map [escape] 'minibuffer-keyboard-quit)
  (define-key minibuffer-local-must-match-map [escape] 'minibuffer-keyboard-quit)
  (define-key minibuffer-local-isearch-map [escape] 'minibuffer-keyboard-quit)
  (define-key ivy-minibuffer-map [escape] 'minibuffer-keyboard-quit)
  ;;(define-key browse-kill-ring-mode-map (kbd "<escape>") 'browse-kill-ring-quit)
  (global-set-key [escape] 'keyboard-quit)


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

  ;(global-set-key (kbd "M-c") 'kill-ring-save)
  ;(global-set-key (kbd "M-v") 'yank)
  ;;(define-key evil-visual-state-map (kbd "M-c") 'kill-ring-save)
  (define-key evil-visual-state-map (kbd "C-x") 'kill-region)
  ;;(define-key evil-visual-state-map (kbd "M-v") 'yank)
  ;(define-key evil-hybrid-state-map (kbd "C-v") 'yank)
  ;;(global-set-key (kbd "H-r") 'dotspacemacs/sync-configuration-layers)
  (global-set-key (kbd "H-M-v") 'browse-kill-ring)
  (global-set-key (kbd "H-s") 'save-buffer)
  ;(global-set-key (kbd "H-q") 'kill-emacs)
  ;;(global-set-key (kbd "H-M-r") 'spacemacs/restart-emacs-resume-layouts)
  ;(global-set-key (kbd "H-t") 'spacemacs/cycle-spacemacs-theme)
  ;;(global-set-key (kbd "H-f") 'flycheck-list-errors)
  ;(global-set-key (kbd "C-z") 'undo)


  (global-set-key (kbd "H-,") 'hide-subtree)
  (global-set-key (kbd "H-.") 'show-subtree)
  (global-set-key (kbd "H-<") 'hide-body)

  (global-set-key (kbd "H-SPC") 'flyspell-region)
  (global-set-key (kbd "H-M-SPC") 'flyspell-buffer)
  (global-set-key (kbd "H-S-SPC") 'ispell-buffer)

  ;;make stuff
  ;;taken from neotree.el
  (defun azb-expand-name (path &optional current-dir)
    (expand-file-name (or (if (file-name-absolute-p path) path)
                          (let ((r-path path))
                            (setq r-path (substitute-in-file-name r-path))
                            (setq r-path (expand-file-name r-path current-dir))
                            r-path))))
  (defun updir (path)
    (let ((r-path (azb-expand-name path)))
      (if (and (> (length r-path) 0)
               (equal (substring r-path -1) "/"))
          (setq r-path (substring r-path 0 -1)))
      (if (eq (length r-path) 0)
          (setq r-path "/"))
      (directory-file-name
       (file-name-directory r-path))))
  (defun azb-project-dir (path)
    "find the first directory with a makefile"
    (if (member path '("/" "/home/azbyn/Projects" "/home/azbyn"))
        path
      (if (member "Makefile" (directory-files path))
          path (azb-project-dir (updir path)))))

  (defun azb-find-root (npath)
    (if npath
        (if (file-directory-p npath)
            npath (updir npath))
      nil))

  (defun azb-make (args)
    (interactive)
    (save-buffer)
    (compile (concat "make -C '"
                     (azb-project-dir (azb-find-root (buffer-file-name)))
                     "' " args)))

  (setq-default shackle-rules '((compilation-mode :noselect t))
                shackle-default-rule '(:select t))

  ;; this only took 3 hours to figgure out
  (defmacro local-key (key func)
    `(local-set-key ,key (lambda () (interactive) ,func)))

  (defmacro global-key (key func)
    `(global-set-key ,key (lambda () (interactive) ,func)))

  (defmacro local-compile (key func)
    `(local-set-key (kbd ,key)
                    (lambda () (interactive) (save-buffer) (compile ,func))))

  ;; (defun make-proj (cmd)
  ;;   (interactive)
  ;;   (compile (concat "make " cmd " -C " (p) ))
  ;;   )

  ;; (projectile-project-root)


  ;;(setq-default compile-clean "make clean")
  (global-key (kbd "H-c") (azb-make ""))
  (global-key (kbd "H-x") (azb-make "clean build"))
  (global-key (kbd "H-M-c") (azb-make "compile"))
  ;; (global-key (kbd "H-x") (print "make"))
  ;; (global-set-key (kbd "H-x") '(compile-gen "make"))
  ;; (global-set-key (kbd "H-x") (lambda ()
  ;;                               (interactive)
  ;;                               (compile "make clean; make")))

  ;; (global-set-key (kbd "H-M-c") (lambda ()
  ;;                                 (interactive)
  ;;                                 (compile "make compile")))


  ;=; (local-compile "H-c" (message "poetrizer -c \"%s\" %d"
  ;;                               (buffer-file-name)
  ;;                               (line-number-at-pos)))
  ;;(local-compile "H-M-c" (concat "poetrizer -p \"%s\" %d"
  ;;                              (buffer-file-name)
  ;;                              (line-number-at-pos)))
  ;;(local-compile "H-x" (concat "poetrizer -P \"%s\" %d"
  ;;                             (buffer-file-name)
  ;;                             (line-number-at-pos)))
  ;;(flycheck-mode)
  ;;(spacemacs/toggle-spelling-checking-on)

  (add-hook 'emacs-lisp-mode-hook
            (lambda ()
              (local-set-key (kbd "H-c") 'eval-last-sexp)))
  (defun tmp (f)
    (interactive)
    ;; (switch-to-buffer f)
    (let ((path (car (split-string f "\\."))))
      ;; (switch-to-buffer (concat path ".ptr"))
      (save-buffer)
      (evil-ex (concat "e " path ".ptr"))
      (poetry-mode)
      (shell-command (concat "lowriter '" path ".docx'"))
      ))
  ;; (php-php)
  ;; (global-set-key (kbd "M-r") (lambda ()
  ;;                               (interactive)
  ;;                               (beginning-of-buffer)
  ;;                               (replace-string "„" ",,")
  ;;                               (replace-string "“" ",,")
  ;;                               (replace-string "”" "''")
  ;;                               (replace-string "…" "...")
  ;;                               (replace-string "’" "'")
  ;;                               (replace-string "  " " ")
  ;;                               (tmp (read-file-name "File: "))
  ;;                               ))
  ;; (global-set-key (kbd "H-r") (lambda ()
  ;;                               (interactive)
  ;;                               (evil-ex (concat "e " (read-file-name "File: ")))
  ;;                               (beginning-of-buffer)
  ;;                               (replace-string "’" "'")
  ;;                               (save-buffer)
  ;;                               ))
  (global-set-key (kbd "M-n")
                  (lambda ()
                    (interactive)
                    ;; (save-buffer)
                    ;; (directory-files)
                    (setq-default tmp (read-string "File :"))
                    (find-file (concat tmp ".ptr"))
                    (insert tmp)
                    (call-interactively 'beginning-of-line)
                    (call-interactively 'kill-word)
                    (call-interactively 'delete-char)
                    (call-interactively 'end-of-line)
                    (flycheck-mode)
                    (spacemacs/toggle-spelling-checking-on)
                    (newline 3)
                    (previous-line)
                    ))
  ;;  (global-set-key )
  ;; (global-set-key (kbd "M-d")
  ;;                 (lambda ()
  ;;                   (interactive)
  ;;                   (shell-command
  ;;                    (concat "firefox "
  ;;                            "https://dexonline.ro/definitie/"
  ;;                            (read-string "Dex: ")
  ;;                            "/paradigma"))))
  ;; (global-set-key (kbd "H-M-d")
  ;;                 (lambda ()
  ;;                   (interactive)
  ;;                   (shell-command
  ;;                    (concat "firefox "
  ;;                            "http://www.silabe.ro/desparte-in-silabe-"
  ;;                            (read-string "Silabe: ")
  ;;                            ".html"))))


  (global-set-key (kbd "M-c") (lambda ()
                                (interactive)
                                (execute-kbd-macro (read-kbd-macro "H-c"))))

  ;; (add-hook 'poetry-mode-hook
  ;;           (lambda ()
  ;;             (local-set-key (kbd "H-c") (make
  ;;                                          (interactive)
  ;;                                          (compile "") ))
  ;;             (local-set-key (kbd "H-x") 'dfmt-buffer)
  ;;             (local-set-key (kbd "H-M-c") 'dfmt-buffer)
  ;;             ))


  (global-set-key (kbd "M-<tab>") 'ff-find-other-file)
  ;; (global-set-key (kbd "M-<tab>") 'projectile-find-other-file)
  (global-set-key (kbd "S-<tab>") 'clang-format-region)
  ;;(global-set-key (kbd "<C-iso-lefttab>") 'clang-format-buffer)
  (global-set-key (kbd "H-j") 'counsel-imenu)
  ;; (global-set-key (kbd "M-m") 'counsel-M-x)
  ;; (spacemacs/set-leader-keys "SPC" 'find-file)
  (spacemacs/set-leader-keys "SPC" 'find-file-in-project)
  ;;(global-set-key (kbd "M-r") 'counsel-M-x)
  ;;(global-set-key (kbd "M-e") 'end-of-line)
  (add-hook 'c-mode-hook (lambda ()
                           (local-set-key (kbd "M-e") 'c-end-of-statement)))
  (global-set-key (kbd "H-a") 'apropos)

  (defun open-projects ()
    (interactive)
    (dired (expand-file-name "~/Projects/")))
  (global-set-key (kbd "H-p") 'open-projects)
  ;;(defun edit-config ()
  ;;  (interactive)
  ;;  (evil-edit (expand-file-name "~/.spacemacs")))
  (global-set-key (kbd "H-d") 'spacemacs/find-dotfile)
  (global-set-key (kbd "H-k") 'kill-buffer)
  (setq-default sp-escape-quotes-after-insert nil)

  ;;; Config
  (c-add-style "my-style"
               '("stroustrup"
                 (c-basic-offset . 4)
                 (indent-tabs-mode . nil)
                 (c-offsets-alist
                  (inlambda . 0) ; no extra indent for lambda
                  ;; (member-init-intro . '++)
                  (member-init-intro . 8)
                  (innamespace . -))))

  (push '(other . "my-style") c-default-style)

  (setq-default dfmt-flags '("--brace_style=stroustrup"))
  (defun dformat ()
     (local-set-key (kbd "S-<tab>") 'dfmt-region-or-buffer))

  (add-hook 'd-mode-hook 'dformat)
  
  ;; (c-set-offset 'member-init-intro '++)
  (setq-default comment-column 15)
  (setq-default evil-vsplit-window-right t)
  (setq-default undo-tree-auto-save-history t)
  (setq-default undo-tree-history-directory-alist '(("." . "~/.emacs.d/undo")))
  (setq scroll-margin 3
        scroll-conservatively 9999
        scroll-step 1)

  (setq-default x86-lookup-pdf "~/Documents/x86-ref.pdf")

  (add-hook 'nasm-mode-hook
            (lambda () (local-set-key (kbd "H-l") 'x86-lookup)))

  (defun increase-font-size ()
    (interactive)
    (set-face-attribute 'default
                        nil
                        :height
                        (ceiling (* 1.10
                                    (face-attribute 'default :height)))))
  (defun decrease-font-size ()
    (interactive)
    (set-face-attribute 'default
                        nil
                        :height
                        (floor (* 0.90
                                  (face-attribute 'default :height)))))

  (defun default-font-size()
    (interactive)
    (set-face-attribute 'default
                        nil
                        :height
                        107))


  (add-hook 'org-mode-hook
            (lambda ()
              (local-set-key (kbd "H-SPC") 'org-toggle-latex-fragment)))

  (global-set-key (kbd "C-=") 'default-font-size)
  (global-set-key (kbd "C-+") 'increase-font-size)
  (global-set-key (kbd "C--") 'decrease-font-size)
  ;;(global-evil-mc-mode 1)
  ;;(global-set-key (kbd "H-e") 'evil-mc-undo-all-cursors)
  ;;(global-set-key (kbd "H-M-SPC") 'evil-mc-undo-last-added-cursor)
  ;;(global-set-key (kbd "H-SPC") 'evil-mc-make-and-goto-next-match)

  ;;(evil-define-key 'visual evil-mc-key-map
  ;;  "A" #'evil-mc-make-cursor-in-visual-selection-end
  ;;  "I" #'evil-mc-make-cursor-in-visual-selection-beg)



  ;; (setq org-format-latex-options (plist-put org-format-latex-options :scale 2.0))

  (setq-default tab-width 4)
  ;(setq-default dfmt-command "dfmt")

  (with-eval-after-load 'flycheck
    (setq-default flycheck-disabled-checkers
                  '(c/c++-cppcheck c/c++-gcc)))
  (add-to-list 'auto-mode-alist '("\\.h\\'" . c++-mode))
  (add-to-list 'auto-mode-alist '("\\.tpp\\'" . c++-mode))
  (add-to-list 'auto-mode-alist '("\\.php\\'" . web-mode))
  ;;(add-hook 'c++-mode-hook 'ggtags-mode)
  ;;(add-hook 'c-mode-hook 'ggtags-mode)
  (add-hook 'c++-mode-hook 'irony-mode)
  (add-hook 'c++-mode-hook 'auto-complete-mode)
  (add-hook 'c-mode-hook 'auto-complete-mode)
  (add-hook 'c-mode-hook 'irony-mode)
  (add-hook 'objc-mode-hook 'irony-mode)
  ;;(global-auto-complete-mode t)
  (setq ac-modes '(c++-mode c-mode
                   css-mode php-mode))

  (add-hook 'irony-mode-hook 'irony-cdb-autosetup-compile-options)

  (visual-line-mode t)
  (custom-set-variables
   '(flycheck-python-flake8-executable "python3")
   '(flycheck-python-pycompile-executable "python3")
   '(flycheck-python-pylint-executable "python3"))

  (setq-default fill-column 2000)
  (setq-default doc-view-continuous t)
  (add-hook 'csharp-mode-hook #'flycheck-mode)
  (add-hook 'emacs-lisp-mode-hook #'flycheck-mode)


  ;; (defun toggle-php-html-mode ()
  ;;   (interactive)
  ;;   "Toggle mode between PHP & Web modes"
  ;;   (cond ((string= mode-name "HTML helper")
  ;;          (php-mode))
  ;;         ((string= mode-name "PHP")
  ;;          (web-mode))))

  ;;(add-to-list 'auto-mode-alist '("\\.php\\'" . web-mode))
  ;; (setq-default indent-tabs-mode nil)
  ;; (setq-default web-mode-indent-markup-indent-offset 2)
  ;; (setq-default html-mode-indent-markup-indent-offset 2)
  ;; (setq-default php-mode-indent-markup-indent-offset 2)
  (defun azb/set-tabs (&optional tab-width)
    (let ((tw (or tab-width 2)))
      (setq tab-width tw)
      (setq web-mode-markup-indent-offset tw)
      (setq web-mode-css-indent-offset tw)
      ;;(setq web-mode-code-indent-offset tw)
      (setq web-mode-indent-style tw)
      ))
  (add-hook 'web-mode-hook (lambda ()
                             (local-set-key (kbd "H-p") 'php-mode)
                             (azb/set-tabs)))
  (add-hook 'php-mode-hook (lambda ()
                             (local-set-key (kbd "H-p") 'web-mode)
                             (azb/set-tabs)))
  (add-hook 'css-mode-hook (lambda () (azb/set-tabs)))


  (add-hook 'eshell-mode-hook
            (lambda ()
              ;; (local-set-key (kbd "C-c") 'eshell-interrupt-process)
              (local-set-key (kbd "C-d") 'eshell-send-eof-to-process)
              ))

  (add-hook 'shell-mode-hook
            (lambda ()
              (local-set-key (kbd "C-c") 'comint-interrupt-subjob)
              (local-set-key (kbd "C-d") 'comint-send-eof)
              ))
  (add-hook 'eshell-preoutput-filter-functions
            'ansi-color-filter-apply)

  (add-to-list 'magic-mode-alist '("<!DOCTYPE html>" . web-mode))
  (add-to-list 'magic-mode-alist '("<?php" . php-mode))

  (put 'flycheck-clang-args 'safe-local-variable (lambda (xx) t))
  (with-eval-after-load "flycheck"
    (setq flycheck-clang-warnings `(,@flycheck-clang-warnings
                                    "no-pragma-once-outside-header")))
  (add-hook 'c++-mode-hook (lambda ()
                             (setq flycheck-clang-language-standard "c++20")))

  (setq openwith-associations '(
                                ("\\.pdf\\'" "zathura" (file))
                                ("\\.docx\\'" "lowriter" (file))
                                ))
  ;;(global-subword-mode 1)
  (global-set-key (kbd "C-c e") 'spacemacs/find-dotfile)
 ;; (global-set-key (kbd "C-c f") 'subword-forward)
 ;; (global-set-key (kbd "C-c b") 'subword-backward);?

  (global-set-key (kbd "C-c b") 'ivy-switch-buffer)


  ;;(cursor setq-type )
  (openwith-mode t)
  (ranger-override-dired-mode t)        ;
  ;;(setq dired-listing-switches "-aBhl  --group-directories-first")

  (add-hook 'eshell-before-prompt-hook
            (lambda ()
              (setq xterm-color-preserve-properties t)))

  ;; (setq-default ffip-ignore-filenames
  ;;               (cons "*.*_" (remove "*.d" ffip-ignore-filenames)))

  ;;kinda vim-y keys
  ;;change is pointless since we're in 'normal mode' all the time
  ;;(global-set-key (kbd "H-c") 'evil-change)
  (global-set-key (kbd "H-M-v") 'evil-visual-line)
  (global-set-key (kbd "H-v") 'rectangle-mark-mode)
  ;;(global-set-key (kbd "M-l") (lambda)
  (global-set-key (kbd "M-h") 'mark-paragraph)

  (global-set-key (kbd "M-l") 'evil-visual-line)
                               ;(lambda ()
                               ; (interactive)
                               ; (beginning-of-line)
                               ; (call-interactively 'set-mark-command)
                               ; (end-of-line)
                               ; ))
  ;;(global-set-key (kbd "M-r") 'set-mark-command)
  (global-set-key (kbd "H-m") 'set-mark-command)

  (global-set-key (kbd "M-w") 'kill-ring-save)
  (global-set-key (kbd "C-w") 'kill-region)

  (global-set-key (kbd "H-y") 'evil-yank)
  (global-set-key (kbd "H-C-y") 'evil-yank-line)
  ;; y is kinda far away from hyper and i use yank line more often
  ;;(global-set-key (kbd "H-t") 'evil-yank-line)
  (global-set-key (kbd "H-o") 'evil-yank-line)
  (global-set-key (kbd "H-C-t") 'evil-yank)
  (global-set-key (kbd "M-o") 'set-mark-command);;?

  (defun move-line-up ()
    "Move up the current line."
    (interactive)
    (transpose-lines 1)
    (forward-line -2)
    (indent-according-to-mode))

  (defun move-line-down ()
    "Move down the current line."
    (interactive)
    (forward-line 1)
    (transpose-lines 1)
    (forward-line -1)
    (indent-according-to-mode))

  (global-set-key [(control shift up)]  'move-line-up)
  (global-set-key [(control shift down)]  'move-line-down)



  (global-set-key (kbd "M-s") 'evil-visual-char)
  ;;(global-set-key (kbd "M-r") 'azbyn/paste

  (global-set-key (kbd "H-C-p") 'evil-search-before)

  (global-set-key (kbd "H-g") 'evil-goto-first-line)
  (global-set-key (kbd "H-C-g") 'evil-goto-line)
  (global-set-key (kbd "H-8") 'spacemacs/enter-ahs-forward)
  (global-set-key (kbd "H-3") 'spacemacs/enter-ahs-backward)

  (global-set-key (kbd "H-5") 'evil-jump-item)

  (global-set-key (kbd "C-8") 'spacemacs/enter-ahs-forward)
  (global-set-key (kbd "C-3") 'spacemacs/enter-ahs-backward)


  (global-set-key (kbd "H-r") 'undo-tree-redo)
  (global-set-key (kbd "C-z") 'avy-goto-char)
  (global-set-key (kbd "H-u") 'undo-tree-undo)
  (global-set-key (kbd "H-.") 'evil-repeat)
  (global-set-key (kbd "H-n") 'evil-search-next)
  (global-set-key (kbd "H-N") 'evil-search-previous)
  (global-set-key (kbd "H-C-n") 'evil-search-previous)
  (global-set-key (kbd "H-C-d") 'evil-delete-whole-line)
  (global-set-key (kbd "H-l") 'evil-delete-whole-line)
  (global-set-key (kbd "H-C-l") 'evil-delete-line)

  (global-set-key (kbd "H-f") 'evil-find-char)
  (global-set-key (kbd "H-C-f") 'evil-find-char-backward)
  (defun azbyn/ffip ()
    (interactive)
    ;; find-file-in-project doesn't really work for directories with a
    ;; lot of files
    (if (member (azb-find-root (buffer-file-name))
                '(nil "/" "/home/azbyn/Projects" "/home/azbyn"))
        (ivy-switch-buffer)
      (progn
        (find-file-in-project)
        ;(insert-char ?/)
        )))

  (global-set-key (kbd "H-b") 'azbyn/ffip)
  (global-set-key (kbd "H-C-b") 'ivy-switch-buffer)
  (global-set-key (kbd "H-e") 'spacemacs/find-dotfile)
  (global-set-key (kbd "H-\\") 'evil-emacs-state)
  (global-set-key (kbd "H-/") 'evil-search-forward)
  (global-set-key (kbd "H-SPC") (lambda ()
                                  (interactive)
                                  (execute-kbd-macro (read-kbd-macro "M-m"))))
  ;; vim's definition of the being of the line is more useful
  (global-set-key (kbd "C-a") 'evil-first-non-blank)
  (global-set-key (kbd "C-;") 'comment-dwim)
  (global-set-key (kbd "M-;") 'comment-line)
  (global-set-key (kbd "H-h") 'help-command)
  (global-set-key (kbd "C-s-,") 'beginning-of-buffer)
  (global-set-key (kbd "C-s-.") 'end-of-buffer)
  ;(global-set-key (kbd "C-t") 'transpose-lines)
  (global-set-key (kbd "M-t") 'transpose-words)
  (global-set-key (kbd "H-g") 'exchange-point-and-mark)
  (global-set-key (kbd "H-C-g") 'goto-line)


  ;;(global-set-key (kbd "M-e") 'c-end-of-statement)
  (global-set-key (kbd "C-y") (lambda ()
                                (interactive)
                                (mark-word)
                                (call-interactively 'kill-ring-save)))
  (global-set-key (kbd "M-y") (lambda ()
                                (interactive)
                                (kill-ring-save (point) (line-end-position))))


  ;;TODO M-t -show killring
  ;;(global-set-key (kbd "M-f") 'evil-forward-subwo-begin)
  ;; todo
  ;;(global-set-key (kbd "<f1>") (lambda ()
  ;                               (interactive)
  ;                               (setq-local azb/save-point (point))))

  ;(global-set-key (kbd "<f2>") (lambda ()
  ;                               (interactive)
  ;                               (let (p azb/save-point)
  ;                                 (setq-local azb/save-point (point))
  ;                                 (push-mark p)
  ;                                 (exchange-point-and-mark)
  ;                                 (pop-mark)
  ;                                 )))

  (define-key evil-visual-state-map (kbd "C-w") nil)
  (define-key evil-motion-state-map (kbd "C-w") nil)

  (define-key evil-motion-state-map (kbd "C-b") nil)
  (define-key evil-motion-state-map (kbd "C-f") nil)
  (define-key evil-motion-state-map (kbd "C-o") nil)
  (define-key evil-motion-state-map (kbd "C-e") nil)
  (define-key evil-motion-state-map (kbd "C-y") nil)
  (define-key evil-motion-state-map (kbd "C-i") nil)
  (define-key evil-motion-state-map (kbd "C-u") nil)
  (define-key evil-motion-state-map (kbd "C-d") nil)
  

  ;; (setq-default evil-emacs-state-cursor '("#CC342B" bar))

  ;; (global-set-key (kbd "C-;") (lambda ()
  ;;                               (interactive)
  ;;                               (execute-kbd-macro (read-kbd-macro "M-;"))))

  ;;(add-to-list 'eshell-preoutput-filter-functions 'xterm-color-filter)
  ;;(setq eshell-output-filter-functions
   ;;     (remove 'eshell-handle-ansi-color eshell-output-filter-functions))
  ;;(setenv "TERM" "xterm-256color")
  (setq comint-output-filter-functions
        (remove 'ansi-color-process-output comint-output-filter-functions))
  (setq xterm-color-use-bold-for-bright t)
  
  (add-hook 'shell-mode-hook
          (lambda ()
            ;; Disable font-locking in this buffer to improve performance
            (font-lock-mode -1)
            ;; Prevent font-locking from being re-enabled in this buffer
            (make-local-variable 'font-lock-function)
            (setq font-lock-function (lambda (_) nil))
            (add-hook 'comint-preoutput-filter-functions 'xterm-color-filter nil t)))

;; Also set TERM accordingly (xterm-256color) in the shell itself.

;; An example configuration for eshell

;;(require 'eshell) ; or use with-eval-after-load

  (add-hook 'eshell-before-prompt-hook
            (lambda ()
              (setq xterm-color-preserve-properties t)))

  ;;(add-to-list 'eshell-preoutput-filter-functions 'xterm-color-filter)
  ;;(setq eshell-output-filter-functions (remove 'eshell-handle-ansi-color eshell-output-filter-functions))
  (setq eshell-output-filter-functions
        '(xterm-color-filter ansi-color-filter-apply))
  (setenv "TERM" "xterm-256color")
  ;;todo use the base16-google-dark-colors?
  ;; (setq xterm-color-names
  ;;       ["#1D1F21" ; black
  ;;        "#CC342B" ; red
  ;;        "#198844" ; green
  ;;        "#FBA922" ; yellow
  ;;        "#3971ED" ; blue
  ;;        "#A36AC7" ; magenta
  ;;        "#12A59C" ; cyan
  ;;        "#E0E0E0" ; white
  ;;        ])
   ;; (setq xterm-color-names-bright
  ;;       ["#969896" ; black
  ;;        "#CC342B" ; red
  ;;        "#198844" ; green
  ;;        "#FBA922" ; yellow
  ;;        "#3971ED" ; blue
  ;;        "#A36AC7" ; magenta
  ;;        "#12A59C" ; cyan
  ;;        "#FFFFFF" ; white
  ;;        ])
  ;(setq-default ispell-dictionary "english")

  ;;scroll screen not point
  (global-set-key "\M-N"  (lambda () (interactive) (scroll-up   1)))
  (global-set-key "\M-P"  (lambda () (interactive) (scroll-down 1)))

  ;;(add-hook poetry-mode-hook 'flyspell-mode)
                                        ;(setq-default dotspacemacs-configuration-layers
                                        ;              '(()))

  ;;(require 'auto-capitalize);?
  )

(defun azb/terminal()
  (switch-to-buffer "*scratch*")
  (set-face-background 'default "unspecified-bg" (selected-frame))
  ;; (setq spaceline-workspace-numbers-unicode nil)
  ;; (setq spaceline-window-numbers-unicode nil)
  )
(defun on-after-init ()
  (unless (display-graphic-p (selected-frame))
    (set-face-background 'default "unspecified-bg" (selected-frame))))

(add-hook 'window-setup-hook 'on-after-init)
(setq custom-file (expand-file-name "~/.emacs.d/custom.el"))

;;(setq cap-mode-file (expand-file-name "~/.emacs.d/auto-capitalize.el"))
;;(load cap-mode-file 'no-error 'no-message)
(setq poetry-mode-file (expand-file-name "~/.emacs.d/poetry-mode.el"))
(load poetry-mode-file 'no-error 'no-message)
;;(setq custom-file (expand-file-name "~/.spacemacs.d/custom.el"))
(load custom-file 'no-error 'no-message)
