.MODEL SMALL
.STACK 100H 
.DATA

MSG1 DB 10,13,'LOOP COUNT$'
MSG2 DB 10,13,'SHOWED YAY$'

.CODE
MAIN PROC
    MOV AX,@DATA
    MOV DS,AX
    
    
    MOV AH,9 
    LEA DX,MSG1
    INT 21H
           
    MOV AH,1
    INT 21H           
               
               
  EXIT:
  MOV AH,4CH
  INT 21H
  
  MAIN ENDP
END MAIN


