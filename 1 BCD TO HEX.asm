.model small
.stack 100h
.data
msg db "Input a 4bit bcd: $"
.code
main proc 
    mov ax,@data
    mov ds,ax
            
    call binary_input
    mov ax,000fh
    and ax,bx
    cmp ax,9
    jle output1
    jmp output2
    output1:
        push ax
        mov ah,2
        mov dl,0dh
        int 21h
        mov dl,0ah
        int 21h
        pop ax
        mov dx,ax
        add dx,48
        mov ah,2
        int 21h
        jmp main_end
    output2:
        push ax
        mov ah,2
        mov dl,0dh
        int 21h
        mov dl,0ah
        int 21h
        pop ax
        mov dx,ax
        add dx,55
        mov ah,2
        int 21h    
    main_end:
        mov ah,4ch
        int 21h    
    main endp
binary_input proc    
    xor bx,bx
    mov ah,9
    lea dx,msg
    int 21h
    mov ah,1
    while:
        int 21h
        cmp al,0dh
        je end_
        and al,0fh
        shl bx,1
        or bl,al
        jmp while
    end_:
        ret
    binary_input endp
end main
