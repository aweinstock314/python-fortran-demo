! store AB into (already-allocated) C, where A is m-by-n and B is n-by-p
subroutine matrix_multiply(pA, pB, m, n, p, pC) bind (C, name="matrix_multiply")
use iso_c_binding
implicit none

integer(kind=c_int), intent(in), value :: m, n, p
type(c_ptr), value :: pA, pB, pC
double precision, pointer :: A(:,:), B(:,:), C(:,:)

call c_f_pointer(pA, A, shape=[m, n])
call c_f_pointer(pB, B, shape=[n, p])
call c_f_pointer(pC, C, shape=[m, p])

! delegate to fortran's builtin matrix-multiply routine
! according to `objdump -d matrix_multiply.so`, this gets fully inlined
C = MATMUL(A, B)

end subroutine matrix_multiply
