# Função: PrintListReverse
# Parâmetros:
#   $a0 = ponteiro para o nó atual (struct Node *ptr)
# Descrição: Percorre recursivamente a lista e imprime as informações do estudante.

PrintListReverse:
    # Passo 1: Salvar registradores no stack frame
    addi $sp, $sp, -176      # Reserva espaço no stack frame (buffer de 128 + salvos)
    sw $ra, 172($sp)         # Salvar o registrador de retorno (ra)
    sw $a0, 168($sp)         # Salvar ponteiro ptr
    sw $t0, 164($sp)         # Salvar registradores temporários
    sw $t1, 160($sp)
    sw $t2, 156($sp)
    sw $t3, 152($sp)
    
    # Passo 2: Verificar se ptr->next != NULL
    lw $t3, 4($a0)           # Carregar ptr->next
    beq $t3, $zero, PrintStudent # Se for NULL, imprime o nó atual

    # Passo 3: Chamada recursiva para PrintListReverse(ptr->next)
    move $a0, $t3           # Aqui está correto, porque é de registrador para registrador
    jal PrintListReverse     # Chamada recursiva
    lw $a0, 168($sp)        # Correção: Carregar o valor de 168($sp) para $a0 (restaurar ptr)

PrintStudent:
    # Passo 4: Carregar o estudante associado ao nó atual
    lw $t2, 0($a0)           # ptr->data (ponteiro para struct Student)
    lw $t1, 0($t2)           # Carregar o ponteiro para o estudante (student = ptr->data)
    
    # Passo 5: Carregar os campos do estudante
    la $a0, buffer           # Carregar o endereço do buffer
    addi $a0, $sp, 24        # Local para armazenar o buffer no stack frame
    
    la $a1, 52($t1)          # Carregar o endereço de student->name (offset 52)
    lw $a2, 48($t1)          # Carregar student->registration (offset 48)
    la $a3, 0($t1)           # Carregar o endereço de student->course (offset 0)
    lw $t4, 189($t1)         # Carregar student->day (offset 189)
    lw $t5, 188($t1)         # Carregar student->month (offset 188)
    lw $t6, 184($t1)         # Carregar student->year (offset 184)
    la $t7, 192($t1)         # Carregar o endereço de student->hometown (offset 192)

    # Passo 6: Chamada de sistema para printf
    li $v0, 4                # Chamada de sistema para imprimir string
    syscall                  # Chamada de printf (syscall 4)
    
    # Passo 7: Restaurar registradores do stack frame
    lw $ra, 172($sp)         # Restaurar o registrador de retorno
    lw $a0, 168($sp)         # Restaurar ponteiro ptr
    lw $t0, 164($sp)         # Restaurar registradores temporários
    lw $t1, 160($sp)
    lw $t2, 156($sp)
    lw $t3, 152($sp)
    addi $sp, $sp, 176       # Liberar espaço no stack frame
    
    jr $ra                   # Retorna para o chamador

# Buffer formatado para printf
.data
buffer: 
    .asciiz "%s %d %s %d/%d/%d %s\n"
