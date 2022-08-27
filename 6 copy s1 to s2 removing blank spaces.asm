.model small
.stack 100h
.data
s1 db 80 dup(0)
s2 db 80 dup("$")

size dw 0

.code

main proc
    mov ax,@data
    mov ds,ax
    mov es,ax
    
    call read
    call copy
    
    mov ah,2
    mov dl,0dh
    int 21h
    mov dl,0ah
    int 21h
    
    lea dx,s2
    mov ah,9
    int 21h 
    
    end_:
        mov ah,4ch
        int 21h
    
    main endp
read proc 
   push ax
    push di
    mov bx,0
    ;
    ; 
    lea di,s1
    cld
    mov ah,1
    read_loop:
       
        int 21h
        
        cmp al,0dh
        je read_end
        stosb
        inc bx
        jmp read_loop
    ;
    ;
    read_end:
        pop di
        pop ax
        ret    
    read endp
copy proc 
    mov cx,bx
    lea di,s2
    lea si,s1
    loop1:
        cmp [si],' '
        je skip
        movsb
        loop loop1
        jmp ret_
    skip:
        inc si
        loop loop1    
    ret_:
        ret
    copy endp 
end main
