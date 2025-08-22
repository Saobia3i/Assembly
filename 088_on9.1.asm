include 'emu8086.inc'
.model small
.stack 100h

.data
        n dw 1
        msg1 db 'Multiplication Table of 1 TO 5:', 0Dh, 0Ah, '$'

.code

main proc
    
   mov ax,@data
   mov ds,ax

   lea dx,msg1
   mov ah,09h
   int 21h
   
   mov cx, 5   
   mov n, 1    

LOOP_START:
   mov ax, 1   
   mov bx, n   
   
   MUL BX      

   call PRINT_RESULT

   inc n       
   loop LOOP_START  

exit:
   mov ah,4ch
   int 21h 

     

PRINT_RESULT PROC
   mov dl, '1'
   mov ah, 2
   int 21h

   mov dl, '*'
   int 21h  
   

   call OUTDEC_N  

   mov dl, '='
   int 21h

   call OUTDEC    
            
            
            
   printn ''
   ret
PRINT_RESULT ENDP


OUTDEC_N proc
   push ax
   push bx
   push cx
   push dx

   mov ax, n  

   call OUTDEC

   pop dx
   pop cx
   pop bx
   pop ax
   ret
OUTDEC_N endp


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
