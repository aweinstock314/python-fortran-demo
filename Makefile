.PHONY: all clean run_python_demo

OUTPUT_FILES=matrix_multiply.so matrix_multiply_demo

all: ${OUTPUT_FILES}

matrix_multiply.so: matrix_multiply.f95
	gfortran $< -O3 -fPIC -shared -o $@

matrix_multiply_demo: matrix_multiply_demo.c matrix_multiply.so
	gcc $< ./matrix_multiply.so -O3 -o $@

run_python_demo: matrix_multiply.so
	python matrix_multiply_demo.py

clean:
	rm ${OUTPUT_FILES}
