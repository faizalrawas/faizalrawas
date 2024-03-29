`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:17:51 12/29/2022 
// Design Name: 
// Module Name:    wam_m 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module wam_m(
    input  wire clk,        // clock (50MHz)
    input  wire clr,        // button - clear
    input  wire lft,        // button - left
    input  wire rgt,        // button - right
    input  wire pse,        // button - pause
    input  wire [7:0] sw,   // switch
    output wire [3:0] an,   // digital tube - analog
    output wire [6:0] a2g,  // digital tube - stroke
    output wire [7:0] ld    // LED
    );
	 
    reg  [31:0] clk_cnt;    // clock count
    wire clk_16;            // clock at 2^16 (800Hz)
    reg  clk_19;            // clock at 2^19 (100Hz)
    reg  pse_flg;           // pause flag

	 wire cout0;             // carry signal
    wire lstn;              // digital tube last signal
	 wire [3:0]  hrdn;       // hardness of 0~9
    wire [7:0]  holes;      // 8 holes idicating have moles or not
    wire [7:0]  tap;        // 8 switch hit input
    wire [7:0]  hit;        // 8 successful hit
    wire [11:0] score;      // score

    // handle clock
	 always @(posedge clk) begin
        // if(clr)          // DO NOT clear main clock as it is seed of randomizer
        //     clk_cnt = 0;
        // else begin
        clk_cnt = clk_cnt + 1;
        if(clk_cnt[31:28]>15)
            clk_cnt = 0;
    end
	 assign clk_16 = clk_cnt[16];

    // handle pause for clk_19
    always @ (posedge pse) begin
        pse_flg = ~pse_flg;
    end

    always @ (posedge clk) begin
        if (!pse_flg)
            clk_19 = clk_cnt[19];
    end
	  // generate moles
    wam_gen sub_gen( .clk_19(clk_19), .clr(clr), .clk_cnt(clk_cnt), .hit(hit), .hrdn(hrdn), .holes(holes) );
    wam_hrd sub_hrd( .clk_19(clk_19), .clr(clr), .lft(lft), .rgt(rgt), .cout0(cout0), .hrdn(hrdn) );

    // handle input tap
    wam_tap sub_tap( .clk_19(clk_19), .sw(sw), .tap(tap) );
    wam_hit sub_hit( .clk_19(clk_19), .tap(tap), .holes(holes), .hit(hit) );

 // handle score count
    wam_scr sub_scr( .clk(clk), .clr(clr), .hit(hit), .num(score), .cout0(cout0) );

    // handle display on digital tube
    wam_led sub_led( .holes(holes), .ld(ld) );
    wam_lst sub_lst( .clk_19(clk_19), .tap(tap), .lft(lft), .rgt(rgt), .cout0(cout0), .lstn(lstn) );
    wam_dis sub_dis( .clk_16(clk_16), .hrdn(hrdn), .score(score), .lstn(lstn), .an(an), .a2g(a2g) );

endmodule
