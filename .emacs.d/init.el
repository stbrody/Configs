(defvar *emacs-load-start* (current-time))


;; This gives us `third'
(require 'cl)

;;;;Set up emacs paths
(setq conf-home (concat (file-name-as-directory (expand-file-name "~"))
						(file-name-as-directory ".emacs.d")))

(setq conf-tmp (concat conf-home
                       (file-name-as-directory "tmp")))

;; Add to the end of the list
(add-to-list 'load-path (concat conf-home "elisp") t)
(add-to-list 'load-path (concat conf-home (file-name-as-directory "elisp") "compiled") t)

(setq custom-file
	  (concat conf-home "custom.el"))
(load custom-file 'noerror)

;; Enable Melpa package manager
;(require 'package)
;(add-to-list 'package-archives
;             '("melpa" . "https://melpa.org/packages/") t)
;(package-initialize)
;(package-refresh-contents)

;; Rust stuff
;(require 'rust-mode)

;(setq racer-cmd "~/.cargo/bin/racer") ;; Rustup binaries PATH
;(setq racer-rust-src-path "/Users/Spencer/rustSrc/src") ;; Rust source code PATH

;(add-hook 'rust-mode-hook #'racer-mode)
;(add-hook 'racer-mode-hook #'eldoc-mode)
;(add-hook 'racer-mode-hook #'company-mode)

;; golang stuff
;(add-to-list 'load-path "/usr/local/go/misc/emacs")
;(require 'go-mode-load)

;;;;Set up C indentation
(defun my-build-tab-stop-list (width)
  (let ((num-tab-stops (/ 80 width))
	(counter 1)
	(ls nil))
    (while (<= counter num-tab-stops)
      (setq ls (cons (* width counter) ls))
      (setq counter (1+ counter)))
    (set (make-local-variable 'tab-stop-list) (nreverse ls))))
(defun my-c-mode-common-hook ()
  (setq tab-width 4) ;; change this to taste, this is what K&R uses :)
  (my-build-tab-stop-list tab-width)
  (setq c-basic-offset tab-width)
  (setq indent-tabs-mode nil) ;; force only spaces for indentation
  ;; Highlight lines longer than 100 characters
  (font-lock-add-keywords nil '(("^[^\n]\\{100\\}\\(.*\\)$" 1 font-lock-warning-face t))))
(add-hook 'c-mode-common-hook 'my-c-mode-common-hook)



(require 'linum)
(require 'cc-mode)

;; Highlight lines over 100 chars
(require 'whitespace)
(setq whitespace-line-column 100) ;; limit line length
(setq whitespace-style '(face lines-tail))
;(add-hook 'prog-mode-hook 'whitespace-mode)
;(global-whitespace-mode +1)

(setq inhibit-splash-screen t)
(show-paren-mode t)
(line-number-mode 1)
(column-number-mode 1)
(transient-mark-mode t)
(global-linum-mode 1)
(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)
(setq-default show-trailing-whitespace t)
(setq-default make-backup-files t)
(setq-default version-control t)
(setq-default backup-directory-alist (quote ((".*" . "~/.emacs_backups/"))))
(setq-default delete-old-versions t)
(setq-default scroll-conservatively 1)

(global-set-key "\C-z" 'undo)


;; Time how long it took to start up.
(let ((the-time (current-time)))
  (message "My .emacs loaded in %dms"
           (/ (-
               (+
                (third the-time)
                (* 1000000
                   (second the-time)))
               (+
                (third *emacs-load-start*)
                (* 1000000
                   (second *emacs-load-start*)))
               ) 1000)))
