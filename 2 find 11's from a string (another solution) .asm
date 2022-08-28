.model small
.stack 100h
.data 
.code
main proc
    call binIn
    
    mov bx,0
    mov cx,8
        main_loop:
            test al,10000000b; test mane AND. but ekhane destination change hoy na; check korlam msb 1 kina           
            jnz next_check
            shl al,1
            loop main_loop
            jmp output
            next_check:
               test al,01000000b; check korlam msb er pasher bit ta 1 kina           
               jnz increment
               shl al,1     
               loop main_loop
               jmp output
               
               increment: 
                    inc bl
                    shl al,1     
                    loop main_loop
        output:
               call nextLn
               mov ah,2
               mov dl,bl
               add dl,48
               int 21h      
                    
                
        main_end:
            mov ah,4ch ; ekta kotha: hex number always 0 to 9 er moddhye kichu ekta diye start korte hoy.
            int 21h       
                 
        
    main endp
binIn proc    
    ;backup
    push bx
    ;
    mov bx,0
    
    mov ah,1
    binIN_loop:  ;8 bit er beshi input newa jabe na
        int 21h
        cmp al,0dh; check kore dekhlam,'enter' press korechi naki. enter press korle input newa done.
        je binIn_end
        and al,0fh; ascii to number kore nilam
        shl bx,1
        or bl,al
        jmp binIN_loop        
     
    ;     
    binIn_end:
        mov al,bl
        pop bx
        ret
    binIn endp
nextLn proc
    ;backup    
    push ax
    push dx
    ;
    ;
    mov ah,2
    mov dl,0dh
    int 21h
    mov dl,0ah
    int 21h
    ;
    ;
    nextLn_end:
        pop dx
        pop ax
        ret
    
    nextLn endp
end main