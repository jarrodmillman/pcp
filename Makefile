BUILDDIR  = _build
TEX2PDF  := cd $(BUILDDIR) && TEXINPUTS="../..:" pdflatex -shell-escape #-interaction=batchmode
BIBTEX   := cd $(BUILDDIR) && bibtex

all: clean final

clean:
	rm -rf $(BUILDDIR)/* *.pdf

$(BUILDDIR):
	mkdir -p $@

$(BUILDDIR)/%.pdf: %.tex
	($(TEX2PDF) $(<F) 1>/dev/null)


final: final.tex $(BUILDDIR)
	cp final.tex $(BUILDDIR)/.
	cp final.bib $(BUILDDIR)/.
	($(TEX2PDF) final.tex)
	($(BIBTEX) final)
	($(TEX2PDF) final.tex)
	($(TEX2PDF) final.tex)
	cp $(BUILDDIR)/$(@).pdf $(@).pdf 
