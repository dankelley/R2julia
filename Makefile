all: R2j.pdf r2julia.pdf
r2julia.pdf: r2julia.typ
	typst compile $<
R2j.pdf: R2j.Rmd
	R --no-save -e 'library(rmarkdown); render("$<", "pdf_document")'

