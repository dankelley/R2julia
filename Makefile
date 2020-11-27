R2j.pdf: R2j.Rmd
	R --no-save -e 'library(rmarkdown); render("$<", "pdf_document")'

