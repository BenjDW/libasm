section .text
global ft_read

ft_read:
	mov	rax, 0x0
 	syscall
	cmp rax, 0
	jl	exit_code
	ret

exit_code:
	mov rax, -1
	ret
