! -*- f90 -*-
!
! Copyright (c) 2010-2014 Cisco Systems, Inc.  All rights reserved.
! Copyright (c) 2009-2012 Los Alamos National Security, LLC.
!                         All rights reserved.
! Copyright (c) 2018-2020 Research Organization for Information Science
!                         and Technology (RIST).  All rights reserved.
! Copyright (c) 2020-2022 Triad National Security, LLC. All rights
!                         reserved.
! $COPYRIGHT$

#include "ompi/mpi/fortran/configure-fortran-output.h"

#include "mpi-f08-rename.h"

subroutine MPI_Session_create_errhandler_f08(session_errhandler_fn,errhandler,ierror)
   use, intrinsic :: iso_c_binding, only: c_funptr, c_funloc
   use :: mpi_f08_types, only : MPI_Errhandler
   use :: mpi_f08_interfaces_callbacks, only : MPI_Session_errhandler_function
   use :: ompi_mpifh_bindings, only : ompi_session_create_errhandler_f
   implicit none
   PROCEDURE(MPI_Session_errhandler_function) :: session_errhandler_fn
   TYPE(MPI_Errhandler), INTENT(OUT) :: errhandler
   INTEGER, OPTIONAL, INTENT(OUT) :: ierror
   integer :: c_ierror
   type(c_funptr) :: fn

   fn = c_funloc(session_errhandler_fn)
   call ompi_session_create_errhandler_f(fn,errhandler%MPI_VAL,c_ierror)
   if (present(ierror)) ierror = c_ierror

end subroutine MPI_Session_create_errhandler_f08
