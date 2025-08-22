include 'emu8086.inc'
.model small
.stack 100h

.data
        n dw ?             
        msg1 db 'Multiplication from 1 to 5: $'

.code

main proc
    
   mov ax,@data
   mov ds,ax

   lea dx,msg1
   mov ah,09h
   int 21h
   call INDEC       

   mov ax,n         
   mov cx,n
   dec cx
   
   call FACTORIAL

exit:
   mov ah,4ch
   int 21h 
   
   
   
FACTORIAL PROC 

MULTIPLY:
   dec n
   mul n
   dec cx
   jnz MULTIPLY
   
   printn ''
   call OUTDEC   

FACTORIAL ENDP
    
     
     
     
     
INDEC proc
   push bx
   push cx
   push dx
   xor bx, bx
   xor cx, cx
   mov ah,1
   int 21h
   cmp al, '-'
   je minus
   cmp al, '+'
   je plus
   jmp repeat
minus:
   mov cx, 1
plus:
   int 21h
repeat:
   cmp al, '0'
   jnge not_digit
   cmp al, '9'
   jnle not_digit
   and ax, 0x0F
   push ax
   mov ax, 10
   mul bx
   pop bx
   add bx, ax
   mov ah, 1
   int 21h
   cmp al, 0Dh
   jne repeat
   mov ax, bx        
   mov n, ax        
   or cx, cx
   je exit_in
   neg ax
exit_in:
   pop dx
   pop cx
   pop bx
   ret
not_digit:
   mov ah, 2
   mov dl, 0Dh
   int 21h
   mov dl, 0Ah
   int 21h
   jmp repeat
INDEC endp
             
             
             
                         
OUTDEC proc
   push ax
   push bx
   push cx
   push dx
   or ax, ax
   jge end_if
   push ax
   mov dl, '-'
   mov ah, 2
   int 21h
   pop ax
   neg ax
end_if:
   xor cx, cx
   mov bx, 10
repeat_out:
   xor dx, dx
   div bx
   push dx
   inc cx
   or ax, ax
   jnz repeat_out
   mov ah, 2
print_loop:
   pop dx
   or dl, 30h
   int 21h
   loop print_loop
   pop dx
   pop cx
   pop bx
   pop ax
   ret
OUTDEC endp

end main


