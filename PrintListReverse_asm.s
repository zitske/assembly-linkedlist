.data
    buffer: .asciiz "%s %d %s %d/%d/%d %s\n"

.text
.globl PrintListReverse_asm

PrintListReverse_asm:
    # Salvar o endereço de retorno e o ponteiro de quadro
    addi $sp, $sp, -32
    sw $ra, 28($sp)
    sw $fp, 24($sp)
    move $fp, $sp

    # Verificar se ptr é NULL
    lw $t0, 32($fp)  # Carregar argumento ptr
    beq $t0, $zero, end_function  # Se ptr == NULL, sair da função

    # Verificar se ptr->next não é NULL
    lw $t1, 4($t0)  # Carregar ptr->next
    beq $t1, $zero, print_node  # Se ptr->next == NULL, imprimir nó atual

    # Chamada recursiva
    move $a0, $t1  # Definir argumento para chamada recursiva
    jal PrintListReverse_asm

print_node:
    # Carregar dados do estudante
    lw $t2, 0($t0)  # Carregar ptr->data
    lw $a0, 49($t2)  # Carregar student->name
    lw $a1, 45($t2)  # Carregar student->registration
    lw $a2, 0($t2)  # Carregar student->course
    lw $a3, 184($t2)  # Carregar student->day
    lw $t3, 183($t2)  # Carregar student->month
    lw $t4, 179($t2)  # Carregar student->year
    lw $t5, 185($t2)  # Carregar student->hometown

    # Imprimir dados do estudante usando syscall
    # Imprimir nome
    li $v0, 4  # syscall para imprimir string
    move $a0, $a0
    syscall

    # Imprimir matrícula
    li $v0, 1  # syscall para imprimir inteiro
    move $a0, $a1
    syscall

    # Imprimir curso
    li $v0, 4  # syscall para imprimir string
    move $a0, $a2
    syscall

    # Imprimir dia
    li $v0, 1  # syscall para imprimir inteiro
    move $a0, $a3
    syscall

    # Imprimir mês
    li $v0, 1  # syscall para imprimir inteiro
    move $a0, $t3
    syscall

    # Imprimir ano
    li $v0, 1  # syscall para imprimir inteiro
    move $a0, $t4
    syscall

    # Imprimir cidade natal
    li $v0, 4  # syscall para imprimir string
    move $a0, $t5
    syscall

end_function:
    # Restaurar ponteiro de quadro e endereço de retorno
    lw $ra, 28($sp)
    lw $fp, 24($sp)
    addi $sp, $sp, 32
    jr $ra
