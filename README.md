# potential-octo-waddle

This is a simple Verilog project to generate a test case that is
investigating a potential issue with the XEM6010.  In particular,
it sets up two differential drivers, and hooks one pair to LP33
and the other pair to LP64.  Both are being driven by a 2 Hz square
wave which is also fed to the LEDs to provide visual feedback.

Based on the testing with a BRK6110 board, a clear differential
signal seems apparent on the LP33 output, but the LP64N output
does not appear to behave correctly.

This code was generated from Rust via the RustHDL project, but is
simple and self contained.  To build it:

```
xtclsh ./top.tcl
```

This will create a `top_DifferentialBlinkerNotOK.bit` file that can be loaded
with the FrontPanel software.



