.model small
.stack 100h
.code
main proc
    mov bx,5
   
    loop1:
        mov cx,5
        loop2:
            mov ah,2
            mov dl,'*'
            int 21h
        loop loop2 
        mov ah,2
        mov dl,0dh
        int 21h
        mov dl,0ah
        int 21h
        dec bx
        jz end_:
        jmp loop1
    end_:
        mov ah,4ch
        int 21h    
    main endp
end main