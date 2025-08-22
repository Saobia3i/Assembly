INCLUDE 'EMU8086.INC'
.model small
.STACK 100H
.data

.code
main proc
    
    PRINTN "ENTER: "
    MOV AH,1
    
    XOR CX,CX ;COUNTER VAR
    
    
    INPUT:
        INT 21H
        CMP AL,0DH
        JE EXIT_INPUT
        PUSH AX
        INC CX
      JMP INPUT
      
      EXIT_INPUT:
      
      PRINTN
      PRINT "OUTPUT: "
      MOV AH,2
      
      OUTPUT:
      POP DX
      INT 21H
      LOOP OUTPUT
      
 
  MOV AH,4CH
  INT 21H
  MAIN ENDP
END MAIN