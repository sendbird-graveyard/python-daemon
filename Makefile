#! /usr/bin/make -f
#
# Makefile
# Part of ‘python-daemon’, an implementation of PEP 3143.
#
# This is free software, and you are welcome to redistribute it under
# certain conditions; see the end of this file for copyright
# information, grant of license, and disclaimer of warranty.

# Makefile for ‘python-daemon’ library.

SHELL = /bin/bash
PATH = /usr/bin:/bin

# Directories with semantic meaning.
BUILD_DIR = $(CURDIR)/build
DIST_DIR = $(CURDIR)/dist

GENERATED_FILES += ${BUILD_DIR}/
GENERATED_FILES += ${DIST_DIR}/

PYTHON ?= /usr/bin/python3

PYTHON_SETUP ?= $(PYTHON) -m setup


.PHONY: all
all: build


.PHONY: build
build: sdist bdist_wheel

.PHONY: sdist bdist_wheel
sdist bdist_wheel:
	$(PYTHON_SETUP) "$@"

GENERATED_FILES += $(CURDIR)/__pycache__/
GENERATED_FILES += $(CURDIR)/*.egg-info
GENERATED_FILES += $(CURDIR)/.eggs/


.PHONY: test
test:
	$(PYTHON_SETUP) "$@"


include twine.mk

.PHONY: publish
publish: twine-check twine-upload

test: twine-check


.PHONY: clean
clean:
	$(PYTHON_SETUP) "$@"
	$(RM) -r ${GENERATED_FILES}


# Copyright © 2006–2019 Ben Finney <ben+python@benfinney.id.au>
#
# This is free software: you may copy, modify, and/or distribute this work
# under the terms of the GNU General Public License as published by the
# Free Software Foundation; version 3 of that license or any later version.
# No warranty expressed or implied. See the file ‘LICENSE.GPL-3’ for details.


# Local Variables:
# coding: utf-8
# mode: makefile
# End:
# vim: fileencoding=utf-8 filetype=make :
