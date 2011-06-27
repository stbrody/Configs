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

(setq custom-file
	  (concat conf-home "custom.el"))
(load custom-file 'noerror)


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
  (setq indent-tabs-mode nil)) ;; force only spaces for indentation
(add-hook 'c-mode-common-hook 'my-c-mode-common-hook)



(require 'linum)
(require 'cc-mode)
;(load-file "/usr/share/emacs/site-lisp/xcscope.el")
(require 'xcscope)
(setq cscope-display-cscope-buffer nil)

;; Remove splash screen
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

(global-set-key [(f9)] 'compile)
(global-set-key [(control tab)] 'dabbrev-expand)
(global-set-key "\C-z" 'undo)

(setq compilation-window-height 8)

(setq compilation-finish-function
      (lambda (buf str)

        (if (string-match "exited abnormally" str)

            ;;there were errors
            (message "compilation errors, press C-x ` to visit")

          ;;no errors, make the compilation window go away in 0.5 seconds
          (run-at-time 0.5 nil 'delete-windows-on buf)
          (message "NO COMPILATION ERRORS!"))))

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

;;(message "%s" (lookup-key global-map [(meta tab)]))
(put 'scroll-left 'disabled nil)
