 .MODEL SMALL
.STACK 100H
.DATA
MSG1 DB "Enter 1st integer: $"
MSG2 DB 0AH,0DH,"Enter 2nd integer: $"
MSG3 DB 0AH,0DH,"The GCD is: $"
.CODE
MAIN PROC
    
   MOV AX,@DATA
   MOV DS,AX
   
   TOP:
   MOV AH,9
   LEA DX,MSG1
   INT 21H
   
   CALL INDEC
   
   MOV CX,AX
   
   MOV AH,9
   LEA DX,MSG2
   INT 21H
    
   CALL INDEC
    
   MOV BX,AX
    
    
   MOV AH,9
   LEA DX,MSG3
   INT 21H
   
   MOV AX,CX
   
   LABEL:
   XOR DX,DX
   DIV BX
   CMP DX,0
   JE PRINT
   MOV AX,BX
   MOV BX,DX
   JMP LABEL
   
   PRINT:
   MOV AX,BX
   CALL OUTDEC 
    
    
   MOV AH,4CH
   INT 21H     
    
   MAIN ENDP

INDEC PROC
   
    PUSH BX
    
    BEGIN:
   
    XOR BX,BX
    
    MOV AH,1
    
    INT 21H
    
    REPEAT2:
    
    CMP AL,'0'
    JNGE NOT_DIGIT
    CMP AL,'9'
    JNLE NOT_DIGIT
    
    AND  AX,000FH
    PUSH AX
    
    MOV AX,10
    MUL BX
    POP BX
    ADD BX,AX
    
    MOV AH,1 
    INT 21H
    CMP AL,0DH
    JNE REPEAT2
    
    MOV AX,BX
    
    EXIT:
    POP BX
    RET
    
    NOT_DIGIT:
    MOV AH,2
    MOV DL,0DH
    INT 21H
    MOV DL,0AH
    INT 21H
    JMP BEGIN
    INDEC ENDP

OUTDEC PROC
    
    PUSH AX
    PUSH BX
    PUSH CX
    PUSH DX
    
    XOR CX,CX
    MOV BX,10D
    REPEAT1:
    XOR DX,DX
    DIV BX 
    PUSH DX
    INC CX
    OR AX,AX
    JNE REPEAT1
    
    MOV AH,2
   
    PRINT_LOOP: 
    POP DX
    OR DL,30H 
    INT 21H
    LOOP PRINT_LOOP
    
    POP DX 
    POP CX
    POP BX
    POP AX
    RET
    OUTDEC ENDP 


    
END MAIN