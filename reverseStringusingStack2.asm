include 'emu8086.inc'

.model small
.stack 100h

.data

   string db 'Saobia'
   
.code



main proc
    
   mov ax,@ data
   mov ds,ax
   
   mov si,offset string
   
   mov cx,10
   loopx:
   mov bx,[si]
   push bx
   inc si      
   loop loopx  
   
   mov cx,10  
   
   printn 'The Reversed String is:'
   
   loop2:
   pop dx
   mov ah,2
   int 21h
   loop loop2 
    
    
   exit:
   mov ah,4ch
   int 21h 
    
    
  end main  