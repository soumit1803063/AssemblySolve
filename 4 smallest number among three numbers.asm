;display the smallest number among three decimal numbers
.model small 
.stack 100h
.data
ng dw 0
var1 dw ?
var2 dw ?  
.code

main proc
    mov ax,@data
    mov ds,ax
    
    call dec_input
    mov var1,ax
    call nextline
    call dec_input
    mov var2,ax
    call nextline
    call dec_input
    call nextline
    
    cmp ax,var1
    jg xchange1
    cmp ax,var2
    jg xchange2
    jmp output
    xchange1:
        mov ax,var1
        cmp ax,var2
        jg xchange2
        jmp output
    xchange2:
        mov ax,var2
    output:
        call dec_output    
    end_:
    mov ah,4ch
    int 21h 
    main endp
nextline proc
    push ax
    push dx
    mov ah,2
    mov dl,0dh
    int 21h
    mov dl,0ah
    int 21h
    pop dx
    pop ax
    ret
    nextline endp
dec_output proc

PUSH AX 
 PUSH BX 
 PUSH CX 
 PUSH DX 
 OR AX,AX 
 JGE @END_IF1 
 
PUSH AX 
 MOV DL,'-' 
 MOV AH,2 
 INT 21H 
 
POP AX 
 NEG AX 
@END_IF1: 
 XOR CX,CX 
 MOV BX,10D 
@REPEAT1: 
 XOR DX,DX 
 DIV BX 
 PUSH DX 
 INC CX 
OR AX,AX 
 JNE @REPEAT1 
 
MOV AH,2 
@PRINT_LOOP: 
 POP DX 
 OR DL,30H 
 INT 21H 
 
LOOP @PRINT_LOOP 
POP DX 
POP CX 
POP BX 
POP AX 
RET 

    dec_output endp
    
dec_input proc
    PUSH BX 
 PUSH CX 
 PUSH DX 
;print prompt 
@BEGIN:  
 XOR BX,BX ;BX hold total 
;negative =false 
 XOR CX,CX ;CX hold sign 
;read char. 
 MOV AH,1 
 INT 21H 
;case char. of 
 CMP AL,'-' ;minus sign 
 JE @MINUS ;yes,set sign 
 CMP AL,'+' ;plus sign 
 JE @PLUS ;yes,get another char.
 JMP @REPEAT2 ;start processing char. 
@MINUS: MOV CX,1 

@PLUS: INT 21H 
;end case 
@REPEAT2: 
;if char. is between '0' and '9' 
 CMP AL,'0' ;char >='0'? 
 JNGE @NOT_DIGIT ;illegal char. 
 CMP AL,'9' ;char<='9' ? 
 JNLE @NOT_DIGIT 
;then convert char to digit 
 AND AX,000FH 
 PUSH AX 
;total =total *10 +digit 
 MOV AX,10 
 MUL BX 
;---------------------------- 
CMP DX,0 
JNE @NOT_DIGIT 
;-------------------------- 
 POP BX 
 ADD BX,AX 
;------------------------- 
JC @NOT_DIGIT 
;-------------------- 
;read char 
 MOV AH,1 
 INT 21H 
 CMP AL,0DH ;CR 
 JNE @REPEAT2 
;until CR 
 MOV AX,BX 
;if negative 
 OR CX,CX 

JE @EXIT
 NEG AX 
;end if 
@EXIT: POP DX 
 POP CX 
 POP BX 
 RET 
;here if illegal char entered 
@NOT_DIGIT: 
 MOV AH,2 
 MOV DL,0DH 
 INT 21H 
 MOV DL,0AH 
 INT 21H 
 JMP @BEGIN 
    dec_input endp
end main