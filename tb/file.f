// 64 bit option for AWS labs
-64

-uvmhome /home/cc/mnt/XCELIUM2309/tools/methodology/UVM/CDNS-1.1d

// include directories
//*** add incdir include directories here
-incdir ../master // include directory for sv files
-incdir ../tb // include directory for sv files
../master/master_pkg.sv
../master/master_interface.sv
// ../tb/master_test.sv
../tb/master_top.sv

+UVM_TESTNAME=master_test
+UVM_VERBOSITY=UVM_HIGH