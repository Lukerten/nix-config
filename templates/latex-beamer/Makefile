# Use > as the recipe prefix for better readability
.RECIPEPREFIX = >

# Define variables
TEX = pdflatex
BIB = bibtex
SRC_DIR = src
OUT_DIR = out
MAIN_TEX = main.tex
PDF = $(OUT_DIR)/presentation.pdf

# Ensure necessary tools are installed
check-tools:
> for tool in pdflatex bibtex mkdir gum xdg-open; do \
>   if ! which $$tool >/dev/null 2>&1; then \
>     echo "Error: $$tool is not installed. Please install it." >&2; \
>     exit 1; \
>   fi; \
> done

# Ensure the output directory exists
$(OUT_DIR): check-tools
> mkdir -p $(OUT_DIR)

# Build the presentation
$(PDF): $(SRC_DIR)/$(MAIN_TEX) | $(OUT_DIR)
> export TEXINPUTS=$(SRC_DIR)::
> cd $(SRC_DIR) && $(TEX) -output-directory=../$(OUT_DIR) $(MAIN_TEX)
> cd $(SRC_DIR) && $(TEX) -output-directory=../$(OUT_DIR) $(MAIN_TEX) # Run twice for references
> mv $(OUT_DIR)/$(MAIN_TEX:.tex=.pdf) $(PDF)

# Run BibTeX if needed
bib: check-tools
> which $(BIB) >/dev/null 2>&1
> cd $(SRC_DIR) && $(BIB) ../$(OUT_DIR)/main.aux
> cd $(SRC_DIR) && $(TEX) -output-directory=../$(OUT_DIR) $(MAIN_TEX)
> cd $(SRC_DIR) && $(TEX) -output-directory=../$(OUT_DIR) $(MAIN_TEX)

# Open the PDF after building it if necessary
open: $(PDF)
> xdg-open $(PDF)

# Clean up auxiliary files
clean:
> rm -rf $(OUT_DIR)/*.aux $(OUT_DIR)/*.log $(OUT_DIR)/*.out $(OUT_DIR)/*.toc $(OUT_DIR)/*.bbl $(OUT_DIR)/*.blg

# Remove all generated files
distclean: clean
> rm -rf $(OUT_DIR)

# Default target
all: $(PDF)

.PHONY: all clean distclean bib help check-tools open
