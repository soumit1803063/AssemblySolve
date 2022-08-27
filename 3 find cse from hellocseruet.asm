.model small
.stack 100h
.data
input_st db "hellocseruet"
sub_st db "cse"
msg db "found at position: $"

start dw ?
stop dw ?
ans dw ?
input_st_size dw 12
sub_st_size dw 3
.code
main proc
    mov ax,@data
    mov ds,ax
    mov es,ax
    

    
    call search
    output:
        lea dx,msg
        mov ah,9
        int 21h
        mov ah,2  
        mov dx,ans
        add dx,48
        int 21h
     main_end:
        mov ah,4ch
        int 21h   
    main endp 
search proc    
    push si
    push di
    push ax
    push bx
    ;
    ;
    
    lea di,input_st
    
    mov start,di
    mov stop,di
    mov ax,input_st_size
    add stop,ax
    mov ax,sub_st_size
    sub stop,ax
    
    mov ans,0
    cld
    search_loop:
        mov ax,start
        cmp ax,stop
        jg search_end
        
        mov di,start
        lea si,sub_st
        mov cx,sub_st_size
        repz cmpsb
        jz increament
        inc start
        jmp search_loop     
    increament:
        mov ax,start
        mov ans,ax
        inc start
        jmp search_loop
    ;
    ;
    search_end:
        pop bx
        pop ax
        pop di
        pop si
        
        ret
    search endp
end main
