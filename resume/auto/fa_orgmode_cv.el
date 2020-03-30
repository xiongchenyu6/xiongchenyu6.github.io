(TeX-add-style-hook
 "fa_orgmode_cv"
 (lambda ()
   (TeX-add-to-alist 'LaTeX-provided-package-options
                     '(("layaureo" "big")))
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "path")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "url")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "nolinkurl")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "hyperbaseurl")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "hyperimage")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "hyperref")
   (add-to-list 'LaTeX-verbatim-macros-with-delims-local "path")
   (TeX-run-style-hooks
    "url"
    "calc"
    "parskip"
    "titlesec"
    "enumitem"
    "layaureo"
    "color"
    "hyperref")
   (LaTeX-add-color-definecolors
    "linkcolour"
    "sectionothercolor"
    "sectioncolor"))
 :latex)
