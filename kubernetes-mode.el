;;; kubernetes-mode --- kubernetes-mode configuration.

;;; Commentary:

;;; Code:
(eval-when-compile
  (require 'rx))

(defgroup kubernetes nil
  "Major mode for Kubernetes manifests."
  :group 'languages
  :prefix "kubernetes-")

(defcustom kubernetes-mode-hook nil
  "Hook run by kubernetes-mode."
  :type 'hook
  :group 'kubernetes)

(defcustom kubernetes-indent-offset 2
  "Tab width to use when indenting."
  :type 'integer
  :group 'kubernetes)

(defvar kubernetes-doc-separator-face
  (rx "---"))

(defvar kubernetes-key-face
  (rx (zero-or-more blank)
      (one-or-more alpha)
      ":"
      (or eol space)))

(defvar kubernetes-string-face
  (rx "\""
      (zero-or-more any)
      "\""))

(defvar kubernetes-font-lock-defaults
  `(((,kubernetes-doc-separator-face . font-lock-constant-face)
     (,kubernetes-key-face . font-lock-keyword-face)
     (,kubernetes-string-face . font-lock-type-face))))

(defvar kubernetes-mode-syntax-table
  (let ((st (make-syntax-table)))
    (modify-syntax-entry ?\" "\"" st)
    (modify-syntax-entry ?\' "'" st)
    st))

(define-derived-mode kubernetes-mode yaml-mode
  "kubernetes"
  "Major-mode for Kubernetes manifests."
  :syntax-table kubernetes-mode-syntax-table
  (setq font-lock-defaults kubernetes-font-lock-defaults)
  (setq yaml-indent-offset kubernetes-indent-offset))

(provide 'kubernetes-mode)

;;; kubernetes-mode.el ends here
