;; base16-base16-custom-theme.el -- A base16 colorscheme

;;; Commentary:
;; Base16: (https://github.com/chriskempson/base16)

;;; Authors:
;; Scheme: azbyn (original by Seth Wright)
;; Template: Kaleb Elwert <belak@coded.io>

;;; Code:

(require 'base16-theme)

(defvar base16-base16-custom-colors
  '(:base00 "#1D1F21"
    :base01 "#282A2E"
    :base02 "#373B41"
    :base03 "#969896"
    :base04 "#B4B7B4"
    :base05 "#E0E0E0"
    :base06 "#F0F0F0"
    :base07 "#FFFFFF"
    :base08 "#CC342B"
    :base09 "#F96A38"
    :base0A "#FBA922"
    :base0B "#198844"
    :base0C "#12A59C"
    :base0D "#3971ED"
    :base0E "#A36AC7"
    :base0F "#FBA922")
  "All colors for Base16 Google Dark - Modified are defined here.")

;; Define the theme
(deftheme base16-base16-custom)

;; Add all the faces to the theme
(base16-theme-define 'base16-base16-custom base16-base16-custom-colors)

;; Mark the theme as provided
(provide-theme 'base16-base16-custom)

(provide 'base16-base16-custom-theme)

;;; base16-base16-custom-theme.el ends here
