/*
 * Copyright (c) 2004-2007 The Trustees of Indiana University and Indiana
 *                         University Research and Technology
 *                         Corporation.  All rights reserved.
 * Copyright (c) 2004-2005 The University of Tennessee and The University
 *                         of Tennessee Research Foundation.  All rights
 *                         reserved.
 * Copyright (c) 2004-2005 High Performance Computing Center Stuttgart,
 *                         University of Stuttgart.  All rights reserved.
 * Copyright (c) 2004-2005 The Regents of the University of California.
 *                         All rights reserved.
 * Copyright (c) 2007-2013 Los Alamos National Security, LLC.  All rights
 *                         reserved.
 * $COPYRIGHT$
 *
 * Additional copyrights may follow
 *
 * $HEADER$
 */

/**
 * @file
 *
 * Generic helper routines for environment manipulation.
 */

#ifndef OPAL_ENVIRON_H
#define OPAL_ENVIRON_H

#include "opal_config.h"

#ifdef HAVE_CRT_EXTERNS_H
#    include <crt_externs.h>
#endif

BEGIN_C_DECLS

/**
 * Merge two environ-like arrays into a single, new array, ensuring
 * that there are no duplicate entries.
 *
 * @param minor Set 1 of the environ's to merge
 * @param major Set 2 of the environ's to merge
 * @retval New array of environ
 *
 * Merge two environ-like arrays into a single, new array,
 * ensuring that there are no duplicate entries.  If there are
 * duplicates, entries in the \em major array are favored over
 * those in the \em minor array.
 *
 * Both \em major and \em minor are expected to be argv-style
 * arrays (i.e., terminated with a NULL pointer).
 *
 * The array that is returned is an unencumbered array that should
 * later be freed with a call to opal_argv_free().
 *
 * Either (or both) of \em major and \em minor can be NULL.  If
 * one of the two is NULL, the other list is simply copied to the
 * output.  If both are NULL, NULL is returned.
 */
OPAL_DECLSPEC char **opal_environ_merge(char **minor,
                                        char **major) __opal_attribute_warn_unused_result__;

/**
 * Portable version of setenv(3), allowing editing of any
 * environ-like array.
 *
 * @param name String name of the environment variable to look for
 * @param value String value to set (may be NULL)
 * @param overwrite Whether to overwrite any existing value with
 * the same name
 * @param env The environment to use
 *
 * @retval OPAL_ERR_OUT_OF_RESOURCE If internal malloc() fails.
 * @retval OPAL_EXISTS If the name already exists in \em env and
 * \em overwrite is false (and therefore the \em value was not
 * saved in \em env)
 * @retval OPAL_SUCESS If the value replaced another value or is
 * appended to \em env.
 *
 * \em env is expected to be a NULL-terminated array of pointers
 * (argv-style).  Note that unlike some implementations of
 * putenv(3), if \em value is inserted in \em env, it is copied.
 * So the caller can modify/free both \em name and \em value after
 * opal_setenv() returns.
 *
 * The \em env array will be grown if necessary.
 *
 * It is permissible to invoke this function with the
 * system-defined \em environ variable.  For example:
 *
 * \code
 *   #include "opal/util/opal_environ.h"
 *   opal_setenv("foo", "bar", true, &environ);
 * \endcode
 *
 * NOTE: If you use the real environ, opal_setenv() will turn
 * around and perform putenv() to put the value in the
 * environment.  This may very well lead to a memory leak, so its
 * use is strongly discouraged.
 *
 * It is also permissible to call this function with an empty \em
 * env, as long as it is pre-initialized with NULL:
 *
 * \code
 *   char **my_env = NULL;
 *   opal_setenv("foo", "bar", true, &my_env);
 * \endcode
 */
OPAL_DECLSPEC int opal_setenv(const char *name, const char *value, bool overwrite, char ***env)
    __opal_attribute_nonnull__(1);

/**
 * Portable version of unsetenv(3), allowing editing of any
 * environ-like array.
 *
 * @param name String name of the environment variable to look for
 * @param env The environment to use
 *
 * @retval OPAL_ERR_OUT_OF_RESOURCE If an internal malloc fails.
 * @retval OPAL_ERR_NOT_FOUND If \em name is not found in \em env.
 * @retval OPAL_SUCCESS If \em name is found and successfully deleted.
 *
 * If \em name is found in \em env, the string corresponding to
 * that entry is freed and its entry is eliminated from the array.
 */
OPAL_DECLSPEC int opal_unsetenv(const char *name, char ***env) __opal_attribute_nonnull__(1);

/* A consistent way to retrieve the home and tmp directory on all supported
 * platforms.
 */
OPAL_DECLSPEC const char *opal_home_directory(void);
OPAL_DECLSPEC const char *opal_tmp_directory(void);

/* Some care is needed with environ on OS X when dealing with shared
   libraries.  Handle that care here... */
#ifdef HAVE__NSGETENVIRON
#    define environ (*_NSGetEnviron())
#else
OPAL_DECLSPEC extern char **environ;
#endif

END_C_DECLS

#endif /* OPAL_ENVIRON */
