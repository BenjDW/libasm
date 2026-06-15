global ft_strdup
extern ft_strlen
extern malloc
extern ft_strcpy

ft_strdup:
	call	ft_strlen
	add		rax, 1
	push	rdi
	mov		rdi, rax
	call	malloc wrt ..plt
    test rax, rax
    jz null_return  
	pop		r8
	mov		rdi, rax	
	mov		rsi, r8
	call	ft_strcpy
	ret

null_return:
    pop rdi
    xor rax, rax
    ret
