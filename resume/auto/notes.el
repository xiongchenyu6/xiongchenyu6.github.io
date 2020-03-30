(TeX-add-style-hook
 "notes"
 (lambda ()
   (TeX-add-to-alist 'LaTeX-provided-class-options
                     '(("article" "11pt")))
   (TeX-add-to-alist 'LaTeX-provided-package-options
                     '(("inputenc" "utf8") ("fontenc" "T1") ("ulem" "normalem")))
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "hyperref")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "hyperimage")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "hyperbaseurl")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "nolinkurl")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "url")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "path")
   (add-to-list 'LaTeX-verbatim-macros-with-delims-local "path")
   (TeX-run-style-hooks
    "latex2e"
    "article"
    "art11"
    "inputenc"
    "fontenc"
    "graphicx"
    "grffile"
    "longtable"
    "wrapfig"
    "rotating"
    "ulem"
    "amsmath"
    "textcomp"
    "amssymb"
    "capt-of"
    "hyperref")
   (LaTeX-add-labels
    "sec:org26a8fb8"
    "sec:orgee357cc"
    "sec:org13ccb21"
    "sec:org42f9c06"
    "sec:org6e21d51"
    "sec:orgcabbbcf"
    "sec:orgf634181"
    "sec:org3b328c0"
    "sec:org4126cb5"
    "sec:org5073f60"
    "sec:org146398f"
    "sec:orgf4de09d"
    "sec:orgd479f2d"
    "sec:org6d319e9"
    "sec:org2137d67"
    "sec:orgf229524"
    "sec:org9a8f2df"
    "sec:org2079ac4"
    "sec:org83f8b22"
    "sec:orge4cda5a"
    "sec:orgaccf3bd"
    "sec:org758f570"
    "sec:orga5b95f4"
    "sec:orgdf6f404"
    "sec:org90bdb7c")
   (LaTeX-add-index-entries
    "Notes"))
 :latex)
