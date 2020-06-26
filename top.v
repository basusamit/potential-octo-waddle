
// Module declaration
module top_DifferentialBlinkerNotOK
    // Module arguments
    (check_signal_positive_write, check_signal_negative_write, data_signal_positive_write, data_signal_negative_write, led, clock);
    
    // Argument details
    output  check_signal_positive_write;
    output  check_signal_negative_write;
    output  data_signal_positive_write;
    output  data_signal_negative_write;
    output reg  [7:0] led;
    input clock;
    
    // Wire declarations
    wire check_signal_positive_internal;
    wire check_signal_negative_internal;
    wire data_signal_positive_internal;
    wire data_signal_negative_internal;
    wire data_signal;
    
    // Sub-module instantiations
    top_check_driver_DifferentialOutputDriver check_driver(.input_signal(data_signal), .output_positive(check_signal_positive_internal), .output_negative(check_signal_negative_internal));
    top_driver_DifferentialOutputDriver driver(.input_signal(data_signal), .output_positive(data_signal_positive_internal), .output_negative(data_signal_negative_internal));
    top_toggler_Toggler toggler(.clock(clock), .output_signal(data_signal));
    // Signal links
    assign check_signal_positive_write = check_signal_positive_internal;
    assign check_signal_negative_write = check_signal_negative_internal;
    assign data_signal_positive_write = data_signal_positive_internal;
    assign data_signal_negative_write = data_signal_negative_internal;
    
    always @(*) begin
        led = 8'h0;
        if (data_signal) begin
            led = 8'haa;
        end
        else begin
            led = 8'h55;
        end
    end

endmodule

module top_check_driver_DifferentialOutputDriver
    // Module arguments
    (input_signal, output_positive, output_negative);

    // Argument details
    input input_signal;
    output output_positive;
    output output_negative;

    OBUFDS obufds_inst(.O(output_positive), .OB(output_negative), .I(input_signal));

endmodule
        
module top_driver_DifferentialOutputDriver
    // Module arguments
    (input_signal, output_positive, output_negative);

    // Argument details
    input input_signal;
    output output_positive;
    output output_negative;

    OBUFDS obufds_inst(.O(output_positive), .OB(output_negative), .I(input_signal));

endmodule
        
// Module declaration
module top_toggler_Toggler
    // Module arguments
    (clock, output_signal);
    
    // Argument details
    input clock;
    output reg  output_signal;
    
    // Wire declarations
    wire strobe_signal;
    
    // DFF declarations
    reg state_val;
    reg state_next;
    
    // Initial values
    initial begin
        state_val = 0;
    end
    
    // DFF synchronous updates
    always @(posedge clock) state_val <= state_next;
    
    // Sub-module instantiations
    top_toggler_strobe_Strobe strobe(.clock(clock), .strobe(strobe_signal));
    
    always @(*) begin
        //  --- Beginning of latch prevention
        state_next = state_val;
        //  --- End of latch prevention
        if (strobe_signal) begin
            state_next = ~state_val;
        end
        output_signal = state_val;
    end

endmodule

// Module declaration
module top_toggler_strobe_Strobe
    // Module arguments
    (clock, strobe);
    
    // Argument details
    input clock;
    output reg  strobe;
    
    // DFF declarations
    reg [31:0] counter_val;
    reg [31:0] counter_next;
    
    // Constant definitions
    localparam incr = 171;
    
    // Initial values
    initial begin
        counter_val = 171;
    end
    
    // DFF synchronous updates
    always @(posedge clock) counter_val <= counter_next;
    
    
    always @(*) begin
        //  --- Beginning of latch prevention
        counter_next = counter_val;
        //  --- End of latch prevention
        counter_next = (counter_val) + (incr);
        strobe = (counter_val) < (incr);
    end

endmodule
