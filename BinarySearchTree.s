		AREA BinarySearchTree, CODE, READONLY
		ENTRY
        ADR r0, ARRAY    ;Address the array into the register
        MOV r1, #19         ;set a 20 size of array size
        MOV r7,r0             ;Set a first adress of array in r7
   
InnerLoop    
        LDRB r2,[r0]        ;Load the array in r2
        LDRB r3,[r0,#1]    ;Move the address of r0 by 1 bit and load the value in r2
        CMP r2,r3            ;compare r2 with r3
        BLE Next             ;if r2 <=r3 hence it will go to next
        STRB r3,[r0]            ;else,store the smaller value that in r3 back the r0 
        STRB r2,[r0,#1]        ; store the bigger value in r2 back to the r0,the line 11 and 12 mean that the value of r2 and r3 exchange their position then store back to memory r0

Next    
        ADD r0,r0,#1    ;increase the addres by 1 bit for next numebr
        SUB r1,#1        ;decrease loop by 1
        CMP r1,#0        ;compare it with 0
        BNE InnerLoop   ; if not equal loop to inner loop
        MOV r0,r7            ;reset the address into the first place
        MOV  r1,#19        ;move the 19 into r1,reset the r1 to 19
        ADD r8,#1            ;add the r8 by one
        CMP r8,#19        ;the compare the with the 19 
        BNE InnerLoop                

        MOV r2   ,#9;Move the value 9 into r2to declare to place first middle array at position 10 of the array

LEFT
        LDRB r3,[r0]        ; load the search key to obtain the lowest value
        LDRB r1,[r0,r2]      ;load the search key of the middle in r1
        SUB r2,r2,LSR #1    ; value of r2,r2-r2/2
        SUB r2,r2,#1        ; minus value of r2-1
        CMP r3,r1             ;compare r3 with r1
        BEQ DecMin            ; if equal, proceed to place value in
        BLT LEFT             ; if less than, proceed to repeat loop until obtain the smallest value in the array
        
DecMin    STRB r1,min

        MOV r2,#9            ;Move the 9 into r2 that use to declare to place first middle array at position 10 of the array
        
RIGHT    
    
        LDRB r3,[r0,#19]    ; load the search key to obtain the highest value
        LDRB r1,[r0,r2]      ;load the search key of the middle into r1
        ADD r2,r2,LSR #1    ; value of r2+r2/2
        CMP r3,r1              ; compare r3 with r1
        BEQ DecMax            ; if equal,proceed to place value in
        BGT RIGHT             ; if more than,proceed to repeat loop until obtain greatest value in array
        
DecMax    STRB r1,max

stop B stop

ARRAY   DCB 21, 02, 34, 54, 33, 22, 11, 09, 98, 67, 59, 89, 50, 60, 77, 71, 37, 44, 47, 93
max        DCB 0 ; space to store max result
min        DCB 0 ; space to store min result


        END