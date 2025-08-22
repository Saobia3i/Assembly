.model small
.stack 100h


.data
msg1 db 10,13,'enter a string:$'
msg2 db 10,13, 'the number of characters in the string:$'
count dw ?


.code



main proc
    
    
    mov ax,@data
    mov ds,ax
    
    mov ah,9
    lea dx,msg1
    int 21h
    mov count,0
    
    mov ah,1
   loopx:
   mov ah,1
   int 21h
   cmp al,13
   je next
   
   inc count
   
   loop loopx
    
    next:
     mov ah,9
    lea dx,msg2
    int 21h
    
    
    mov ax,count
    
     call OUTDEC
    
    
exit:
mov ah,4ch
int 21h

OUTDEC PROC
    ;prints AX as a signed decimal integer
    ;input: AX 
    ;output: none 
    
    ;saving values of AX-DX as they will be changed during operations
    PUSH AX
    PUSH BX
    PUSH CX
    PUSH DX
    ;if AX<0 [i.e. negative number]
    OR AX,AX    
    JGE END_IF1
    ;then
    PUSH AX  ;to conserve the value of AX
    MOV DL,'-'
    MOV AH,2
    INT 21H
    POP AX   ;to restore the value of AX
    NEG AX   ;to get absolute value  -(-AX) = AX
    
    
    END_IF1:
    ;get decimal digits
    XOR CX,CX
    MOV BX,10D
    REPEAT1:
    XOR DX,DX
    DIV BX   ;AX/10
    PUSH DX  ;remainder (i.e. digit in LSB position)
    INC CX   ;to keep count of number of digits
    
    ;until value becomes 0
    OR AX,AX
    JNE REPEAT1
    
    
    ;convert digits to characters and print
    MOV AH,2
    ;for count times do
    PRINT_LOOP: 
    POP DX   
    OR DL,30H 
    INT 21H
    LOOP PRINT_LOOP
    ;end_for
    
    ;restoring values of AX-DX
    POP DX 
    POP CX
    POP BX
    POP AX
    
    RET
    OUTDEC ENDP     
    
    
 end main   