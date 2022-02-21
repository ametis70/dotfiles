;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "Ian Mancini"
      user-mail-address "contacto@ianmancini.com.ar")

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
(setq doom-font (font-spec :family "Iosevka Nerd Font" :size 14))
;;       doom-variable-pitch-font (font-spec :family "sans" :size 13))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-one)
(setq doom-themes-treemacs-theme "doom-colors")

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/.org/")

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)


;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.


(use-package! org)
(use-package! org-clock)

(after! org
  (setq org-modules '(ol-w3m ol-bbdb ol-bibtex ol-docview ol-gnus ol-info ol-irc ol-mhe ol-rmail ol-eww ol-bibtex))
  (setq org-latex-pdf-process (list "latexmk -shell-escape -bibtex -f -pdf %f"))
  (add-hook 'org-mode-hook 'visual-line-mode)
  (add-hook 'org-mode-hook '(lambda () (setq fill-column 80)))
  (add-hook 'org-mode-hook 'turn-on-auto-fill)
  (setq org-ellipsis " ... "
        org-bullets-bullet-list '("⁖")
        org-todo-keywords '((sequence "TODO(t)" "NEXT(n)" "WIP(i)" "INACTIVE(x)" "WAITING(w)" "|" "DONE(d)" "CANCELLED(c)"))
        org-todo-keyword-faces
        '(("TODO" :inherit +org-todo-onhold :weight normal :underline t)
          ("NEXT" :inherit +org-todo-onhold :weight normal :underline t)
          ("WIP" :inherit org-todo :weight normal :underline t)
          ("WAITING" :inherit +org-todo-active :weight normal :underline t)
          ("INACTIVE" :inherit +org-todo-active :weight normal :underline t)
          ("DONE" :inherit +org-todo-project :weight normal :underline t)
          ("CANCELLED" :inherit org-priority :weight normal :underline t))
        )
  (setq org-log-done 'time)
  (setq org-agenda-files (apply 'append
                                (mapcar
                                 (lambda (directory)
                                   (directory-files-recursively
                                    directory org-agenda-file-regexp))
                                 '("~/.org/work/" "~/.org/projects/" "~/.org/learning/" "~/.org/calendars" "~/.org/conferences/"))))
  (setq org-roam-directory (file-truename "~/.org/roam"))
  (org-roam-db-autosync-mode)
  )

(use-package! org-fancy-priorities
  :after org
  :ensure t
  :hook
  (org-mode . org-fancy-priorities-mode)
  :config
  (setq org-fancy-priorities-list '("▴" "▸" "▾")))

(use-package! org-bullets
  :after org
  :config
  (add-hook 'org-mode-hook (lambda () (org-bullets-mode 1))))

; (use-package! org-ref
;   :after org
;   :config
;   (setq bibtex-completion-pdf-field 'file)
;   (defun my/org-ref-open-pdf-at-point ()
;     "Open the pdf for bibtex key under point if it exists."
;     (interactive)
;     (let* ((results (org-ref-get-bibtex-key-and-file))
;            (key (car results))
;            (pdf-file (car (bibtex-completion-find-pdf key))))
;       (if (file-exists-p pdf-file)
;           (find-file pdf-file) ; original in org-ref-help,
;                                         ; opens external viewer (org-open-file pdf-file)
;         (message "No PDF found for %s" key))))
;   (setq org-ref-open-pdf-function 'find-file)
;
;   (setq bibtex-file "~/.org/biblio.bib"
;         bibtex-completion-bibliography bibtex-file
;         reftex-default-bibliography bibtex-file
;         org-ref-default-bibliography (list bibtex-file)
;         org-ref-completion-library 'org-ref-ivy-cite
;         org-ref-bibliography-notes "~/.org/biblio-notes.org"
;         org-ref-pdf-directory "~/.org/biblio-pdfs/")
;   )

(setq deft-directory "~/.org"
      deft-recursive t)

(setq undo-limit 100000000                        ; Raise undo-limit to 100mb
      evil-want-fine-undo nil)                    ; By default while in insert all changes are one big blob. Be more granular

(setq-default delete-by-moving-to-trash t)                ; Delete files to trash

(defvar holiday-custom-holidays nil
  "Custom holidays.")

(setq holiday-custom-holidays
      '((holiday-fixed 1 1 "Año nuevo")
        (holiday-fixed 2 14 "San Valentín")
        (holiday-fixed 3 24 "Día Nacional de la Memoria por la Verdad y la Justicia")
        (holiday-fixed 4 1 "April Fools")
        (holiday-fixed 4 2 "Día del Veterano y de los Caídos en la Guerra de Malvinas")
        (holiday-fixed 5 1 "Día de lx trabajadorx")
        (holiday-fixed 5 25 "Día de la Revolución de Mayo")
        (holiday-fixed 6 17 "Paso a la Inmortalidad del General Martín Miguel de Güemes")
        (holiday-fixed 6 20 "Paso a la Inmortalidad del General Manuel Belgrano")
        (holiday-fixed 7 9 "Día de la Independencia")
        (holiday-fixed 8 17 "Paso a la Inmortalidad del General José de San Martín")
        (holiday-fixed 9 11 "Día de lx Maestrx")
        (holiday-fixed 9 21 "Día de lx Estudiante")
        (holiday-fixed 10 12 "Día del Respeto a la Diversidad Cultural")
        (holiday-fixed 10 31 "Halloween")
        (holiday-fixed 11 20 "Día de la Soberanía Nacional")
        (holiday-fixed 12 8 "Día de la Inmaculada Concepción de María")
        (holiday-fixed 12 25 "Navidad")))

(setq calendar-holidays holiday-custom-holidays)


(use-package! org-caldav
  :after org
  :config
  (setq org-caldav-url "https://nextcloud.trov.ar/remote.php/dav/calendars/ianmethyst/"
        org-caldav-calendar-id "contact_birthdays"
        inbox-file (concat org-directory "calendars/nextcloud-caldav.org")
        org-caldav-files (list inbox-file)
        org-caldav-inbox inbox-file
        org-icalendar-timezone "America/Buenos_Aires"
        org-caldav-sync-direction 'cal->org)

  (defun fix-birthdays-timestamps ()
    "Fix birthdays fetched from nextcloud with org-caldav not being repeating events."
    (let (birthdays-buffer find-replace)
      ;; FIXME: This assumes the file exists
      (setq birthdays-buffer (find-file-other-window (concat org-directory "calendars/nextcloud-caldav.org")))
      ;; NOTE: Remove repeating timestamps in case this function was executed previously
      (setq find-replace (lambda (patt newtext)
                           (goto-char (point-min)) ;; In case buffer is open
                           (while (search-forward-regexp patt nil t)
                             (replace-match newtext nil t))))
      (funcall #'find-replace "\\s-+\\+1y>" ">")
      (funcall #'find-replace ">" " +1y>")
      (save-buffer)))

  (advice-add
   'org-caldav-sync
   :after
   #'fix-birthdays-timestamps))

(setq +format-with-lsp nil)

(use-package! websocket
    :after org-roam)

(use-package! org-roam-ui
    :after org-roam ;; or :after org
;;         normally we'd recommend hooking orui after org-roam, but since org-roam does not have
;;         a hookable mode anymore, you're advised to pick something yourself
;;         if you don't care about startup time, use
;;  :hook (after-init . org-roam-ui-mode)
    :config
    (setq org-roam-ui-sync-theme t
          org-roam-ui-follow t
          org-roam-ui-update-on-save t
          org-roam-ui-open-on-start t))

(add-to-list 'load-path "/usr/share/emacs/site-lisp/mu4e")
(set-email-account! "ianmancini"
  '((mu4e-sent-folder       . "/Sent Items")
    (mu4e-drafts-folder     . "/Drafts")
    (mu4e-trash-folder      . "/Trash")
    (mu4e-refile-folder     . "/All Mail")
    (smtpmail-smtp-user     . "contacto@ianmancini.com.ar")
    (mu4e-compose-signature . "\nIan Mancini"))
  t)
