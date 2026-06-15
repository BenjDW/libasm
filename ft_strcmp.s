section .text
global ft_strcmp

ft_strcmp:
	xor		rcx, rcx
	xor		rax, rax

cmp:
	cmp		BYTE[rdi + rcx], 0
	jz		return
	cmp		BYTE[rsi + rcx], 0
	jz		return
	mov		al, BYTE[rsi + rcx]
	cmp		BYTE[rdi + rcx], al
	jnz		return
	inc		rcx
	jmp		cmp

return:
	movsx		rax, BYTE[rdi + rcx]
	movsx		rdx, BYTE[rsi + rcx]
	sub		rax, rdx
	ret	