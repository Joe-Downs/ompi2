! -*- f90 -*-
!
! Copyright (c) 2009-2013 Cisco Systems, Inc.  All rights reserved.
! Copyright (c) 2009-2012 Los Alamos National Security, LLC.
!                         All rights reserved.
! Copyright (c) 2019-2020 Research Organization for Information Science
!                         and Technology (RIST).  All rights reserved.
! $COPYRIGHT$
!

#include "mpi-f08-rename.h"

subroutine MPI_Iprobe_f08(source,tag,comm,flag,status,ierror)
   use :: mpi_f08_types, only : MPI_Comm, MPI_Status
   implicit none
   INTEGER, INTENT(IN) :: source, tag
   TYPE(MPI_Comm), INTENT(IN) :: comm
   LOGICAL, INTENT(OUT) :: flag
   TYPE(MPI_Status) :: status
   INTEGER, OPTIONAL, INTENT(OUT) :: ierror
   integer :: c_ierror

   ! See note in mpi-f-interfaces-bind.h for why we include an
   ! interface here and call a PMPI_* subroutine below.
   interface
      subroutine PMPI_Iprobe(source, tag, comm, flag, status, ierror)
        use :: mpi_f08_types, only : MPI_Status
        integer, intent(in) :: source
        integer, intent(in) :: tag
        integer, intent(in) :: comm
        logical, intent(out) :: flag
        TYPE(MPI_Status) :: status
        integer, intent(out) :: ierror
      end subroutine PMPI_Iprobe
   end interface

   call PMPI_Iprobe(source,tag,comm%MPI_VAL,flag,status,c_ierror)
   if (present(ierror)) ierror = c_ierror

end subroutine MPI_Iprobe_f08
