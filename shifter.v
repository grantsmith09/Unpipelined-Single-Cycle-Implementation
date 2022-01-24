module shifter (In, Cnt, Op, Out);

  input [15:0] In;
  input [3:0] Cnt; 
  input [1:0] Op; 
  output reg [15:0] Out;


  reg [15:0] eight_four, four_two, two_one;  



  always @(*) begin

    case ({Cnt[3], Op})
     
      3'b100: eight_four <= {In[7:0], In[15:8]};
      
      3'b101: eight_four <= {In[7:0], 8'h00};
    
      3'b110: eight_four <= {In[7:0], In[15:8]};
      
      3'b111: eight_four <= {8'h00, In[15:8]};
     
      default: eight_four <= In;
    endcase
  end

  always @(*) begin
  
    case ({Cnt[2], Op})
    
      3'b100: four_two <= {eight_four[11:0], eight_four[15:12]};
      
      3'b101: four_two <= {eight_four[13:0], 4'h0};
  
      3'b110: four_two <= {eight_four[3:0], eight_four[15:4]};
    
      3'b111: four_two <= {4'h0, eight_four[15:4]};
      
      default: four_two <= eight_four;
    endcase
  end

  always @(*) begin
    
    case ({Cnt[1], Op})
     
      3'b100: two_one <= {four_two[13:0], four_two[15:14]};
    
      3'b101: two_one <= {four_two[13:0], 2'b00};
      
      3'b110: two_one <= {four_two[1:0], four_two[15:2]};
     
      3'b111: two_one <= {2'b00, four_two[15:2]};
  
      default: two_one <= four_two;
    endcase
  end

  always @(*) begin
    
    case ({Cnt[0], Op})
   
      3'b100: Out <= {two_one[14:0], two_one[15]};
     
      3'b101: Out <= {two_one[14:0], 1'b0};
      
      3'b110: Out <= {two_one[0], two_one[15:1]};
      
      3'b111: Out <= {1'b0, two_one[15:1]};
     
      default: Out <= two_one;
    endcase
  end
  
endmodule
