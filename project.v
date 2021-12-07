module project(clk,rnd,button,out,num,N,I,C,E,reset,values);
   input clk;
   input reset;
	input[3:0] num; //user input
	input rnd; //button held to generate random numbers
	input button; //button pressed to check user input with stored values
	output [6:0] out;//displays user input
	output [6:0] values;//shows the random number sequence
	
	output [6:0] N; //this displays the win message
	output [6:0] I; //
   output [6:0] C; //
	output [6:0] E; //
	
	wire[3:0] rndvalue; 
	
	reg[3:0] a; //number generator
	reg[3:0] displayvar; //utilized for storing the random value to be put through the logic gates
	
	reg[3:0] display; //values get passed through these to form the letters for the win condition
	reg[3:0] display2;//
	reg[3:0] display3;//
	reg[3:0] display4;//
	
	reg[3:0] number1; //stores random numbers for comparison
	reg[3:0] number2; //
	reg[3:0] number3; //
	reg[3:0] number4; //
	
	reg[3:0] counter;//counter for random number generating and assigning
	reg[3:0] counts; //counter to track which number is being compared with which input
	

//cout changes after a set period of time which is done to slow down the internal clk of the board
reg[31:0] count; 
parameter D = 32'd3500000;
reg cout;
always @(posedge clk)
begin
   count <= count + 32'd1;
      if (count >= (D-1)) begin
         cout <= ~cout;
         count <= 32'd0;
      end
end

reg[3:0] button_r;//used to ensure that only release of button is tracked
always@(posedge cout)
begin
		button_r <= button;
		
		a <= a + 1;//number generator
		if(a > 8)
		begin
		a <= 0;
		end
	if(button == 0 && button_r == 1) //button press for number saving and comparison is pressed
	begin
		counter = counter + 1;
		if(counter == 1)
		begin
			if(num == number1)
				begin
				display <= 1;
				end
		end
		if(counter == 2)
		begin
			if(num == number2)
				begin
				display2 <= 1;
				end
		end
		if(counter == 3)
		begin
			if(num == number3)
				begin
				display3 <= 1;
				end
		end
		if(counter == 4)
		begin
			if(num == number4)
				begin
				display4 <= 1;
				end
		end
	end

	if(rnd == 0)//random number generator triggers on button press
	begin
	
		counts <= counts + 1;
		
		if(counts >= 1 && counts < 2)//these if statements randomize the values and stores them
		begin
		number1 <= a*2;
		end
		if(counts >=3 && counts < 4)
		begin
		number2 <= a*3;
		end
		if(counts >=5 && counts < 6)
		begin
		number3 <= a + 1;
		end
		
		if(counts >=7 && counts < 8)
		begin
		number4 <= a + 2;
		end
       

		
		if(counts == 8)//randomized values get displayed
		begin
		displayvar <= number1;
		end

		if(counts == 10)
		begin
		displayvar <= number2;
		end

		if(counts == 12)
		begin
		displayvar <= number3;
		end

		if(counts == 14 && counts < 16)
		begin
		displayvar <= number4;
		end
		
	end
		if(reset == 1)//resets all values to default values
		begin
		display<=0;
		display2<=0;
		display3<=0;
		display4<=0;
		displayvar <= 0;
		a<=0;
		counts<=0;
		counter<=0;
		end
