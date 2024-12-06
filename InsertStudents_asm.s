#include <iregdef.h>        // Defines the register convention names

    .text
    .globl  InsertStudent_asm             # Makes the function visible for other programs      
    .ent    InsertStudent_asm

# Função: InsertStudent
# Insere um estudante em uma lista encadeada.
# Argumentos:
#   $a0 = ponteiro para o início da lista (ponteiro de cabeçalho)
#   $a1 = ponteiro para o novo estudante a ser inserido
# Retorno:
#   $v0 = ponteiro atualizado para o início da lista (cabeçalho).

InsertStudent_asm:
    # Salva os registradores na pilha
    addiu $sp, $sp, -16       # Cria espaço na pilha
    sw $ra, 12($sp)           # Salva o endereço de retorno
    sw $s0, 8($sp)            # Salva $s0
    sw $s1, 4($sp)            # Salva $s1

    # Prepara o novo nó
    move $s0, $a1             # $s0 agora aponta para o novo estudante
    lw $t0, 0($a0)            # Carrega o ponteiro de cabeçalho (lista atual)
    sw $t0, 0($s0)            # Configura o próximo nó do novo estudante
    move $v0, $s0             # Atualiza o cabeçalho para o novo nó

    # Restaura os registradores e retorna
    lw $ra, 12($sp)           # Restaura o endereço de retorno
    lw $s0, 8($sp)            # Restaura $s0
    lw $s1, 4($sp)            # Restaura $s1
    addiu $sp, $sp, 16        # Ajusta a pilha de volta
    jr $ra                    # Retorna para o chamador

.end InsertStudent_asm
