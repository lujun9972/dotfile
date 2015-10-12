
;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
;(package-initialize)

(defvar init-files-alist '(("~/.emacs.d/init.el" . nil)
						   ("~/emacs-init/init.el" . t))
  "元素的car为初始化文件的路径,cdr为是否更改`user-emacs-directory'的值")

(defvar init-files nil
  "可选的初始化文件列表")
(dolist (init-file (mapcar #'car init-files-alist))
  (when (file-exists-p init-file)
	(add-to-list 'init-files init-file t)))

(defun gen-select-init-files-prompt (init-files)
  (let (select-init-files-prompt)
	(dotimes (id (length init-files) select-init-files-prompt)
	  (push (format "%s : %s" id (nth id init-files)) select-init-files-prompt))
	(concat (mapconcat 'identity (nreverse select-init-files-prompt) "\n") "\n请选择初始化文件: ")))

(defcustom init-file-timeout 5
  "选择初始化文件的超时时间")
(defvar init-file (cond ((= 1 (length init-files))
						 (car init-files))
						(t (nth (with-timeout (init-file-timeout 0)
								  (read-number (gen-select-init-files-prompt init-files) 0)) init-files)))
  
  "加载的初始化文件")
(when (cdr (assoc init-file init-files-alist))
  (setq user-emacs-directory (file-name-directory init-file)))
(load init-file)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
	(org2blog w3m emms diff-hl gist yasnippet projectile smart-compile flymake-cppcheck dos lua-mode deferred lispy zeal-at-point ws-butler wgrep switch-window sunrise-x-w32-addons sunrise-x-tree sunrise-x-tabs sunrise-x-popviewer sunrise-x-modeline sunrise-x-loop sunrise-x-checkpoints sunrise-x-buttons sr-speedbar smex slime showkey redshank paredit markdown-mode magit keyfreq info+ idomenu ido-ubiquitous ibuffer-vc git-timemachine ggtags fullframe evil discover-my-major discover dired-sort dired+ dictionary deft clean-aindent-mode bbdb auto-complete))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(org-mode-line-clock ((t (:foreground "red" :box (:line-width -1 :style released-button)))) t))
