.model small
.stack 100h
.data
input_st db 80 dup(0)
sub_st db "11"

start dw ?
stop dw ?
ans dw ?
input_st_size dw ?
sub_st_size dw 2
.code
main proc
    mov ax,@data
    mov ds,ax
    mov es,ax
    
    lea di,input_st
    call read
    mov input_st_size,bx
    
    call search
    output:
        call nextline
        mov ah,2  
        mov dx,ans
        add dx,48
        int 21h
     main_end:
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
read proc   
    push ax
    push di
    mov bx,0
    ;
    ; 
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
        inc ans
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
