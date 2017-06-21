
ROOT        := .

SHELL       := /bin/bash

ME          := cli-aptiX

BIN_DIR     := $(ROOT)/usr/local/bin
LOCALE_DIR  := $(ROOT)/usr/share/
MAN_DIR     := $(ROOT)/usr/share/man/man1
SHARE_DIR   := $(ROOT)/usr/local/share/$(ME)

ALL_DIRS   := $(BIN_DIR) $(LOCALE_DIR) $(MAN_DIR) $(SHARE_DIR)

.PHONY: $(SCRIPTS) help all script man-page shared-files

help:
	@#echo ""
	@#echo ""

all: script man-page shared-files

script: $(ME) | $(BIN_DIR)
	cp $(ME) $(BIN_DIR)/


man-page: man/$(ME).1 | $(MAN_DIR)
	test -e $< && gzip -c $< > $(MAN_DIR)/$$(basename $<).gz || true

shared-files: | $(SHARE_DIR)
	cp -r share/* $(SHARE_DIR)/

$(ALL_DIRS):
	test -d $(ROOT)/
	mkdir -p $@
