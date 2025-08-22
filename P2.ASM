.MODEL SMALL
.STACK 100H
.DATA

NUM1 DB 49 
CHAR DB 'A'
MSG DB " MY NAME IS TINNI $"




.CODE
MAIN PROC
    MOV AX,@DATA
    MOV DS,AX
    
    
    MOV AH,2
    MOV DL,NUM1
    INT 21H   
       
       
   
   MOV DL,0AH
   INT 21H
   MOV DL,0DH
   INT 21H
       
   MOV AH,9
   LEA DX,MSG
   INT 21H    
       
       
   MOV AH,2
   MOV DL,CHAR
   INT 21H    
       
       
       
       
       
       
     MOV AH,4CH
     INT 21H
     
     
    MAIN ENDP
END MAIN