;sum of series:100+90+80....+10

include 'emu8086.inc'
.model small
.stack 100h


.data
  msg db 'the sum of the series:$'
  


.code


main proc
    
 mov ax,@data
 mov ds,ax
 
mov dx,0
mov cx,10
mov ax,1

loop1:
add dx,ax
ADD ax,1
loop loop1

printn

push dx

mov ah,9
lea dx,msg
int 21h 

pop dx

mov ax,dx
call OUTDEC


    
exit:
mov ah,4ch
int 21h 

 OUTDEC PROC
END_IF1:
XOR CX,CX
MOV BX,10D
REPEAT1:
XOR DX,DX
DIV BX
PUSH DX
INC CX
CMP AX,0
JNE REPEAT1
MOV AH,2
PRINT_LOOP:
POP DX
OR DL,30H
INT 21H
LOOP PRINT_LOOP
RET
OUTDEC ENDP   
    
    
end main    