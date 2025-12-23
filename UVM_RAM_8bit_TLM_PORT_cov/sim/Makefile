
LIB = workA

RTL_DIR = ../
UVC_DIR = ../uvc
TB_DIR = ../tb

INCDIRS = +incdir+$(UVC_DIR)/seq +incdir+$(UVC_DIR)/env +incdir+$(UVC_DIR)/tests

TESTS = ram_test

all: compile regress coverage summary

compile: 
	vlib $(LIB)
	vmap work $(LIB)
	vlog -work work -sv -cover bcetf $(TB_DIR)/ram_if.sv  $(RTL_DIR)/ram.v
	vlog -work work -sv -cover bcetf $(INCDIRS) $(UVC_DIR)/env/ram_pkg.sv
	vlog -work work -sv -cover bcetf $(TB_DIR)/top.sv

regress:
	@echo "Starting regression..."
	@mkdir -p logs
	@mkdir -p cov
	@for t in $(TESTS); do \
	vsim -c -coverage top +UVM_TESTNAME=$$t -voptargs="+acc" -l logs/$$t.log  -do "coverage save -onexit cov/$$t.ucdb; run -all; quit"; \
	done

coverage:
	@echo "Generating coverage reports..."
	vcover report -html cov/ram_test.ucdb -htmldir cov/html
	vcover report -details -file cov/coverage.txt cov/ram_test.ucdb

summary:
	@echo "Regression Summary:"
	@echo "PASS"
	@grep -l "TEST PASSED" logs/*.log | sed 's#.*/##'
	@echo ""
	@echo "FAIL"
	@grep -L "TEST PASSED" logs/*.log | sed 's#.*/##'
	@echo ""

clean:
	rm -rf $(LIB) transcript logs *.log cov modelsim.ini

.PHONY: all compile regress coverage summary clean

