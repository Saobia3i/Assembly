 .model small
 .stack 100h
 
 .data
 
 
 msg1 db 10,13,'enter the string:','$'
 msg2 db 10,13,'the reversed string:','$'
 text db 100 dup('$')
 
 
 
 .code
 
 
 main proc
    
  mov ax,@data
  mov ds,ax
  
  mov ah,9
  lea dx,msg1
  int 21h
    
   xor cx,cx
   
  lea si,text
  mov ah,1
  
  while:
  mov ah,1
  int 21h
  cmp al,13
  je end_while
  
  cmp al,' '
  je store
  
  push ax
  inc cx
  
  jmp while
  
   store:
  
  looper:
  pop ax
  
  mov [si],al
  inc si
  loop looper
  
  mov [si],' ' 
  inc si
  jmp while
  
  end_while:
  looper2:
  pop ax
  mov [si],al
  inc si
  loop looper2
  mov ah,9
  lea dx,msg2
  int 21h
  mov ah,9
  lea dx,text
  int 21h
  
  exit:
  mov ah,4ch
  int 21h  
    
    
    
    
    
 end main   