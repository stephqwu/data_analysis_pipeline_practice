# Define paths to scripts and data
SCRIPT_DIR = scripts
DATA_DIR = data
RESULTS_DIR = results
PLOTS_DIR = $(RESULTS_DIR)/figure
REPORT_DIR = report

# Define the files to be processed
FILES = isles abyss last sierra

# Word count output files
DAT_FILES = $(FILES:%=$(RESULTS_DIR)/%.dat)

# Plot output files
PNG_FILES = $(FILES:%=$(PLOTS_DIR)/%.png)

# Report file
REPORT_FILE = $(REPORT_DIR)/count_report.html

# Report folder
REPORT_FOLDER = $(REPORT_DIR)/count_report_files

# Default target, run all tasks
all: $(DAT_FILES) $(PNG_FILES) $(REPORT_FILE)

# Generate word count files
$(RESULTS_DIR)/%.dat: $(DATA_DIR)/%.txt
	python $(SCRIPT_DIR)/wordcount.py --input_file=$< --output_file=$@

# Generate plot files
$(PLOTS_DIR)/%.png: $(RESULTS_DIR)/%.dat
	python $(SCRIPT_DIR)/plotcount.py --input_file=$< --output_file=$@

# Generate the report
$(REPORT_FILE): #$(PLOTS_DIR)/*.png
	quarto render $(REPORT_DIR)/count_report.qmd

# Clean up generated files
clean:
	rm -rf $(RESULTS_DIR)/*.dat $(PLOTS_DIR)/*.png $(REPORT_FILE) $(REPORT_FOLDER)

# Phony targets (not associated with files)
.PHONY: all clean
