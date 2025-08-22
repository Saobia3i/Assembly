.MODEL SMALL
.STACK 100H
.DATA
include 'emu8086.inc'

MSG1 DB "ENTER AN ALPHABET: $"
A DB "THIS IS VOEWL.$"
B DB " THIS IS CONSONENT.$"

.CODE
MAIN PROC
      MOV AX,@DATA
      MOV DS,AX
      
      
      MOV AH,9 
      LEA DX,MSG1
      INT 21H


      mov ah,1
      int 21h
       
      cmp al,'A'
      je vwl
      
      cmp al,'E'
      je vwl
      
      cmp al,'I'
      je vwl
      
      cmp al,'O'
      je vwl
      
      cmp al,'U'
      je vwl
         
         
      cmp al,'a'
      je vwl
      
      cmp al,'e'
      je vwl
      
      cmp al,'i'
      je vwl
      
      cmp al,'o'
      je vwl
      
      cmp al,"u"
      je vwl
           
  
       mov ah,9
       lea dx,B
       int 21h
       jmp EXIT
       
       vwl:
       mov ah,9
       lea dx,A  
       int 21h 
       
       JMP EXIT
         
      
         
     
  
 EXIT: 
  MOV AH,4CH
  INT 21H
  MAIN ENDP
END MAIN