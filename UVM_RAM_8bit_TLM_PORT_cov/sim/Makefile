
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
	vlog -work work -sv $(INCDIRS) $(UVC_DIR)/env/ram_pkg.sv
	vlog -work work -sv $(TB_DIR)/top.sv

regress:
	@echo "Starting regression..."
	@mkdir -p logs
	@mkdir -p cov
	@for t in $(TESTS); do \
	vsim -c -coverage top +UVM_TESTNAME=$$t \
	-voptargs="+acc" -assertdebug \
	-l logs/$$t.log -do "coverage save -onexit cov/$$t.ucdb; run -all; quit";  \
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

wave:
	@echo "Launching GUI with all signals..."
	vsim -gui top \
	     +UVM_TESTNAME=$(TEST) \
	     -voptargs="+acc" \
	     -do "add wave -r /*; run -all"

clean:
	@echo "Cleaning up..."
	rm -rf $(LIB) transcript logs cov *.log modelsim.ini 

.PHONY: all compile regress coverage summary clean wave

