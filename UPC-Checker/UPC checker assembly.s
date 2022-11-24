		AREA question1, code, READONLY
		ENTRY


        ADR r4, UPC         ;address of UPC string in memory
        ADD r9, r4, #11     ;address of last byte of the upc string to see where the end is
        
        MOV r1, #0
        MOV r2, #0
        
loop    LDRB r7, [r4], #1   ;adding up the first sum inside r1
        SUB r7, r7, #0x30
        ADD r1, r1, r7
        
        CMP r4, r9          ;checking whether we are at the end of the string or not
        
        LDRB r8, [r4], #1   ;gathering the values for the second sum
        SUB r8, r8, #0x30
        ADD r2, r2, r8      ;second sum + check digit
        
        BNE loop
        
                            
        ADD r1, r1, LSL #1  ;multiply by first sum by 3
        
                            
        ADDS r1, r1, r2     ;add the second sum and the first sum
        
        BEQ yes
        
multen	SUBS r1, r1, #0xA   ;subtraction loop to check whether the number is a multiple of 10

        BEQ yes		        ;if it is 0 then we exit and store 1 in r0 as it is a valid upc
		
		BMI no              ;if it is less than 0 it is not a multiple of ten therefore is incorrect
		
		BGT multen       
        
yes		MOV r0, #1          ;endpoints for the division loop

        B end            
            
no		MOV  r0, #2 

end     ADD r0,#0           ;22 lines
   
UPC	DCB "013800150738"
UPC2 DCB "000001000000" 
		END