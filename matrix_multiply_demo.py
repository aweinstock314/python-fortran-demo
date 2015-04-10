#!/usr/bin/env python
import numpy as np
import ctypes
def main():
    lib = ctypes.cdll['./matrix_multiply.so']
    fortran_matrix_t = np.ctypeslib.ndpointer(dtype=np.double, ndim=2, flags='aligned, f_contiguous, writeable')
    matrix_multiply = lib['matrix_multiply']
    matrix_multiply.restype = None
    matrix_multiply.argtypes = [fortran_matrix_t, fortran_matrix_t, ctypes.c_int, ctypes.c_int, ctypes.c_int, fortran_matrix_t]

    m, n, p = 5, 5, 5
    np.random.seed(1)
    A = np.array(np.random.random((m, n)), order='F')
    B = np.array(np.random.random((n, p)), order='F')
    C = np.empty((m, p), order='F')
    matrix_multiply(A, B, m, n, p, C)
    print("A: %r" % (A,))
    print("B: %r" % (B,))
    print("C: %r" % (C,))
    print("C == A.dot(B) : %r" % (np.all(C == A.dot(B)),))

if __name__ == '__main__':
    main()
