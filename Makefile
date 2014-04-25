print=false

all: thesis-text

thesis-text:
ifeq ($(print),true)
	echo "\toggletrue{withofficialdesc}" > flags.tex
else
	echo "" > flags.tex
endif
	pdflatex -interaction=nonstopmode -synctex=1 index.tex
	bibtex index.aux
	pdflatex -interaction=nonstopmode -synctex=1 index.tex > /dev/null
	pdflatex -interaction=nonstopmode -synctex=1 index.tex > /dev/null
	mv index.pdf thesis-text.pdf

start: thesis-text
	evince thesis-text.pdf

clean:
	rm -rf *.{log,out,pdf,aux,tfm,600pk,514pk,fls,toc,bbl,blg,fdb_latexmk,synctex.gz} flags.tex

slice: thesis-text
ifeq ($(print),true)
	pdftk thesis-text.pdf cat 14 19 38 43 output color-thesis.pdf
	pdftk thesis-text.pdf cat 1-13 15-18 20-37 39-42 44 output black-thesis.pdf
else
	pdftk thesis-text.pdf cat 13 18 37 42 output color-thesis.pdf
	pdftk thesis-text.pdf cat 1-12 14-17 19-36 38-41 43 output black-thesis.pdf
endif
