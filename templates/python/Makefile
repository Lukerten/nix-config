VENV_DIR := venv
REQUIREMENTS_FILE := requirements.txt
PYTHON := python3

# make setup 
.ONESHELL:
.RECIPEPREFIX := >
MAKEFLAGS += --silent
MAKEFLAGS += --no-print-directory
.DEFAULT_GOAL := setup
.PHONY: help run setup clean test

# Autodetect the running Shell (bash, zsh or fish)
# If the shell is not supported, the default shell is bash
VENV_ACTIVATE := $(VENV_DIR)/bin/activate
ifeq ($(shell uname -s), Darwin)
    VENV_ACTIVATE := $(VENV_DIR)/bin/activate
else ifeq ($(shell uname -s), Linux)
    VENV_ACTIVATE := $(VENV_DIR)/bin/activate
else ifeq ($(shell uname -s), MINGW32_NT-10.0)
    VENV_ACTIVATE := $(VENV_DIR)/Scripts/activate
endif

DEPS := $(VENV_DIR)/.installed

$(DEPS): requirements.txt
> $(PYTHON) -m venv $(VENV_DIR)
> . $(VENV_ACTIVATE) && pip install -r $(REQUIREMENTS_FILE)
> touch $(DEPS)

#HELP: setup for venv and install dependencies
setup: $(DEPS)
> 

#HELP: runs the application
run: $(DEPS)
> . $(VENV_ACTIVATE) && $(PYTHON) src/app.py 

#HELP: runs the tests
test: $(DEPS)
> . $(VENV_ACTIVATE) && pytest

#HELP: clean the environment
clean:
> rm -rf $(VENV_DIR) __pycache__ .pytest_cache

#HELP: prints this screen
help:
> @printf "Available targets\n\n"
> @awk '/^[a-zA-Z\-_0-9]+:/ {
>   helpMessage = match(lastLine, /^#HELP: (.*)/);
>   if (helpMessage) {
>     helpCommand = substr($$1, 0, index($$1, ":")-1);
>     helpMessage = substr(lastLine, RSTART + 6, RLENGTH);
>     gsub(/\\n/, "\n", helpMessage);
>     printf "\033[36m%-30s\033[0m %s\n", helpCommand, helpMessage;
>   }
> }
> { lastLine = $$0 }' $(MAKEFILE_LIST)
