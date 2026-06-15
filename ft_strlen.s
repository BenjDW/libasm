section .text
global ft_strlen

ft_strlen:
	mov rax, 0
	jmp while

while:
	cmp BYTE [rdi + rax], 0
	je exit
	inc rax
	jmp while

exit:
	ret