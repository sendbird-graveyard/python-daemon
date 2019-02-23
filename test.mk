# test.mk
# Part of ‘python-daemon’, an implementation of PEP 3143.
#
# This is free software, and you are welcome to redistribute it under
# certain conditions; see the end of this file for copyright
# information, grant of license, and disclaimer of warranty.

# Makefile rules for test suite.

MODULE_DIR := $(CURDIR)

export COVERAGE_DIR = ${MODULE_DIR}/.coverage
coverage_html_report_dir = ${MODULE_DIR}/htmlcov

TEST_MODULES += $(shell find ${MODULE_DIR}/ -name 'test_*.py')

TEST_UNITTEST_OPTS ?=
TEST_UNITTEST_NAMES ?= discover

TEST_COVERAGE_RUN_OPTS ?= --branch
TEST_COVERAGE_REPORT_OPTS ?=
TEST_COVERAGE_HTML_OPTS ?= --directory ${coverage_html_report_dir}/

TEST_PYCODESTYLE_OPTS ?=

TEST_PYMCCABE_MIN ?= 3
TEST_PYMCCABE_OPTS ?= --min ${TEST_PYMCCABE_MIN}


.PHONY: test
test: test-unittest

.PHONY: test-unittest
test-unittest:
	$(PYTHON) -m unittest ${TEST_UNITTEST_OPTS} ${TEST_UNITTEST_NAMES}


.PHONY: test-coverage
test-coverage: test-coverage-run test-coverage-html test-coverage-report

.PHONY: test-coverage-run
test-coverage-run: .coverage

.coverage: ${CODE_MODULES}
	$(PYTHON) -m coverage run ${TEST_COVERAGE_RUN_OPTS} \
		$(CURDIR)/setup.py test

GENERATED_FILES += ${COVERAGE_DIR}

.PHONY: test-coverage-html
test-coverage-html: .coverage
	$(PYTHON) -m coverage html ${TEST_COVERAGE_HTML_OPTS} \
		$(filter-out ${TEST_MODULES},${CODE_MODULES})

GENERATED_FILES += ${coverage_html_report_dir}

.PHONY: test-coverage-report
test-coverage-report: .coverage
	$(PYTHON) -m coverage report ${TEST_COVERAGE_REPORT_OPTS} \
		$(filter-out ${TEST_MODULES},${CODE_MODULES})


.PHONY: test-style
test-style: test-pycodestyle test-pymccabe

.PHONY: test-pycodestyle
test-pycodestyle:
	$(PYTHON3) -m pycodestyle ${TEST_PYCODESTYLE_OPTS} \
		${CODE_MODULES}

.PHONY: test-pymccabe
test-pymccabe:
	$(PYTHON3) -m mccabe ${TEST_PYMCCABE_OPTS} ${CODE_MODULES}


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
