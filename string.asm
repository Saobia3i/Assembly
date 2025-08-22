.MODEL SMALL
.STACK 100H
.DATA
STRING DB 80 DUP (0)
VOWELS DB 'AEIOU'
CONSONANTS DB 'BCDFGHJKLMNPQRSTVWXYZ'
OUT1 DB 0DH,0AH,'vowels=$'
OUT2 DB ',consonants=$'
VOWELCT DW 0
CONSCT DW 0
MAIN PROC
    MOV AX,@DATA
    MOV DS,AX
    MOV ES,AX
    LEA DI,STRING
    CALL READ_STR
    MOV SI,DI
    CLD 
    REPEAT:
    ;load a string character
    LODSB
    ;if it's a vowel
    LEA DI,VOWELS
    MOV CX,5
    REPNE SCASB
    JNE CK_CONST
    ;then increment vowel count
    INC VOWELCT
    JMP UNTIL
    ;else if it's a consonant
    CK_CONST:
    LEA DI,CONSONANTS 
    MOV CX,21
    REPNE SCASB
    JNE UNTIL
    ;then increment consonant count
    INC CONSCT
    UNTIL:
    DEC BX
    JNE REPEAT
    ;output no. of vowels
    MOV AH,9 
    LEA DX,OUT1
    INT 21H
    MOV AX,VOWELCT
    CALL OUTDEC
    ;output no. of consonants
    MOV AH,9
    LEA DX,OUT2
    INT 21H
    MOV AX,CONSCT
    CALL OUTDEC 
    ;dos exit
    MOV AH,4CH
    INT 21H
    MAIN ENDP
;INCLUDE PGM11_1.ASM
;INCLUDE PGM9_1.ASM

READ_STR PROC NEAR
    ;Reads and stores a string
    ;input:DI offset of string
    ;output:DI offset of string
    ;BX number of characters read
    PUSH AX
    PUSH DI
    CLD
    XOR BX,BX
    MOV AH,1
    INT 21H
    WHILE1:
    CMP AL,0DH
    JE END_WHILE1
    ;if character is backspace
    CMP AL,8H
    JNE ELSE1
    ;then
    DEC DI
    DEC BX
    JMP READ
    ELSE1:
    STOSB
    INC BX
    READ:
    INT 21H
    JMP WHILE1
    END_WHILE1:
    POP DI
    POP AX
    RET
    READ_STR ENDP 


OUTDEC PROC
    ;prints AX as a signed decimal integer
    ;input: AX 
    ;output: none
    PUSH AX
    PUSH BX
    PUSH CX
    PUSH DX
    ;if AX<0
    OR AX,AX
    JGE END_IF1
    ;then
    PUSH AX
    MOV DL,'-'
    MOV AH,2
    INT 21H
    POP AX
    NEG AX
    END_IF1:
    ;get decimal digits
    XOR CX,CX
    MOV BX,10D
    REPEAT1:
    XOR DX,DX
    DIV BX 
    PUSH DX
    INC CX
    ;until
    OR AX,AX
    JNE REPEAT1
    ;convert digits to characters and print
    MOV AH,2
    ;for count times do
    PRINT_LOOP: 
    POP DX
    OR DL,30H 
    INT 21H
    LOOP PRINT_LOOP
    ;end_for
    POP DX 
    POP CX
    POP BX
    POP AX
    RET
    OUTDEC ENDP 
END MAIN 

