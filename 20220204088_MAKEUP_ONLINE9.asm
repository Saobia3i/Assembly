include 'emu8086.inc'
.model small
.stack 100h

.data
    n dw 1
    newline db 0Dh, 0Ah, '$'

.code

main proc
    mov ax, @data
    mov ds, ax

    mov cx, 5  
    mov n, 1   
LOOPX:
    mov ax, 1 
    mov bx, n   
    mul bx 
    
     

    call OUTDEC  

    lea dx, newline
    mov ah, 09h     
    INT 21H

   INC N
   LOOP LOOPX

exit:
    mov ah, 4Ch
    int 21h   
    
    

     
        

OUTDEC PROC
    push ax
    push bx
    push cx
    push dx
    xor cx, cx
    mov bx, 10
convert_loop:
    xor dx, dx
    div bx
    push dx
    inc cx
    cmp ax, 0
    jne convert_loop
print_loop:
    pop dx
    add dl, '0'
    mov ah, 2
    int 21h
    loop print_loop
    pop dx
    pop cx
    pop bx
    pop ax
    ret
OUTDEC ENDP

end main
