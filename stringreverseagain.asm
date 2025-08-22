.model small
.stack 100h

.data
  msg1 db 'Enter a string:$'
  msg2 db 0Dh, 0Ah, 'The reversed string is:$'

.code

main proc
  ; Initialize data segment
  mov ax, @data
  mov ds, ax

  ; Display prompt message 1: 'Enter a string:'
  mov ah, 9
  lea dx, msg1
  int 21h

  ; Input string character by character
  xor cx, cx          ; Clear CX (to count the number of characters)
  xor si, si          ; Clear SI (to use for indexing)
  
input_loop:
  mov ah, 1           ; Read a character
  int 21h
  cmp al, 13          ; Check if 'Enter' (carriage return) is pressed
  je reverse_string   ; If yes, jump to reverse string

  push ax             ; Push character on stack (to reverse later)
  inc cx              ; Increment the character count
  jmp input_loop      ; Repeat the loop

reverse_string:
  ; Print prompt message 2: 'The reversed string is:'
  mov ah, 9
  lea dx, msg2
  int 21h
  
reverse_loop:
  pop dx              ; Pop characters from stack (LIFO order)
  mov ah, 2           ; Print the character in DL
  int 21h
  loop reverse_loop   ; Repeat until CX (character count) reaches 0

  ; Exit the program
  mov ah, 4Ch         ; Exit to DOS
  int 21h
main endp
end main
