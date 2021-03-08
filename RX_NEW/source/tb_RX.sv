`timescale 1ns / 10ps
module tb_RX
();

	//Define local params
	localparam CLOCK = 9.6;
   int tb_test_num = 0;
   
	//Declare signals
   reg tb_clk, tb_n_rst, tb_d_plus, tb_d_minus, tb_pid_rdy;
   reg 	    tb_r_enable=1'b0;
   reg [7:0] tb_RX_Packet_Data;
   reg 	     tb_empty, tb_rcving, tb_r_error; 
   reg [1:0] tb_packet_done;
   reg [3:0] tb_pid;      
   reg 	     tb_Store_RX_Packet_Data;
   reg [2:0] tb_RX_Packet;
   
	//Clock
   always
     begin
	tb_clk = 0;
	#(CLOCK/2.0);
	tb_clk = 1;
	#(CLOCK/2.0);
     end

   //DUT Port mapping
   RX DUT(
	  .clk(tb_clk),                   //input
          .n_rst(tb_n_rst),               //input
          .Dplus(tb_d_plus),             //input
          .Dminus(tb_d_minus),           //input
          .packet_done(tb_packet_done),   //output //I need to include in FSM
          .pid_rdy(tb_pid_rdy),           //output //same
           .pid(tb_pid),                   //output
          .receiving(tb_rcving),             //output
          .send_en(tb_write_enable), //output
          .r_error(tb_r_error),            //output
	  .RX_Packet(tb_RX_Packet),
	  .Store_RX_Packet_Data(tb_Store_RX_Packet_Data),
	  .RX_Packet_Data(tb_RX_Packet_Data)
          );
   

   
   //Test Bench
   initial 
     begin
	n_rst;
        #(CLOCK*8)
	n_rst;//
	#(CLOCK*8)//
        IN_token;//1
        #(CLOCK*8)
	n_rst;
        #(CLOCK*8)
        ACK;//2
        #(CLOCK*8)
        n_rst;
        #(CLOCK*8)
	NAK;//3
        #(CLOCK*8)
	n_rst;
        #(CLOCK*8)
	n_rst;
	#(CLOCK*8)
        stall_handshake;//4
        #(CLOCK*8)
	n_rst;
        #(CLOCK*8)
        in_token;//5
        #(CLOCK*8)
	n_rst;
        #(CLOCK*8)
        out_token;//6
        #(CLOCK*8)
	n_rst;
        #(CLOCK*8)
        data_packet;//7
        #(CLOCK*8)
	n_rst;
        #(CLOCK*8)
        data_packet2;//8
        #(CLOCK*8)
	
        n_rst;
        #(CLOCK*8)
        OUTtoken_bad_pid;//9
        #(CLOCK*8)
       	n_rst;
        #(CLOCK*8)
        OUTtoken_bad_crc;//10
        #(CLOCK*8)
	n_rst;
        #(CLOCK*8)
        IN_token;//11
        #(CLOCK*8)
	n_rst;
        #(CLOCK*8)
        ACK_bad_pid;//12
        #(CLOCK*8)
	n_rst;
        #(CLOCK*8)
        ACK;//13
        #(CLOCK*8)
        
	$stop;
     end
   
   task n_rst();
      begin
         //Toggle the n_rst
         tb_d_plus = 1;
         tb_d_minus = 0;            
         tb_n_rst = 1;
         #(CLOCK)
         tb_n_rst = 0;
         #(CLOCK)
         tb_n_rst = 1;
      end
   endtask

    task IN_token();
       begin
	  tb_test_num++;
	  
            //Sync Byte
            tb_d_plus = 0;//
            tb_d_minus =1 ;//
            #(CLOCK*8)
            tb_d_plus = 1;
            tb_d_minus = 0;
            #(CLOCK*8)
            tb_d_plus = 0;
            tb_d_minus = 1;
            #(CLOCK*8)
            tb_d_plus = 1;
            tb_d_minus = 0;
            #(CLOCK*8)
            tb_d_plus = 0;
            tb_d_minus = 1;
            #(CLOCK*8)
            tb_d_plus = 1;
            tb_d_minus = 0;
            #(CLOCK*8)
            tb_d_plus = 0;//
            tb_d_minus = 1;//
            #(CLOCK*8)
            tb_d_plus = 0;
            tb_d_minus = 1;
            #(CLOCK*8)

            //PID  IN 10010110
            tb_d_plus = 0;
            tb_d_minus = 1;
            #(CLOCK*8)
            tb_d_plus = 1;
            tb_d_minus = 0;
            #(CLOCK*8)
            tb_d_plus = 0;
            tb_d_minus = 1;
            #(CLOCK*8)
            tb_d_plus = 0;
            tb_d_minus = 1;
            #(CLOCK*8)
            tb_d_plus = 1;
            tb_d_minus = 0;
            #(CLOCK*8)
            tb_d_plus = 1;
            tb_d_minus = 0;
            #(CLOCK*8)
            tb_d_plus = 1;
            tb_d_minus = 0;
            #(CLOCK*8)
            tb_d_plus = 0;
            tb_d_minus = 1;
            #(CLOCK*8)

            //Addr of setup
            //expected = 7'b1100011;
            tb_d_plus = 0;
            tb_d_minus = 1;
            #(CLOCK*8)
            tb_d_plus = 0;
            tb_d_minus = 1;
            #(CLOCK*8)
            tb_d_plus = 1;
            tb_d_minus = 0;
            #(CLOCK*8)
            tb_d_plus = 0;
            tb_d_minus = 1;
            #(CLOCK*8)
            tb_d_plus = 1;
            tb_d_minus = 0;
            #(CLOCK*8)
            tb_d_plus = 1;
            tb_d_minus = 0;
            #(CLOCK*8)
            tb_d_plus = 1;
            tb_d_minus = 0;
            #(CLOCK*8)
        
            //4 other bits of setup
            //expected = 4'b0000
            tb_d_plus = 0;
            tb_d_minus = 1;
            #(CLOCK*8)
            tb_d_plus = 1;
            tb_d_minus = 0;
            #(CLOCK*8)
            tb_d_plus = 0;
            tb_d_minus = 1;
            #(CLOCK*8)
            tb_d_plus = 1;
            tb_d_minus = 0;
            #(CLOCK*8)
            
            //crc5 of 11011 Good CRC
            tb_d_plus = 1;
            tb_d_minus = 0;
            #(CLOCK*8)
            tb_d_plus = 1;
            tb_d_minus = 0;
            #(CLOCK*8)
            tb_d_plus = 0;
            tb_d_minus = 1;
            #(CLOCK*8)
            tb_d_plus = 0;
            tb_d_minus = 1;
            #(CLOCK*8)
            tb_d_plus = 0;
            tb_d_minus = 1;
            #(CLOCK*8)

            //Test eop while rcving
            tb_d_plus = 0;
            tb_d_minus = 0;
            #(CLOCK*8)
            tb_d_plus = 0;
            tb_d_minus = 0;
            #(CLOCK*8)
            tb_d_plus = 1;
            tb_d_minus = 0;
        end
    endtask
    
    task OUTtoken_bad_pid();
        begin
            //Sync Byte
	   tb_test_num++;
            tb_d_plus = 0;
            tb_d_minus = 1;
            #(CLOCK*8)
            tb_d_plus = 1;
            tb_d_minus = 0;
            #(CLOCK*8)
            tb_d_plus = 0;
            tb_d_minus = 1;
            #(CLOCK*8)
            tb_d_plus = 1;
            tb_d_minus = 0;
            #(CLOCK*8)
            tb_d_plus = 0;
            tb_d_minus = 1;
            #(CLOCK*8)
            tb_d_plus = 1;
            tb_d_minus = 0;
            #(CLOCK*8)
            tb_d_plus = 0;
            tb_d_minus = 1;
            #(CLOCK*8)
            tb_d_plus = 0;
            tb_d_minus = 1;
            #(CLOCK*8)

            //PID Setup Byte needs to be 10000111
            //bad PID 10000110
            tb_d_plus = 0;
            tb_d_minus = 1;
            #(CLOCK*8)
            tb_d_plus = 1;
            tb_d_minus = 0;
            #(CLOCK*8)
            tb_d_plus = 0;
            tb_d_minus = 1;
            #(CLOCK*8)
            tb_d_plus = 1;
            tb_d_minus = 0;
            #(CLOCK*8)
            tb_d_plus = 0;
            tb_d_minus = 1;
            #(CLOCK*8)
            tb_d_plus = 0;
            tb_d_minus = 1;
            #(CLOCK*8)
            tb_d_plus = 0;
            tb_d_minus = 1;
            #(CLOCK*8)
            tb_d_plus = 1;
            tb_d_minus = 0;
            #(CLOCK*8)

            //Addr of setup
            //expected = 7'b1100011
            tb_d_plus = 0;
            tb_d_minus = 1;
            #(CLOCK*8)
            tb_d_plus = 0;
            tb_d_minus = 1;
            #(CLOCK*8)
            tb_d_plus = 1;
            tb_d_minus = 0;
            #(CLOCK*8)
            tb_d_plus = 0;
            tb_d_minus = 1;
            #(CLOCK*8)
            tb_d_plus = 1;
            tb_d_minus = 0;
            #(CLOCK*8)
            tb_d_plus = 1;
            tb_d_minus = 0;
            #(CLOCK*8)
            tb_d_plus = 1;
            tb_d_minus = 0;
            #(CLOCK*8)
        
            //4 other bits of setup
            //expected = 4'b0000
            tb_d_plus = 0;
            tb_d_minus = 1;
            #(CLOCK*8)
            tb_d_plus = 1;
            tb_d_minus = 0;
            #(CLOCK*8)
            tb_d_plus = 0;
            tb_d_minus = 1;
            #(CLOCK*8)
            tb_d_plus = 1;
            tb_d_minus = 0;
            #(CLOCK*8)
            
            //crc5 of setup
            tb_d_plus = 1;
            tb_d_minus = 0;
            #(CLOCK*8)
            tb_d_plus = 0;
            tb_d_minus = 1;
            #(CLOCK*8)
            tb_d_plus = 0;
            tb_d_minus = 1;
            #(CLOCK*8)
            tb_d_plus = 0;
            tb_d_minus = 1;
            #(CLOCK*8)
            tb_d_plus = 0;
            tb_d_minus = 1;
            #(CLOCK*8)

            //Test eop while rcving
            tb_d_plus = 0;
            tb_d_minus = 0;
            #(CLOCK*8)
            tb_d_plus = 0;
            tb_d_minus = 0;
            #(CLOCK*8)
            tb_d_plus = 1;
            tb_d_minus = 0;
        end
    endtask
    
    task OUTtoken_bad_crc();
        begin      
	  tb_test_num++;      
            //Sync Byte
            tb_d_plus = 0;
            tb_d_minus = 1;
            #(CLOCK*8)
            tb_d_plus = 1;
            tb_d_minus = 0;
            #(CLOCK*8)
            tb_d_plus = 0;
            tb_d_minus = 1;
            #(CLOCK*8)
            tb_d_plus = 1;
            tb_d_minus = 0;
            #(CLOCK*8)
            tb_d_plus = 0;
            tb_d_minus = 1;
            #(CLOCK*8)
            tb_d_plus = 1;
            tb_d_minus = 0;
            #(CLOCK*8)
            tb_d_plus = 0;
            tb_d_minus = 1;
            #(CLOCK*8)
            tb_d_plus = 0;
            tb_d_minus = 1;
            #(CLOCK*8)

            //PID  OUT 10000111
            tb_d_plus = 0;
            tb_d_minus = 1;
            #(CLOCK*8)
            tb_d_plus = 1;
            tb_d_minus = 0;
            #(CLOCK*8)
            tb_d_plus = 0;
            tb_d_minus = 1;
            #(CLOCK*8)
            tb_d_plus = 1;
            tb_d_minus = 0;
            #(CLOCK*8)
            tb_d_plus = 0;
            tb_d_minus = 1;
            #(CLOCK*8)
            tb_d_plus = 0;
            tb_d_minus = 1;
            #(CLOCK*8)
            tb_d_plus = 0;
            tb_d_minus = 1;
            #(CLOCK*8)
            tb_d_plus = 0;
            tb_d_minus = 1;
            #(CLOCK*8)

            //Addr of setup
            //expected = 7'b1100011;
            tb_d_plus = 0;
            tb_d_minus = 1;
            #(CLOCK*8)
            tb_d_plus = 0;
            tb_d_minus = 1;
            #(CLOCK*8)
            tb_d_plus = 1;
            tb_d_minus = 0;
            #(CLOCK*8)
            tb_d_plus = 0;
            tb_d_minus = 1;
            #(CLOCK*8)
            tb_d_plus = 1;
            tb_d_minus = 0;
            #(CLOCK*8)
            tb_d_plus = 1;
            tb_d_minus = 0;
            #(CLOCK*8)
            tb_d_plus = 1;
            tb_d_minus = 0;
            #(CLOCK*8)
        
            //4 other bits of setup
            //expected = 4'b0000
            //bad data 0011
            tb_d_plus = 0;
            tb_d_minus = 1;
            #(CLOCK*8)
            tb_d_plus = 1;
            tb_d_minus = 0;
            #(CLOCK*8)
            tb_d_plus = 1;
            tb_d_minus = 0;
            /*tb_d_plus = 0;
            tb_d_minus = 1;
            #(CLOCK*8)*/
            tb_d_plus = 1;
            tb_d_minus = 0;
            #(CLOCK*8)
            
            //crc5 of setup
            tb_d_plus = 1;
            tb_d_minus = 0;
            #(CLOCK*8)
            tb_d_plus = 0;
            tb_d_minus = 1;
            #(CLOCK*8)
            tb_d_plus = 0;
            tb_d_minus = 1;
            #(CLOCK*8)
            tb_d_plus = 0;
            tb_d_minus = 1;
            #(CLOCK*8)
            tb_d_plus = 0;
            tb_d_minus = 1;
            #(CLOCK*8)

            //Test eop while rcving
            tb_d_plus = 0;
            tb_d_minus = 0;
            #(CLOCK*8)
            tb_d_plus = 0;
            tb_d_minus = 0;
            #(CLOCK*8)
            tb_d_plus = 1;
            tb_d_minus = 0;
        end
    endtask
    
    task ACK();
       begin
	  tb_test_num++;
            //Sync Byte
            tb_d_plus = 0;
            tb_d_minus = 1;
            #(CLOCK*8)
            tb_d_plus = 1;
            tb_d_minus = 0;
            #(CLOCK*8)
            tb_d_plus = 0;
            tb_d_minus = 1;
            #(CLOCK*8)
            tb_d_plus = 1;
            tb_d_minus = 0;
            #(CLOCK*8)
            tb_d_plus = 0;
            tb_d_minus = 1;
            #(CLOCK*8)
            tb_d_plus = 1;
            tb_d_minus = 0;
            #(CLOCK*8)
            tb_d_plus = 0;
            tb_d_minus = 1;
            #(CLOCK*8)
            tb_d_plus = 0;
            tb_d_minus = 1;
            #(CLOCK*8)
        
            //PID 8'b01001011
            tb_d_plus = 1;
            tb_d_minus = 0;
            #(CLOCK*8)
            tb_d_plus = 1;
            tb_d_minus = 0;
            #(CLOCK*8)
            tb_d_plus = 0;
            tb_d_minus = 1;
            #(CLOCK*8)
            tb_d_plus = 1;
            tb_d_minus = 0;
            #(CLOCK*8)
            tb_d_plus = 1;
            tb_d_minus = 0;
            #(CLOCK*8)
            tb_d_plus = 0;
            tb_d_minus = 1;
            #(CLOCK*8)
            tb_d_plus = 0;
            tb_d_minus = 1;
            #(CLOCK*8)
            tb_d_plus = 0;
            tb_d_minus = 1;
            #(CLOCK*8)
            
            //EOP
            tb_d_plus = 0;
            tb_d_minus = 0;
            #(CLOCK*8)
            tb_d_plus = 0;
            tb_d_minus = 0;
            #(CLOCK*8)
            tb_d_plus = 1;
            tb_d_minus = 0;
        end
    endtask
    
    task ACK_bad_pid();
       begin
	  tb_test_num++;
            //Sync Byte
            tb_d_plus = 0;
            tb_d_minus = 1;
            #(CLOCK*8)
            tb_d_plus = 1;
            tb_d_minus = 0;
            #(CLOCK*8)
            tb_d_plus = 0;
            tb_d_minus = 1;
            #(CLOCK*8)
            tb_d_plus = 1;
            tb_d_minus = 0;
            #(CLOCK*8)
            tb_d_plus = 0;
            tb_d_minus = 1;
            #(CLOCK*8)
            tb_d_plus = 1;
            tb_d_minus = 0;
            #(CLOCK*8)
            tb_d_plus = 0;
            tb_d_minus = 1;
            #(CLOCK*8)
            tb_d_plus = 0;
            tb_d_minus = 1;
            #(CLOCK*8)
        
            //bad PID 01001010
            //
            tb_d_plus = 1;
            tb_d_minus = 0;
            #(CLOCK*8)
            tb_d_plus = 1;
            tb_d_minus = 0;
            #(CLOCK*8)
            tb_d_plus = 0;
            tb_d_minus = 1;
            #(CLOCK*8)
            tb_d_plus = 1;
            tb_d_minus = 0;
            #(CLOCK*8)
            tb_d_plus = 1;
            tb_d_minus = 0;
            #(CLOCK*8)
            tb_d_plus = 0;
            tb_d_minus = 1;
            #(CLOCK*8)
            tb_d_plus = 0;
            tb_d_minus = 1;
            #(CLOCK*8)
            tb_d_plus = 1;
            tb_d_minus = 0;
            #(CLOCK*8)
            
            //EOP
            tb_d_plus = 0;
            tb_d_minus = 0;
            #(CLOCK*8)
            tb_d_plus = 0;
            tb_d_minus = 0;
            #(CLOCK*8)
            tb_d_plus = 1;
            tb_d_minus = 0;
        end
    endtask
    
    task NAK();
       begin
	  tb_test_num++;
            //Sync Byte
            tb_d_plus = 0;
            tb_d_minus = 1;
            #(CLOCK*8)
            tb_d_plus = 1;
            tb_d_minus = 0;
            #(CLOCK*8)
            tb_d_plus = 0;
            tb_d_minus = 1;
            #(CLOCK*8)
            tb_d_plus = 1;
            tb_d_minus = 0;
            #(CLOCK*8)
            tb_d_plus = 0;
            tb_d_minus = 1;
            #(CLOCK*8)
            tb_d_plus = 1;
            tb_d_minus = 0;
            #(CLOCK*8)
            tb_d_plus = 0;
            tb_d_minus = 1;
            #(CLOCK*8)
            tb_d_plus = 0;
            tb_d_minus = 1;
            #(CLOCK*8)
            
            //PID 8'10100101 send in 10100101 //01011010 send in 01011010
            tb_d_plus = 1;
            tb_d_minus = 0;
            #(CLOCK*8)
            tb_d_plus = 1;
            tb_d_minus = 0;
            #(CLOCK*8)
            tb_d_plus = 0;
            tb_d_minus = 1;
            #(CLOCK*8)
            tb_d_plus = 0;
            tb_d_minus = 1;
            #(CLOCK*8)
            tb_d_plus = 0;
            tb_d_minus = 1;
            #(CLOCK*8)
            tb_d_plus = 1;
            tb_d_minus = 0;
            #(CLOCK*8)
            tb_d_plus = 1;
            tb_d_minus = 0;
            #(CLOCK*8)
            tb_d_plus = 0;
            tb_d_minus = 1;
            #(CLOCK*8)
            
            //EOP
            tb_d_plus = 0;
            tb_d_minus = 0;
            #(CLOCK*8)
            tb_d_plus = 0;
            tb_d_minus = 0;
            #(CLOCK*8)
            tb_d_plus = 1;
            tb_d_minus = 0;
        end
    endtask
    
    task stall_handshake();
       begin
	  tb_test_num++;
            //HANDSHAKE - STALL

            //Sync Byte
            tb_d_plus = 0;
            tb_d_minus = 1;
            #(CLOCK*8)
            tb_d_plus = 1;
            tb_d_minus = 0;
            #(CLOCK*8)
            tb_d_plus = 0;
            tb_d_minus = 1;
            #(CLOCK*8)
            tb_d_plus = 1;
            tb_d_minus = 0;
            #(CLOCK*8)
            tb_d_plus = 0;
            tb_d_minus = 1;
            #(CLOCK*8)
            tb_d_plus = 1;
            tb_d_minus = 0;
            #(CLOCK*8)
            tb_d_plus = 0;
            tb_d_minus = 1;
            #(CLOCK*8)
            tb_d_plus = 0;
            tb_d_minus = 1;
            #(CLOCK*8)
            
            //PID 8'11100001 send in 10000111 // 01111000 send in 00011110
            tb_d_plus = 1;
            tb_d_minus = 0;
            #(CLOCK*8)
            tb_d_plus = 0;
            tb_d_minus = 1;
            #(CLOCK*8)
            tb_d_plus = 1;
            tb_d_minus = 0;
            #(CLOCK*8)
            tb_d_plus = 1;
            tb_d_minus = 0;
            #(CLOCK*8)
            tb_d_plus = 1;
            tb_d_minus = 0;
            #(CLOCK*8)
            tb_d_plus = 1;
            tb_d_minus = 0;
            #(CLOCK*8)
            tb_d_plus = 1;
            tb_d_minus = 0;
            #(CLOCK*8)
            tb_d_plus = 0;
            tb_d_minus = 1;
            #(CLOCK*8)
            
            //EOP
            tb_d_plus = 0;
            tb_d_minus = 0;
            #(CLOCK*8)
            tb_d_plus = 0;
            tb_d_minus = 0;
            #(CLOCK*8)
            tb_d_plus = 1;
            tb_d_minus = 0;
        end
    endtask
    
    task in_token();
       begin
	  tb_test_num++;
            //Sync Byte
            tb_d_plus = 0;
            tb_d_minus = 1;
            #(CLOCK*8)
            tb_d_plus = 1;
            tb_d_minus = 0;
            #(CLOCK*8)
            tb_d_plus = 0;
            tb_d_minus = 1;
            #(CLOCK*8)
            tb_d_plus = 1;
            tb_d_minus = 0;
            #(CLOCK*8)
            tb_d_plus = 0;
            tb_d_minus = 1;
            #(CLOCK*8)
            tb_d_plus = 1;
            tb_d_minus = 0;
            #(CLOCK*8)
            tb_d_plus = 0;
            tb_d_minus = 1;
            #(CLOCK*8)
            tb_d_plus = 0;
            tb_d_minus = 1;
            #(CLOCK*8)

            //PID 10010110 send in 01101001 
            tb_d_plus = 1;
            tb_d_minus = 0;
            #(CLOCK*8)
            tb_d_plus = 1;
            tb_d_minus = 0;
            #(CLOCK*8)
            tb_d_plus = 1;
            tb_d_minus = 0;
            #(CLOCK*8)
            tb_d_plus = 0;
            tb_d_minus = 1;
            #(CLOCK*8)
            tb_d_plus = 0;
            tb_d_minus = 1;
            #(CLOCK*8)
            tb_d_plus = 1;
            tb_d_minus = 0;
            #(CLOCK*8)
            tb_d_plus = 0;
            tb_d_minus = 1;
            #(CLOCK*8)
            tb_d_plus = 0;
            tb_d_minus = 1;
            #(CLOCK*8)

            //Addr of setup
            //expected = 7'b1100011;
            tb_d_plus = 0;
            tb_d_minus = 1;
            #(CLOCK*8)
            tb_d_plus = 0;
            tb_d_minus = 1;
            #(CLOCK*8)
            tb_d_plus = 1;
            tb_d_minus = 0;
            #(CLOCK*8)
            tb_d_plus = 0;
            tb_d_minus = 1;
            #(CLOCK*8)
            tb_d_plus = 1;
            tb_d_minus = 0;
            #(CLOCK*8)
            tb_d_plus = 1;
            tb_d_minus = 0;
            #(CLOCK*8)
            tb_d_plus = 1;
            tb_d_minus = 0;
            #(CLOCK*8)
            
            //4 other bits of setup
            //expected = 4'b1111
            tb_d_plus = 1;
            tb_d_minus = 0;
            #(CLOCK*8)
            tb_d_plus = 1;
            tb_d_minus = 0;
            #(CLOCK*8)
            tb_d_plus = 1;
            tb_d_minus = 0;
            #(CLOCK*8)
            tb_d_plus = 1;
            tb_d_minus = 0;
            #(CLOCK*8)
            //stuffed bit
            tb_d_plus = 1;
            tb_d_minus = 0;
            #(CLOCK*8)
            
            //crc5 of setup
            tb_d_plus = 0;
            tb_d_minus = 1;
            #(CLOCK*8)
            tb_d_plus = 1;
            tb_d_minus = 0;
            #(CLOCK*8)
            tb_d_plus = 0;
            tb_d_minus = 1;
            #(CLOCK*8)
            tb_d_plus = 1;
            tb_d_minus = 0;
            #(CLOCK*8)
            tb_d_plus = 1;
            tb_d_minus = 0;
            #(CLOCK*8)

            //Test eop while rcving
            tb_d_plus = 0;
            tb_d_minus = 0;
            #(CLOCK*8)
            tb_d_plus = 0;
            tb_d_minus = 0;
            #(CLOCK*8)
            tb_d_plus = 1;
            tb_d_minus = 0;
        end
    endtask
    
    task out_token();
       begin
	  tb_test_num++;
            //Sync Byte
            tb_d_plus = 0;
            tb_d_minus = 1;
            #(CLOCK*8)
            tb_d_plus = 1;
            tb_d_minus = 0;
            #(CLOCK*8)
            tb_d_plus = 0;
            tb_d_minus = 1;
            #(CLOCK*8)
            tb_d_plus = 1;
            tb_d_minus = 0;
            #(CLOCK*8)
            tb_d_plus = 0;
            tb_d_minus = 1;
            #(CLOCK*8)
            tb_d_plus = 1;
            tb_d_minus = 0;
            #(CLOCK*8)
            tb_d_plus = 0;
            tb_d_minus = 1;
            #(CLOCK*8)
            tb_d_plus = 0;
            tb_d_minus = 1;
            #(CLOCK*8)

            //PID 00011110 send 01111000 //10000111 send in 11100001
            tb_d_plus = 0;
            tb_d_minus = 1;
            #(CLOCK*8)
            tb_d_plus = 1;
            tb_d_minus = 0;
            #(CLOCK*8)
            tb_d_plus = 0;
            tb_d_minus = 1;
            #(CLOCK*8)
            tb_d_plus = 1;
            tb_d_minus = 0;
            #(CLOCK*8)
            tb_d_plus = 0;
            tb_d_minus = 1;
            #(CLOCK*8)
            tb_d_plus = 0;
            tb_d_minus = 1;
            #(CLOCK*8)
            tb_d_plus = 0;
            tb_d_minus = 1;
            #(CLOCK*8)
            tb_d_plus = 0;
            tb_d_minus = 1;
            #(CLOCK*8)

            //Addr of setup
            //expected = 7'b1100011;
            tb_d_plus = 0;
            tb_d_minus = 1;
            #(CLOCK*8)
            tb_d_plus = 0;
            tb_d_minus = 1;
            #(CLOCK*8)
            tb_d_plus = 1;
            tb_d_minus = 0;
            #(CLOCK*8)
            tb_d_plus = 0;
            tb_d_minus = 1;
            #(CLOCK*8)
            tb_d_plus = 1;
            tb_d_minus = 0;
            #(CLOCK*8)
            tb_d_plus = 1;
            tb_d_minus = 0;
            #(CLOCK*8)
            tb_d_plus = 1;
            tb_d_minus = 0;
            #(CLOCK*8)
            
            //4 other bits of setup
            //expected = 4'b1111
            tb_d_plus = 1;
            tb_d_minus = 0;
            #(CLOCK*8)
            tb_d_plus = 1;
            tb_d_minus = 0;
            #(CLOCK*8)
            tb_d_plus = 1;
            tb_d_minus = 0;
            #(CLOCK*8)
            tb_d_plus = 1;
            tb_d_minus = 0;
            #(CLOCK*8)
            //stuffed bit
            tb_d_plus = 1;
            tb_d_minus = 0;
            #(CLOCK*8)
            
            //crc5 of setup
            tb_d_plus = 0;
            tb_d_minus = 1;
            #(CLOCK*8)
            tb_d_plus = 1;
            tb_d_minus = 0;
            #(CLOCK*8)
            tb_d_plus = 0;
            tb_d_minus = 1;
            #(CLOCK*8)
            tb_d_plus = 1;
            tb_d_minus = 0;
            #(CLOCK*8)
            tb_d_plus = 1;
            tb_d_minus = 0;
            #(CLOCK*8)

            //Test eop while rcving
            tb_d_plus = 0;
            tb_d_minus = 0;
            #(CLOCK*8)
            tb_d_plus = 0;
            tb_d_minus = 0;
            #(CLOCK*8)
            tb_d_plus = 1;
            tb_d_minus = 0;
        end
    endtask
    
   task data_packet();
      begin
	 tb_test_num++;
            //Sync Byte
            tb_d_plus = 0;
            tb_d_minus = 1;
            #(CLOCK*8)
            tb_d_plus = 1;
            tb_d_minus = 0;
            #(CLOCK*8)
            tb_d_plus = 0;
            tb_d_minus = 1;
            #(CLOCK*8)
            tb_d_plus = 1;
            tb_d_minus = 0;
            #(CLOCK*8)
            tb_d_plus = 0;
            tb_d_minus = 1;
            #(CLOCK*8)
            tb_d_plus = 1;
            tb_d_minus = 0;
            #(CLOCK*8)
            tb_d_plus = 0;
            tb_d_minus = 1;
            #(CLOCK*8)
            tb_d_plus = 0;
            tb_d_minus = 1;
            #(CLOCK*8)

	  //PID 11001100 Data0
            tb_d_plus = 0;
            tb_d_minus = 1;
            #(CLOCK*8)
            tb_d_plus = 0;
            tb_d_minus = 1;
            #(CLOCK*8)
            tb_d_plus = 1;
            tb_d_minus = 0;
            #(CLOCK*8)
            tb_d_plus = 0;
            tb_d_minus = 1;
            #(CLOCK*8)
            tb_d_plus = 0;
            tb_d_minus = 1;
            #(CLOCK*8)
            tb_d_plus = 0;
            tb_d_minus = 1;
            #(CLOCK*8)
            tb_d_plus = 1;
            tb_d_minus = 0;
            #(CLOCK*8)
            tb_d_plus = 0;
            tb_d_minus = 1;
            #(CLOCK*8)
            
            //data byte 1 - 11110000
            tb_d_plus = 0;
            tb_d_minus = 1;
            #(CLOCK*8)
            tb_d_plus = 0;
            tb_d_minus = 1;
            #(CLOCK*8)
            tb_d_plus = 0;
            tb_d_minus = 1;
            #(CLOCK*8)
            tb_d_plus = 0;
            tb_d_minus = 1;
            #(CLOCK*8)
            tb_d_plus = 1;
            tb_d_minus = 0;
            #(CLOCK*8)
            tb_d_plus = 0;
            tb_d_minus = 1;
            #(CLOCK*8)
            tb_d_plus = 1;
            tb_d_minus = 0;
            #(CLOCK*8)
            tb_d_plus = 0;
            tb_d_minus = 1;
            #(CLOCK*8)
            
            //data byte 2 - 10010101
            tb_d_plus = 0;
            tb_d_minus = 1;
            #(CLOCK*8)
            tb_d_plus = 1;
            tb_d_minus = 0;
            #(CLOCK*8)
            tb_d_plus = 0;
            tb_d_minus = 1;
            #(CLOCK*8)
            tb_d_plus = 0;
            tb_d_minus = 1;
            #(CLOCK*8)
            tb_d_plus = 1;
            tb_d_minus = 0;
            #(CLOCK*8)
            tb_d_plus = 1;
            tb_d_minus = 0;
            #(CLOCK*8)
            tb_d_plus = 0;
            tb_d_minus = 1;
            #(CLOCK*8)
            tb_d_plus = 0;
            tb_d_minus = 1;
            #(CLOCK*8)
            
            //crc 16 for data 01011100-10101010//1111011101011110 //0111000000111000
            //first 8 bits of crc
            tb_d_plus = 1;
            tb_d_minus = 0;
            #(CLOCK*8)
            tb_d_plus = 1;
            tb_d_minus = 0;
            #(CLOCK*8)
            tb_d_plus = 1;
            tb_d_minus = 0;
            #(CLOCK*8)
            tb_d_plus = 1;
            tb_d_minus = 0;
            #(CLOCK*8)
            tb_d_plus = 0;
            tb_d_minus = 1;
            #(CLOCK*8)
            tb_d_plus = 1;
            tb_d_minus = 0;
            #(CLOCK*8)
            tb_d_plus = 0;
            tb_d_minus = 1;
            #(CLOCK*8)
            tb_d_plus = 1;
            tb_d_minus = 0;
            #(CLOCK*8)
            //second 8 bits of crc
            tb_d_plus = 0;
            tb_d_minus = 1;
            #(CLOCK*8)
            tb_d_plus = 1;
            tb_d_minus = 0;
            #(CLOCK*8)
            tb_d_plus = 1;
            tb_d_minus = 0;
            #(CLOCK*8)
            tb_d_plus = 1;
            tb_d_minus = 0;
            #(CLOCK*8)
            tb_d_plus = 1;
            tb_d_minus = 0;
            #(CLOCK*8)
            tb_d_plus = 0;
            tb_d_minus = 1;
            #(CLOCK*8)
            tb_d_plus = 1;
            tb_d_minus = 0;
            #(CLOCK*8)
            tb_d_plus = 0;
            tb_d_minus = 1;
            #(CLOCK*8)
            
            //Test eop while rcving
            tb_d_plus = 0;
            tb_d_minus = 0;
            #(CLOCK*8)
            tb_d_plus = 0;
            tb_d_minus = 0;
            #(CLOCK*8)
            tb_d_plus = 1;
            tb_d_minus = 0;
        end
    endtask  


   
    task data_packet2();// Data0
       begin
	  tb_test_num++;
            //Sync Byte
            tb_d_plus = 0;
            tb_d_minus = 1;
            #(CLOCK*8)
            tb_d_plus = 1;
            tb_d_minus = 0;
            #(CLOCK*8)
            tb_d_plus = 0;
            tb_d_minus = 1;
            #(CLOCK*8)
            tb_d_plus = 1;
            tb_d_minus = 0;
            #(CLOCK*8)
            tb_d_plus = 0;
            tb_d_minus = 1;
            #(CLOCK*8)
            tb_d_plus = 1;
            tb_d_minus = 0;
            #(CLOCK*8)
            tb_d_plus = 0;
            tb_d_minus = 1;
            #(CLOCK*8)
            tb_d_plus = 0;
            tb_d_minus = 1;
            #(CLOCK*8)

       /*     //PID 00111100 send in 00111100 
            tb_d_plus = 1;
            tb_d_minus = 0;
            #(CLOCK*8)
            tb_d_plus = 0;
            tb_d_minus = 1;
            #(CLOCK*8)
            tb_d_plus = 0;
            tb_d_minus = 1;
            #(CLOCK*8)
            tb_d_plus = 0;
            tb_d_minus = 1;
            #(CLOCK*8)
            tb_d_plus = 0;
            tb_d_minus = 1;
            #(CLOCK*8)
            tb_d_plus = 0;
            tb_d_minus = 1;
            #(CLOCK*8)
            tb_d_plus = 1;
            tb_d_minus = 0;
            #(CLOCK*8)
            tb_d_plus = 0;
            tb_d_minus = 1;
            #(CLOCK*8)*/
	  //PID 11001100 send in 00110011
            tb_d_plus = 1;
            tb_d_minus = 0;
            #(CLOCK*8)
            tb_d_plus = 0;
            tb_d_minus = 1;
            #(CLOCK*8)
            tb_d_plus = 0;
            tb_d_minus = 1;
            #(CLOCK*8)
            tb_d_plus = 0;
            tb_d_minus = 1;
            #(CLOCK*8)
            tb_d_plus = 1;
            tb_d_minus = 0;
            #(CLOCK*8)
            tb_d_plus = 0;
            tb_d_minus = 1;
            #(CLOCK*8)
            tb_d_plus = 0;
            tb_d_minus = 1;
            #(CLOCK*8)
            tb_d_plus = 0;
            tb_d_minus = 1;
            #(CLOCK*8)
            
            //data byte 1 - 11110000
            tb_d_plus = 0;
            tb_d_minus = 1;
            #(CLOCK*8)
            tb_d_plus = 0;
            tb_d_minus = 1;
            #(CLOCK*8)
            tb_d_plus = 0;
            tb_d_minus = 1;
            #(CLOCK*8)
            tb_d_plus = 0;
            tb_d_minus = 1;
            #(CLOCK*8)
            tb_d_plus = 1;
            tb_d_minus = 0;
            #(CLOCK*8)
            tb_d_plus = 0;
            tb_d_minus = 1;
            #(CLOCK*8)
            tb_d_plus = 1;
            tb_d_minus = 0;
            #(CLOCK*8)
            tb_d_plus = 0;
            tb_d_minus = 1;
            #(CLOCK*8)
            
            //data byte 2 - 10010101
            tb_d_plus = 0;
            tb_d_minus = 1;
            #(CLOCK*8)
            tb_d_plus = 1;
            tb_d_minus = 0;
            #(CLOCK*8)
            tb_d_plus = 0;
            tb_d_minus = 1;
            #(CLOCK*8)
            tb_d_plus = 0;
            tb_d_minus = 1;
            #(CLOCK*8)
            tb_d_plus = 1;
            tb_d_minus = 0;
            #(CLOCK*8)
            tb_d_plus = 1;
            tb_d_minus = 0;
            #(CLOCK*8)
            tb_d_plus = 0;
            tb_d_minus = 1;
            #(CLOCK*8)
            tb_d_plus = 0;
            tb_d_minus = 1;
            #(CLOCK*8)
            
            //crc 16 for data 01011100-10101010
            //first 8 bits of crc
            tb_d_plus = 1;
            tb_d_minus = 0;
            #(CLOCK*8)
            tb_d_plus = 1;
            tb_d_minus = 0;
            #(CLOCK*8)
            tb_d_plus = 0;
            tb_d_minus = 1;
            #(CLOCK*8)
            tb_d_plus = 0;
            tb_d_minus = 1;
            #(CLOCK*8)
            tb_d_plus = 0;
            tb_d_minus = 1;
            #(CLOCK*8)
            tb_d_plus = 0;
            tb_d_minus = 1;
            #(CLOCK*8)
            tb_d_plus = 1;
            tb_d_minus = 0;
            #(CLOCK*8)
            tb_d_plus = 0;
            tb_d_minus = 1;
            #(CLOCK*8)
            //second 8 bits of crc
            tb_d_plus = 0;
            tb_d_minus = 1;
            #(CLOCK*8)
            tb_d_plus = 1;
            tb_d_minus = 0;
            #(CLOCK*8)
            tb_d_plus = 1;
            tb_d_minus = 0;
            #(CLOCK*8)
            tb_d_plus = 0;
            tb_d_minus = 1;
            #(CLOCK*8)
            tb_d_plus = 0;
            tb_d_minus = 1;
            #(CLOCK*8)
            tb_d_plus = 1;
            tb_d_minus = 0;
            #(CLOCK*8)
            tb_d_plus = 1;
            tb_d_minus = 0;
            #(CLOCK*8)
            tb_d_plus = 0;
            tb_d_minus = 1;
            #(CLOCK*8)
            
            //Test eop while rcving
            tb_d_plus = 0;
            tb_d_minus = 0;
            #(CLOCK*8)
            tb_d_plus = 0;
            tb_d_minus = 0;
            #(CLOCK*8)
            tb_d_plus = 1;
            tb_d_minus = 0;
        end
    endtask
            
endmodule
