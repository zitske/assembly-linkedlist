# Função: CreateStudent
# Descrição: Aloca memória para um novo estudante e inicializa seus campos.
# Argumentos: 
#   $a0 = endereço da string 'name'
#   $a1 = valor de 'registration'
#   $a2 = endereço da string 'course'
#   $a3 = valor de 'month'
# Os outros argumentos serão passados usando a pilha:
#   word 0($sp) = valor de 'year'
#   word 4($sp) = valor de 'day'
#   word 8($sp) = endereço da string 'hometown'
# Retorno: 
#   $v0 = ponteiro para a estrutura criada.

#include <iregdef.h>        // Defines the register convention names

    .text
    .globl  CreateStudent_asm             # Makes the Pow function visible for other programs      
    .ent    CreateStudent_asm
    
CreateStudent_asm:
    # Salva os registradores de retorno na pilha
    addi $sp, $sp, -32          # Cria espaço na pilha
    sw $ra, 28($sp)             # Salva $ra (endereço de retorno)
    sw $s0, 24($sp)             # Salva $s0

    # Aloca memória para a estrutura Student (tamanho: 210 bytes)
    li $a0, 210                 # Tamanho da estrutura
    li $v0, 9                   # Código do serviço malloc
    syscall                     # Chama o sistema para alocar memória
    move $s0, $v0               # Salva o endereço da estrutura em $s0

    # Verifica se a alocação foi bem-sucedida
    beqz $s0, CreateStudent_asm_Error

    # Copia o campo 'course'
    move $a0, $a2               # Endereço do curso
    move $a1, $s0               # Endereço da estrutura
    jal strcpy                  # Copia a string (course)

    # Armazena o campo 'registration'
    lw $t0, 0($sp)              # Carrega o valor de year (passado na pilha)
    sw $a1, 44($s0)             # Armazena registration (offset = 44)

    # Copia o campo 'name'
    move $a0, $a0               # Endereço da string 'name'
    addi $a1, $s0, 4            # Offset para o campo 'name' na estrutura
    jal strcpy                  # Copia a string (name)

    # Armazena o campo 'year'
    lw $t0, 0($sp)              # Carrega o valor de 'year' da pilha
    sw $t0, 136($s0)            # Armazena o ano na estrutura (offset = 136)

    # Armazena o campo 'month'
    sw $a3, 140($s0)            # Armazena o mês (offset = 140)

    # Armazena o campo 'day'
    lw $t1, 4($sp)              # Carrega o valor de 'day' da pilha
    sw $t1, 144($s0)            # Armazena o dia (offset = 144)

    # Copia o campo 'hometown'
    lw $a0, 8($sp)              # Endereço da string 'hometown' na pilha
    addiu $a1, $s0, 148         # Offset para o campo 'hometown' na estrutura
    jal strcpy                  # Copia a string (hometown)

    # Retorna o endereço da nova estrutura
    move $v0, $s0               # Coloca o endereço da estrutura em $v0

    # Restaura os registradores e retorna
    lw $ra, 28($sp)             # Restaura o endereço de retorno
    lw $s0, 24($sp)             # Restaura $s0
    addi $sp, $sp, 32           # Ajusta a pilha de volta
    jr $ra                      # Retorna para o chamador

CreateStudent_asm_Error:
    li $v0, 0                   # Retorna NULL em caso de erro
    lw $ra, 28($sp)             # Restaura o endereço de retorno
    lw $s0, 24($sp)             # Restaura $s0
    addi $sp, $sp, 32           # Ajusta a pilha de volta
    jr $ra                      # Retorna para o chamador

.end CreateStudent_asm
