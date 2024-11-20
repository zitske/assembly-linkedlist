# Função: PrintListReverse
# Imprime a lista encadeada em ordem reversa usando recursão.
# Argumentos:
#   $a0 = ponteiro para o nó atual
# Retorno:
#   Sem valor de retorno (apenas imprime no console).

PrintListReverse:
    # Base case: se o nó atual for NULL, retorna
    beq $a0, $zero, PrintListReverse_End

    # Salva o registrador de retorno ($ra) na pilha
    addiu $sp, $sp, -4
    sw $ra, 0($sp)

    # Avança para o próximo nó (chamada recursiva)
    lw $t0, 0($a0)          # $t0 = ponteiro para o próximo nó (primeiro campo do nó atual)
    jal PrintListReverse    # Chamada recursiva com o próximo nó ($t0 em $a0)

    # Após a recursão, imprime o conteúdo do nó atual
    lw $t1, 4($a0)          # Carrega o endereço da estrutura `Student` (segundo campo do nó)
    lw $a0, 0($t1)          # Carrega o ponteiro para o nome do estudante
    li $v0, 4               # Syscall para impressão de string
    syscall

    # Restaura o registrador de retorno ($ra) e ajusta a pilha
    lw $ra, 0($sp)
    addiu $sp, $sp, 4

PrintListReverse_End:
    jr $ra                  # Retorna para o chamador
