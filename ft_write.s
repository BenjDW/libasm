section .text
global ft_write

ft_write:
	mov	rax, 0x1
 	syscall
	jc	exit_code
	ret

exit_code:
	mov rax, -1
	ret