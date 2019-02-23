# setuptools.mk
# Part of ‘python-daemon’, an implementation of PEP 3143.
#
# This is free software, and you are welcome to redistribute it under
# certain conditions; see the end of this file for copyright
# information, grant of license, and disclaimer of warranty.

# Makefile rules for Python Setuptools.

MODULE_DIR := $(CURDIR)

DESTDIR ?=
PREFIX ?= /usr

PYTHON2 ?= python2
PYTHON3 ?= python3
PYTHON ?= ${PYTHON3}

SETUP_MODULE = setup
PYTHON_SETUP := $(PYTHON) -m ${SETUP_MODULE}
PYTHON_SETUP_MODULE_FILE := $(CURDIR)/${SETUP_MODULE}.py

CODE_MODULES += ${PYTHON_SETUP_MODULE_FILE}

PYTHON_SETUP_INSTALL_OPTS ?= --root=${DESTDIR} --prefix=${PREFIX}

PYTHON_BDIST_TARGETS := bdist_wheel

GENERATED_FILES += $(CURDIR)/*.egg-info
GENERATED_FILES += $(CURDIR)/.eggs/
GENERATED_FILES += $(CURDIR)/build/
GENERATED_FILES += $(CURDIR)/dist/

GENERATED_FILES += $(shell find $(CURDIR) -type f -name '*.pyc')
GENERATED_FILES += $(shell find $(CURDIR) -type d -name '__pycache__')

VCS_INVENTORY ?= git ls-files


.PHONY: setuptools-test
setuptools-test:
	$(PYTHON_SETUP) test


.PHONY: setuptools-build
setuptools-build:
	$(PYTHON_SETUP) build

.PHONY: setuptools-install
setuptools-install:
	$(PYTHON_SETUP) install --root=${DESTDIR} --prefix=${PREFIX}


.PHONY: setuptools-dist
setuptools-dist: setuptools-sdist setuptools-bdist

.PHONY: setuptools-bdist
setuptools-bdist:
	$(PYTHON_SETUP) ${PYTHON_BDIST_TARGETS}

.PHONY: setuptools-sdist
setuptools-sdist:
	$(PYTHON_SETUP) sdist


.PHONY: setuptools-clean
setuptools-clean:
	$(PYTHON_SETUP) clean


# Copyright © 2006–2019 Ben Finney <ben+python@benfinney.id.au>
#
# This is free software: you may copy, modify, and/or distribute this work
# under the terms of the GNU General Public License as published by the
# Free Software Foundation; version 3 of that license or any later version.
# No warranty expressed or implied. See the file ‘LICENSE.GPL-3’ for details.


# Local Variables:
# mode: makefile
# coding: utf-8
# End:
# vim: fileencoding=utf-8 filetype=make :