end

   assign rndvalue = displayvar; 
	
	
	//displays random values
   assign values[0]= rnd == 1 ? 1 :(~rndvalue[3]&~rndvalue[2]&~rndvalue[1]&rndvalue[0])|(~rndvalue[3]&rndvalue[2]&~rndvalue[1]&~rndvalue[0])|(rndvalue[3]&~rndvalue[2]&rndvalue[1]&rndvalue[0])|(rndvalue[3]&rndvalue[2]&~rndvalue[1]&rndvalue[0]);

	assign values[1]= rnd == 1 ? 1 :(~rndvalue[3]&rndvalue[2]&~rndvalue[1]&rndvalue[0])|(~rndvalue[3]&rndvalue[2]&rndvalue[1]&~rndvalue[0])|(rndvalue[3]&~rndvalue[2]&rndvalue[1]&rndvalue[0])|(rndvalue[3]&rndvalue[2]&~rndvalue[1]&~rndvalue[0])|(rndvalue[3]&rndvalue[2]&rndvalue[1]&~rndvalue[0])|(rndvalue[3]&rndvalue[2]&rndvalue[1]&rndvalue[0]);

	assign values[2]= rnd == 1 ? 1 :(~rndvalue[3]&~rndvalue[2]&rndvalue[1]&~rndvalue[0])|(rndvalue[3]&rndvalue[2]&~rndvalue[1]&~rndvalue[0])|(rndvalue[3]&rndvalue[2]&rndvalue[1]&~rndvalue[0])|(rndvalue[3]&rndvalue[2]&rndvalue[1]&rndvalue[0]);

	assign values[3]= rnd == 1 ? 1 :(~rndvalue[3]&~rndvalue[2]&~rndvalue[1]&rndvalue[0])|(~rndvalue[3]&rndvalue[2]&~rndvalue[1]&~rndvalue[0])|(~rndvalue[3]&rndvalue[2]&rndvalue[1]&rndvalue[0])|(rndvalue[3]&~rndvalue[2]&rndvalue[1]&~rndvalue[0])|(rndvalue[3]&rndvalue[2]&rndvalue[1]&rndvalue[0]);

	assign values[4]= rnd == 1 ? 1 :(~rndvalue[3]&~rndvalue[2]&~rndvalue[1]&rndvalue[0])|(~rndvalue[3]&~rndvalue[2]&rndvalue[1]&rndvalue[0])|(~rndvalue[3]&rndvalue[2]&~rndvalue[1]&~rndvalue[0])|(~rndvalue[3]&rndvalue[2]&~rndvalue[1]&rndvalue[0])|(~rndvalue[3]&rndvalue[2]&rndvalue[1]&rndvalue[0])|(rndvalue[3]&~rndvalue[2]&~rndvalue[1]&rndvalue[0]);

	assign values[5]= rnd == 1 ? 1 :(~rndvalue[3]&~rndvalue[2]&~rndvalue[1]&rndvalue[0])|(~rndvalue[3]&~rndvalue[2]&rndvalue[1]&~rndvalue[0])|(~rndvalue[3]&~rndvalue[2]&rndvalue[1]&rndvalue[0])|(~rndvalue[3]&rndvalue[2]&rndvalue[1]&rndvalue[0])|(rndvalue[3]&rndvalue[2]&~rndvalue[1]&rndvalue[0]);
	
	assign values[6]= rnd == 1 ? 1 :(~rndvalue[3]&~rndvalue[2]&~rndvalue[1])|(~rndvalue[3]&rndvalue[2]&rndvalue[1]&rndvalue[0])|(rndvalue[3]&rndvalue[2]&~rndvalue[1]&~rndvalue[0]);
	 
	//displays user input	 
	assign out[0]=(~num[3]&~num[2]&~num[1]&num[0])|(~num[3]&num[2]&~num[1]&~num[0])|(num[3]&~num[2]&num[1]&num[0])|(num[3]&num[2]&~num[1]&num[0]);

	assign out[1]=(~num[3]&num[2]&~num[1]&num[0])|(~num[3]&num[2]&num[1]&~num[0])|(num[3]&~num[2]&num[1]&num[0])|(num[3]&num[2]&~num[1]&~num[0])|(num[3]&num[2]&num[1]&~num[0])|(num[3]&num[2]&num[1]&num[0]);

	assign out[2]=(~num[3]&~num[2]&num[1]&~num[0])|(num[3]&num[2]&~num[1]&~num[0])|(num[3]&num[2]&num[1]&~num[0])|(num[3]&num[2]&num[1]&num[0]);

	assign out[3]=(~num[3]&~num[2]&~num[1]&num[0])|(~num[3]&num[2]&~num[1]&~num[0])|(~num[3]&num[2]&num[1]&num[0])|(num[3]&~num[2]&num[1]&~num[0])|(num[3]&num[2]&num[1]&num[0]);

	assign out[4]=(~num[3]&~num[2]&~num[1]&num[0])|(~num[3]&~num[2]&num[1]&num[0])|(~num[3]&num[2]&~num[1]&~num[0])|(~num[3]&num[2]&~num[1]&num[0])|(~num[3]&num[2]&num[1]&num[0])|(num[3]&~num[2]&~num[1]&num[0]);

	assign out[5]=(~num[3]&~num[2]&~num[1]&num[0])|(~num[3]&~num[2]&num[1]&~num[0])|(~num[3]&~num[2]&num[1]&num[0])|(~num[3]&num[2]&num[1]&num[0])|(num[3]&num[2]&~num[1]&num[0]);
	
	assign out[6]=(~num[3]&~num[2]&~num[1])|(~num[3]&num[2]&num[1]&num[0])|(num[3]&num[2]&~num[1]&~num[0]);
	
	//displays win condition
	assign N[0]= display == 1 ? 0 : 1;

	assign N[1]= display == 1 ? 0 : 1;

	assign N[2]= display == 1 ? 0 : 1;

	assign N[3]= 1;

	assign N[4]= display == 1 ? 0 : 1;

   assign N[5]= display == 1 ? 0 : 1;
	
	assign N[6]= 1;
	
	
   assign I[0]= 1;

	assign I[1]= display2 == 1 ? 0 : 1;

	assign I[2]= display2 == 1 ? 0 : 1;

	assign I[3]= 1;
	
	assign I[4]= 1;

   assign I[5]= 1;
	
	assign I[6]= 1;
	

	assign C[0]= display3 == 1 ? 0 : 1;

	assign C[1] = 1;

	assign C[2] = 1;

	assign C[3]= display3 == 1 ? 0 : 1;

	assign C[4]= display3 == 1 ? 0 : 1;

   assign C[5]= display3 == 1 ? 0 : 1;
	
	assign C[6]= 1;
	
	
	assign E[0]= display4 == 1 ? 0 : 1;

	assign E[1]= 1;

	assign E[2]= 1;

	assign E[3]= display4 == 1 ? 0 : 1;

	assign E[4]= display4 == 1 ? 0 : 1;

   assign E[5]= display4 == 1 ? 0 : 1;
	
	assign E[6]= display4 == 1 ? 0 : 1;
	
	
endmodule