.model small
.stack 100h

.data

msg1 db 'enter a character in lower form:$'
msg2 db 10,13,'the character in upper form:$'


.code

main proc
    
mov ax,@data
mov ds,ax

mov ah,9
lea dx,msg1
int 21h

mov ah,1
int 21h

mov bl,al
;sub bl,32 for lower to upper
sub bl,32   

mov ah,9
lea dx,msg2
int 21h    
    
mov ah,2    
mov dl,bl
;add dl,48
int 21h    
    
    
end main    