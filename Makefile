
ROOT        := .

SHELL       := /bin/bash

ME          := cli-aptiX

BIN_DIR     := $(ROOT)/usr/local/bin
LOCALE_DIR  := $(ROOT)/usr/share/locale
MAN_DIR     := $(ROOT)/usr/share/man/man1
SHARE_DIR   := $(ROOT)/usr/local/share/$(ME)
DESKTOP_DIR := $(ROOT)/usr/share/applications/antix

ALL_DIRS   := $(BIN_DIR) $(LOCALE_DIR) $(MAN_DIR) $(SHARE_DIR) $(DESKTOP_DIR)

.PHONY: $(SCRIPTS) help all script man-page shared-files desktop-file locales

help:
	@#echo ""
	@#echo ""

all: script man-page shared-files desktop-file locales

locales: | $(LOCALE_DIR)
	cp -r locale/* $(LOCALE_DIR)

script: $(ME) | $(BIN_DIR)
	cp $(ME) $(BIN_DIR)/

man-page: man/$(ME).1 | $(MAN_DIR)
	test -e $< && gzip -c $< > $(MAN_DIR)/$$(basename $<).gz || true

shared-files: | $(SHARE_DIR)
	cp -r share/* $(SHARE_DIR)/

desktop-file: | $(DESKTOP_DIR)
	cp desktop/*.desktop $(DESKTOP_DIR)

$(ALL_DIRS):
	test -d $(ROOT)/
	mkdir -p $@
