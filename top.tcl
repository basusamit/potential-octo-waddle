project new test.xise
project set family Spartan6
project set device xc6slx45
project set package fgg484
project set speed -3
xfile add top.v 
project set top top_DifferentialBlinkerNotOK
process run "Generate Programming File" -force rerun_all
project close
    
