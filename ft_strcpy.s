section .text
global ft_strcpy

ft_strcpy:
	xor rax, rax
	jmp while

while:
	mov bl, BYTE [rsi + rax]
	mov BYTE [rdi + rax], bl
	cmp bl, 0
	je end
	inc rax
	jmp while

end:
	mov rax, rdi
	ret