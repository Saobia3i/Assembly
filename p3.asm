 INCLUDE 'EMU8086.INC'
.MODEL SMALL
.stack 100h
.data
; 1+2+ 3+...+N=?
N db ?
sum db 0
.code
MAIN PROC
    mov ax,@data
    mov ds,ax
    
    PRINT "Enter N:"
    mov ah,1
    int 21h
    
    mov N,al
     add AL,48
     
    printn
    
    mov bl,1
    
    TOP:
    cmp bl,N
    jge exit
    add sum,bl
    inc bl
    jmp TOP
    
    exit:
    printn "the sum is : "
    
    mov ah,2
    mov dl,sum
    int 21h


    mov ah,4ch
    int 21h
    
    main endp
end main