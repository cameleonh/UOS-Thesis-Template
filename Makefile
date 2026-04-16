# Makefile for UOS Thesis Template
# Usage: make [target]

MAIN    = main
TEX     = xelatex
BIB     = biber
FLAGS   = -interaction=nonstopmode -synctex=1

.PHONY: all clean view dist

all: $(MAIN).pdf

$(MAIN).pdf: main.tex uos-thesis.cls references.bib chapters/*.tex
	$(TEX) $(FLAGS) $(MAIN)
	$(BIB) $(MAIN)
	$(TEX) $(FLAGS) $(MAIN)
	$(TEX) $(FLAGS) $(MAIN)

view: $(MAIN).pdf
	@if command -v xdg-open > /dev/null 2>&1; then \
		xdg-open $(MAIN).pdf; \
	elif command -v open > /dev/null 2>&1; then \
		open $(MAIN).pdf; \
	fi

clean:
	rm -f $(MAIN).aux $(MAIN).bbl $(MAIN).bcf $(MAIN).blg \
	      $(MAIN).fdb_latexmk $(MAIN).fls $(MAIN).log $(MAIN).out \
	      $(MAIN).run.xml $(MAIN).synctex.gz $(MAIN).toc \
	      $(MAIN).lof $(MAIN).lot $(MAIN).xdv $(MAIN).pdf \
	      chapters/*.aux

dist: all
	@mkdir -p dist
	@cp $(MAIN).pdf dist/
	@echo "✅ PDF copied to dist/$(MAIN).pdf"
