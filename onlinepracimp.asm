                   .model small
.stack 100h

.data
    prompt db 'Enter a decimal number:$'
    result_msg db 0Dh, 0Ah, 'Result in BX register: $'
    newline db 0Dh, 0Ah, '$'
    num db 0
    count_1s dw 0
    count_0s dw 0

.code

main proc
    mov ax, @data
    mov ds, ax

    ; Prompt the user for input
    mov ah, 9
    lea dx, prompt
    int 21h

    ; Read the input character
    mov ah, 1
    int 21h
    sub al, '0'     ; Convert ASCII to integer
    mov num, al

    ; Convert the number to binary and set even positions to 1
    mov al, num
    xor cx, cx      ; Clear CX, will count the bits

    ; Clear BX to use it for the result
    xor bx, bx
    xor dx, dx      ; DX will hold the modified binary

convert_and_set_bits:
    test al, 1
    jz set_even_bit
    or dx, 1        ; Set the lowest bit in DX if it's 1 in the original number

set_even_bit:
    test cx, 1
    jnz skip_even
    or dx, 1        ; Ensure even positions are set to 1

skip_even:
    shr al, 1
    shl dx, 1
    inc cx
    cmp cx, 8
    jl convert_and_set_bits

    ; Count the number of 0s and 1s in the modified binary number
    mov cx, dx
    xor bx, bx      ; BX will count the 1s
    xor si, si      ; SI will count the 0s

count_bits:
    test cx, 1
    jz count_zero
    inc bx          ; Increment the count of 1s
    jmp next_bit

count_zero:
    inc si          ; Increment the count of 0s

next_bit:
    shr cx, 1
    test cx, cx
    jnz count_bits

    ; Multiply the count of 1s by 8
    shl bx, 3

    ; Display the result message
    mov ah, 9
    lea dx, result_msg
    int 21h

    ; Convert BX to decimal and print it
    mov ax, bx
    call print_number

    ; Terminate the program
    mov ah, 4Ch
    int 21h

main endp

; Routine to print a number in AX
print_number proc
    push ax
    push bx
    push cx
    push dx

    xor cx, cx
    mov bx, 10

print_loop:
    xor dx, dx
    div bx
    push dx
    inc cx
    test ax, ax
    jnz print_loop

print_digits:
    pop dx
    add dl, '0'
    mov ah, 2
    int 21h
    loop print_digits

    pop dx
    pop cx
    pop bx
    pop ax
    ret
print_number endp

end main
