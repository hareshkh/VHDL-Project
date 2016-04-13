onerror {exit -code 1}
vlib work
vlog -work work AC_REMOTE.vo
vlog -work work AC_REMOTE.vwf.vt
vsim -novopt -c -t 1ps -L arriaii_ver -L altera_ver -L altera_mf_ver -L 220model_ver -L sgate_ver -L altera_lnsim_ver work.AC_REMOTE_vlg_vec_tst -voptargs="+acc"
vcd file -direction AC_REMOTE.msim.vcd
vcd add -internal AC_REMOTE_vlg_vec_tst/*
vcd add -internal AC_REMOTE_vlg_vec_tst/i1/*
run -all
quit -f
