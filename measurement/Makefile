.DEFAULT_GOAL := help

.PHONY: help dev release check-dir

DIR ?=
PPI ?= 36

help:
	@printf '%s\n' \
	  "Usage: make <dev|release> DIR='<image-directory>'" \
	  "  dev      Watch and compile with all current helper features enabled" \
	  "  release  Compile a clean image without helper features" \
	  "Example: make dev DIR='某图片'"

check-dir:
	@test -n "$(strip $(DIR))" || { \
	  echo "Error: DIR is required (e.g. make dev DIR='某图片')." >&2; \
	  exit 2; \
	}
	@test -f "$(DIR)/main.typ" || { \
	  echo "Error: '$(DIR)/main.typ' does not exist." >&2; \
	  exit 2; \
	}

dev: check-dir
	typst watch --root . --format png --ppi "$(PPI)" \
	  --input RULER=1 --input HELPING_LINE=1 \
	  "$(DIR)/main.typ" "$(DIR)/main.png"

release: check-dir
	typst compile --root . --format png --ppi "$(PPI)" \
	  "$(DIR)/main.typ" "$(DIR)/main.png"
