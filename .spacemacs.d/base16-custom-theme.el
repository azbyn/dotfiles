;; base16-custom-theme.el -- A base16 colorscheme

;;; Commentary:
;; Base16: (https://github.com/chriskempson/base16)

;;; Authors:
;; Scheme: azbyn (original by Seth Wright)
;; Template: Kaleb Elwert <belak@coded.io>

;;; Code:

(require 'base16-theme)

(defvar base16-custom-colors
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
    :base0F "#FBA922")
  "All colors for Base16 Google Dark - Modified are defined here.")

;; Define the theme
(deftheme base16-custom)

;; Add all the faces to the theme
(base16-theme-define 'base16-custom base16-custom-colors)

;; Mark the theme as provided
(provide-theme 'base16-custom)

(provide 'base16-custom-theme)

;;; base16-custom-theme.el ends here
