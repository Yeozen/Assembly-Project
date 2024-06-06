	AREA heapsort, CODE, READONLY ;directive for assembler
	ENTRY ;entry point for program
	;set memory map to range 0x000000BC, 0X000000C6, read/write/execute before running.
	ADR R0, ARRAY
	MOV R1, #0 ;variable n
	MOV R2, #1 ;variable to hold the value 1
	MOV R3, #2 ;variable to hold the value 2
	MOV R10, #10 ;counter that decreases to keep track of the shrinking array 
	

LOOP
	LDRB R4, [R0, R1] ;load nth element into r4
	MLA R5, R3, R1, R2 ;does the operation 2n+1 (yes i could not find any other way, im so sorry)
	CMP R5, R10 ;compares the array size with what element is going to be accessed
	BLGE ADD2 ;if the element being accessed is greater than or equal to current array size, skip straight to ADD2
	LDRB R6, [R0, R5] ;if not, proceed to load into r6 
	CMP R4, R6 ;compare and swap if r4 less than r6
	BLLT SWAP
	MLA R7, R3, R1, R3 ;same thing but with 2n+2
	CMP R7, R10 ;same as above but checking for the element right after 2n+1
	BLGE ADD2
	LDRB R8, [R0, R7]
	CMP R4, R8
	BLLT SWAP2
	B ADD ;branch to add no matter what, maybe redundant as ASS is akready underneath
	
ADD	
	ADD R1, R1, #1 ;updates loop counter
	CMP R1, #5 ;only needs to go up to 5 as the rest of the elements will be accessed by n = 5
	BNE LOOP ;continue to iterate through the array if loop counter != 5
	B ADD2
	
ADD2
	SUB R10, #1 ;LITERALLY THE SAME AS ADD but without having the beginning loop that forces the program to keep going further into the array when it shouldn't
	MOV R1, #0
	LDRB R9, [R0, R10]
	LDRB R6, [R0, #0]
	MOV R5, R9
	MOV R9, R6
	MOV R6, R5
	STRB R9, [R0, R10]
	STRB R6, [R0, #0]
	CMP R10, #0
	BNE LOOP

STOP B STOP

SWAP
	MOV R7, R4 ;use temp register to hold value of r4
	MOV R4, R6 ;replace value in r4 with r6
	MOV R6, R7 ;replace value in r6 with r7
	STRB R4, [R0, R1] ;store swapped value back in memory
	STRB R6, [R0, R5] 
	BX LR ;dont change this is mov pc, lr the compiler dont like
	
SWAP2
	MOV R5, R4
	MOV R4, R8
	MOV R8, R5
	STRB R4, [R0, R1]
	STRB R8, [R0, R7]
	BX LR


ARRAY

	DCB 82, 22, 95, 90, 10, 12, 15, 77, 55, 23
	