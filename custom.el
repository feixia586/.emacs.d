;;; This file contains some temporary code snippets, it will be loaded after
;;; various oh-my-emacs modules. When you just want to test some code snippets
;;; and don't want to bother with the huge ome.*org files, you can put things
;;; here.

;; For example, oh-my-emacs disables menu-bar-mode by default. If you want it
;; back, just put following code here.
(menu-bar-mode t)

;;; You email address
(setq user-mail-address "feixia@cs.cmu.edu")

;;; Calendar settings
;; you can use M-x sunrise-sunset to get the sun time
(setq calendar-latitude 39.9)
(setq calendar-longitude 116.3)
(setq calendar-location-name "Beijing, China")

;;; Time related settings
;; show time in 24hours format
(setq display-time-24hr-format t)
;; show time and date
(setq display-time-and-date t)
;; time change interval
(setq display-time-interval 10)
;; show time
(display-time-mode t)

;;; Some tiny tool functions
(defun replace-all-chinese-quote ()
  (interactive)
  (save-excursion
    (mark-whole-buffer)
    (replace-regexp  "”\\|“" "\"")
    (mark-whole-buffer)
    (replace-regexp "’\\|‘" "'")))

;; Comment function for GAS assembly language
(defun gas-comment-region (start end)
  "Comment region for AT&T syntax assembly language The default
comment-char for gas is ';', we need '#' instead"
  (interactive "r")
  (setq end (copy-marker end t))
  (save-excursion
    (goto-char start)
    (while (< (point) end)
      (beginning-of-line)
      (insert "# ")
      (next-line))
    (goto-char end)))

(defun gas-uncomment-region (start end)
  "Uncomment region for AT&T syntax assembly language the
inversion of gas-comment-region"
  (interactive "r")
  (setq end (copy-marker end t))
  (save-excursion
    (goto-char start)
    (while (< (point) end)
      (beginning-of-line)
      (if (equal (char-after) ?#)
          (delete-char 1))
      (next-line))
    (goto-char end)))

;;; Added by Fei
;;; map "jj" to ESC
(add-to-list 'load-path "~/.emacs.d/fei/")
(require 'key-chord)
(setq key-chord-two-keys-delay 0.5)
(key-chord-define evil-insert-state-map "jj" 'evil-normal-state)
(key-chord-mode 1)

;;; init windows
(split-window-horizontally)
(balance-windows)

;;; set c indent with two spaces
(setq-default c-basic-offset 2)

;;; compile issue
;; bind F5 to compile -- makefile in current directory
(global-set-key (kbd "<f5>") 'compile)
;; bind F6 to compile -- makefile in parent directory
(global-set-key [f6] (lambda () (interactive) (compile (format "make -k -C .." ))))
;; no compilation command and don't need to press enter
(setq compilation-read-command nil);

;; add *.cu file to C++ mode
(setq auto-mode-alist(cons '("\\.cu$"   . c++-mode)  auto-mode-alist))

;; activate cuda mode
;(autoload 'cuda-mode "cuda-mode.el")
;(add-to-list 'auto-mode-alist '("\\.cu\\'" . cuda-mode))

;; define function to comment current line or active region
(defun comment-or-uncomment-line-or-region ()
    "Comments or uncomments the region or the current line if there's no active region."
    (interactive)
    (let (beg end)
        (if (region-active-p)
            (setq beg (region-beginning) end (region-end))
            (setq beg (line-beginning-position) end (line-end-position)))
        (comment-or-uncomment-region beg end)
        (next-line)))
(global-set-key (kbd "C-M-;") 'comment-or-uncomment-line-or-region)
;(define-key c-mode-base-map (kbd "C-/") 'comment-or-uncomment-line-or-region)

;; add pdflatex engine for tex. Methods: M-x group-customize -> auctex -> tex-command
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(TeX-engine-alist (quote ((pdflatex "pdflatex" "pdftex" "pdflatex" "")))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; set default tex engine
(setq-default TeX-engine 'pdflatex)

;; Setting up matlab-mode
(add-to-list 'load-path "~/.emacs.d/fei/matlab-emacs")
(load-library "matlab-load")
(custom-set-variables
 '(matlab-shell-command-switches '("-nodesktop -nosplash")))
(add-hook 'matlab-mode
        (lambda ()
          (auto-complete-mode 1)
          ))
(setq matlab-auto-indent t)
(setq auto-mode-alist
    (cons
     '("\\.m$" . matlab-mode)
     auto-mode-alist))

