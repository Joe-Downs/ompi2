# -*- makefile -*-
#
# Copyright (c) 2004-2005 The Trustees of Indiana University and Indiana
#                         University Research and Technology
#                         Corporation.  All rights reserved.
# Copyright (c) 2004-2005 The University of Tennessee and The University
#                         of Tennessee Research Foundation.  All rights
#                         reserved.
# Copyright (c) 2004-2005 High Performance Computing Center Stuttgart,
#                         University of Stuttgart.  All rights reserved.
# Copyright (c) 2004-2005 The Regents of the University of California.
#                         All rights reserved.
# Copyright (c) 2016      Cisco Systems, Inc.  All rights reserved.
# Copyright (c) 2021      IBM Corporation.  All rights reserved.
# $COPYRIGHT$
#
# Additional copyrights may follow
#
# $HEADER$
#

AM_CPPFLAGS = -I$(top_srcdir)/test/support

AM_LDFLAGS = -lpthread

check_PROGRAMS = \
	opal_thread \
	opal_condition \
	opal_atomic_thread_bench

TESTS = $(check_PROGRAMS)

opal_thread_SOURCES = opal_thread.c
opal_thread_LDADD = \
        $(top_builddir)/test/support/libsupport.a \
        $(top_builddir)/opal/lib@OPAL_LIB_NAME@.la
opal_thread_DEPENDENCIES = $(opal_thread_LDADD)

opal_condition_SOURCES = opal_condition.c
opal_condition_LDADD = \
        $(top_builddir)/test/support/libsupport.a \
        $(top_builddir)/opal/lib@OPAL_LIB_NAME@.la
opal_condition_DEPENDENCIES = $(opal_condition_LDADD)

opal_atomic_thread_bench_SOURCES = opal_atomic_thread_bench.c
opal_atomic_thread_bench_LDADD = \
        $(top_builddir)/test/support/libsupport.a \
        $(top_builddir)/opal/lib@OPAL_LIB_NAME@.la
opal_atomic_thread_bench_DEPENDENCIES = $(opal_atomic_thread_bench_LDADD)

distclean-local:
	rm -rf *.dSYM .deps .libs *.log *.o *.trs $(check_PROGRAMS) Makefile
