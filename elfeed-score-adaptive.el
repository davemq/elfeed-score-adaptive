;; Add adaptive scoring to elfeed-score.

(require 'elfeed)
(require 'elfeed-score)

(provide 'elfeed-score-adaptive)

;; Eventually we want a way to configure the scores that get added for
;; different elfeed actions
(defvar elfeed-score-adaptive-alist
  '(('untag nil)
    ('show nil))
   "List of score actions to take for different elfeed-search entry actions"
  )

(defun elfeed-score-adaptive-show (entry)
  "Update scores for shown entry")

(defun elfeed-score-adaptive-untag ()
  "Update scores for entry unmarked as unread")


;; It would be nice if there were hooks for the various actions in the
;; *elfeed-search* buffer, e.g. RET shows an entry, "r" untags unread entries,
;; i.e. marks them as read. I think these are the ones I care about for now.
;; The functions they call don't have hooks, so we'll have to advise them.

;; For "show" (RET), advise elfeed-search-
(advice-add (lookup-key elfeed-search-mode-map (kbd "RET"))
            :after
            #'elfeed-score-adaptive-show
            )

;; For "untag" ("r"), advise elfeed-search-untag-all-unread
(advice-add (lookup-key elfeed-search-mode-map "r")
            :after
            #'elfeed-score-adaptive-untag
            )
