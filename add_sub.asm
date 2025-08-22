.MODEL SMALL
.STACK 100H
.DATA

NUM1 DB ?
NUM2 DB ? 


.CODE
MAIN PROC
 MOV AX,@DATA
 MOV DS,AX
 
   MOV AH,1
   INT 21H
   
   MOV NUM1,AL
   SUB NUM1,48
   INT 21H
           
           
           
   MOV AH,1
   INT 21H
   
   MOV NUM2,AL
   SUB NUM2,48
   INT 21H
   
    MOV BH,NUM1
    ADD BH,NUM2
    ADD BH,48
     
   MOV AH,2
   MOV DL,0AH
   INT 21H
   MOV DL,0DH
   INT 21H
   

   
   MOV AH,2
   MOV DL,BH
   INT 21H 
   
   
   MOV AH,4CH
   INT 21H
   MAIN ENDP
END MAIN