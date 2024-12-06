.data
    course: .space 45
    name: .space 130
    hometown: .space 20

.text
.globl CreateStudent_asm

CreateStudent_asm:
    # Salvar o endereço de retorno e o ponteiro de quadro
    addi $sp, $sp, -8
    sw $ra, 4($sp)
    sw $fp, 0($sp)
    move $fp, $sp

    # Alocar memória para o novo estudante
    li $a0, 207  # sizeof(struct Student)
    jal malloc
    move $s0, $v0  # Salvar ponteiro para o novo estudante

    # Copiar curso
    lw $a0, 8($fp)  # Carregar argumento course
    move $a1, $s0
    jal strcpy

    # Copiar matrícula
    lw $t0, 12($fp)  # Carregar argumento registration
    sw $t0, 45($s0)  # Salvar matrícula

    # Copiar nome
    lw $a0, 16($fp)  # Carregar argumento name
    addi $a1, $s0, 49
    jal strcpy

    # Copiar ano
    lw $t0, 20($fp)  # Carregar argumento year
    sw $t0, 179($s0)  # Salvar ano

    # Copiar mês
    lw $t0, 24($fp)  # Carregar argumento month
    sb $t0, 183($s0)  # Salvar mês

    # Copiar dia
    lw $t0, 28($fp)  # Carregar argumento day
    sb $t0, 184($s0)  # Salvar dia

    # Copiar cidade natal
    lw $a0, 32($fp)  # Carregar argumento hometown
    addi $a1, $s0, 185
    jal strcpy

    # Restaurar ponteiro de quadro e endereço de retorno
    move $v0, $s0  # Retornar ponteiro para o novo estudante
    lw $ra, 4($sp)
    lw $fp, 0($sp)
    addi $sp, $sp, 8
    jr $ra
