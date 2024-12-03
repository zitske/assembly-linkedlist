#include <iregdef.h>        // Defines the register convention names

    .text
    .globl  PrintListReverse_asm             # Makes the function visible for other programs      
    .ent    PrintListReverse_asm

# Função: PrintListReverse
# Imprime a lista encadeada em ordem reversa usando recursão.
# Argumentos:
#   $a0 = ponteiro para o nó atual
# Retorno:
#   Sem valor de retorno (apenas imprime no console).

PrintListReverse_asm:
    # Base case: se o nó atual for NULL, retorna
    beq $a0, $zero, PrintListReverse_End

    # Salva o registrador de retorno ($ra) na pilha
    addiu $sp, $sp, -4
    sw $ra, 0($sp)

    # Avança para o próximo nó (chamada recursiva)
    lw $t0, 4($a0)          # $t0 = ponteiro para o próximo nó (campo 'next' do nó atual)
    move $a0, $t0
    jal PrintListReverse_asm    # Chamada recursiva com o próximo nó

    # Após a recursão, imprime o conteúdo do nó atual
    lw $t1, 0($a0)          # Carrega o endereço da estrutura `Student` (campo 'data' do nó)
    move $a0, $t1
    li $v0, 4               # Syscall para impressão de string
    syscall

    # Restaura o registrador de retorno ($ra) e ajusta a pilha
    lw $ra, 0($sp)
    addiu $sp, $sp, 4

PrintListReverse_End:
    jr $ra                  # Retorna para o chamador

.end PrintListReverse_asm
