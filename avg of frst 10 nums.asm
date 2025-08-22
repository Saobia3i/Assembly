.model small
.stack 100h


.data
 arr db 0,1,2,3,4,5,6,7,8,9
 size db 10
 sum dw 0
 

.code


main proc
   mov ax,@data
   mov ds,ax
  
  
  mov si,offset arr
  
  mov cx,10
  mov sum,0
  mov ax,0
  
  loop1:
  mov bl,[si]
  add ax,bx
  inc si
  loop loop1
  
  mov sum,ax
   
   
   mov ah,2
   mov dl,al
   add dl,48
   int 21h
   
  
  mov ax,sum
  
  
  mov bl,size
  div bl  
  
  add al,48
  
  
   mov ah,2
  mov dl,al
 
  int 21h  
    
    
    
    
    
    
end main    