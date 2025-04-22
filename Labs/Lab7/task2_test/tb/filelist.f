// Include directories
// Add the source directory for SystemVerilog files
-incdir ../sv

// Compile files
// Compile the YAPP package (includes yapp_packet.sv)
../sv/yapp_packet.sv 
../sv/yapp_pkg.sv 
// Compile the top-level test module
top.sv            

