! -*- f90 -*-
!
! Copyright (c) 2009-2022 Cisco Systems, Inc.  All rights reserved
! Copyright (c) 2009-2012 Los Alamos National Security, LLC.
!                         All rights reserved.
! Copyright (c) 2018-2021 Research Organization for Information Science
!                         and Technology (RIST).  All rights reserved.
! Copyright (c) 2018      FUJITSU LIMITED.  All rights reserved.
! $COPYRIGHT$

#include "ompi/mpi/fortran/configure-fortran-output.h"

#include "mpi-f08-rename.h"

subroutine MPI_Gather_init_f08(sendbuf,sendcount,sendtype,recvbuf,recvcount,&
                                recvtype,root,comm,info,request,ierror)
   use :: mpi_f08_types, only : MPI_Datatype, MPI_Comm, MPI_Info, MPI_Request
   use :: ompi_mpifh_bindings, only : ompi_gather_init_f
   implicit none
   OMPI_FORTRAN_IGNORE_TKR_TYPE, INTENT(IN) OMPI_ASYNCHRONOUS :: sendbuf
   OMPI_FORTRAN_IGNORE_TKR_TYPE OMPI_ASYNCHRONOUS :: recvbuf
   INTEGER, INTENT(IN) :: sendcount, recvcount, root
   TYPE(MPI_Datatype), INTENT(IN) :: sendtype
   TYPE(MPI_Datatype), INTENT(IN) :: recvtype
   TYPE(MPI_Comm), INTENT(IN) :: comm
   TYPE(MPI_Info), INTENT(IN) :: info
   TYPE(MPI_Request), INTENT(OUT) :: request
   INTEGER, OPTIONAL, INTENT(OUT) :: ierror
   integer :: c_ierror

   call ompi_gather_init_f(sendbuf,sendcount,sendtype%MPI_VAL,recvbuf,recvcount,&
                            recvtype%MPI_VAL,root,comm%MPI_VAL,info%MPI_VAL,request%MPI_VAL,c_ierror)
   if (present(ierror)) ierror = c_ierror

end subroutine MPI_Gather_init_f08
