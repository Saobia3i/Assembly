.MODEL SMALL
.STACK 100H
.DATA              

PROMPT_MSG    DB 'ENTER A HEX NUMBER NOT MORE THAN 4 DIGIT: $'
BINARY_MSG    DB 0DH,0AH,'BINARY FORM : $'
ERROR_MSG     DB 0DH,0AH,'INVALID HEX NUMBER, TRY AGAIN: $'
USER_INPUT    DB ?

.CODE
MAIN PROC     

    MOV AX,@DATA
    MOV DS,AX
 
    MOV AH,9
    LEA DX,PROMPT_MSG              
    INT 21H
    
    XOR BX,BX         
    MOV USER_INPUT,30H          
    JMP INPUT_LOOP               

RETRY: 

    LEA DX, ERROR_MSG            
    MOV AH, 9
    INT 21H
                          
    XOR BX,BX                ; reset BX
    MOV USER_INPUT,30H       ; reset USER_INPUT

INPUT_LOOP:                   
    MOV AH,1                 
    INT 21H                   
    
    CMP AL,0DH               ; check if enter/carriage return
    JNE NEXT_CHAR            ; jump if AL!=ENTER
    
    CMP USER_INPUT,30H       ; check user input
    JBE RETRY                ; retry if input is empty
    
    JMP PRINT_BINARY 
    
NEXT_CHAR:                         
    CMP AL,"A"
    JB CHECK_DECIMAL         ; if AL<"A" go to decimal check
    
    CMP AL,"F"
    JA RETRY                 ; if AL>"F" retry input   
    
    ADD AL,09H               ; convert ascii hex to original hex in lower 4 bits
    JMP CONVERT_TO_BINARY                   
    
CHECK_DECIMAL:                   
    CMP AL,30H              
    JB RETRY                 ; retry if AL<"0"
    
    CMP AL,39H              
    JA RETRY                 ; retry if AL>"9"
    
CONVERT_TO_BINARY:                            
    INC USER_INPUT           ; increment user input count
    AND AL,0FH               ; isolate lower 4 bits
    
    MOV CL,4                 ; set shift count to 4
    SHL AL,CL                ; shift left by 4 bits
    
    MOV CX,4                 ; loop count set to 4    
LOOP_BINARY:                    
    SHL AL,1                 ; shift left by 1 bit
    RCL BX,1                 ; rotate carry left, store in BX
    LOOP LOOP_BINARY
    
    CMP USER_INPUT,34H       ; check if 4 digits entered
    JE PRINT_BINARY          ; proceed to print binary if 4 digits entered
    JMP INPUT_LOOP           ; continue input if not

PRINT_BINARY:
    LEA DX,BINARY_MSG        
    MOV AH,9                    
    INT 21H
    
    MOV CX,16                ; loop count for printing binary
    MOV AH,2                   

PRINT_BITS:                     
    SHL BX,1                 ; shift left by 1 bit
    JC PRINT_ONE             ; if carry flag is set, print 1
    MOV DL,30H               ; else, print 0
    JMP DISPLAY_BIT             
    
PRINT_ONE:                       
    MOV DL,31H                     
    
DISPLAY_BIT:                   
    INT 21H
    LOOP PRINT_BITS
        
EXIT:
    MOV AH,4CH
    INT 21H
    MAIN ENDP
END MAIN
