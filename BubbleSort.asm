# Função: BubbleSort
# Parâmetros:
#   $a0 = ponteiro para o array (int *array)
#   $a1 = tamanho do array (int size)
# 
# Registradores utilizados:
#   $t0 = i (índice do array)
#   $t1 = j (índice do array, j = i + 1)
#   $t2 = temp (variável temporária para a troca)
#   $t3 = swap (flag para verificar se houve troca)
#   $t4 = elemento array[i]
#   $t5 = elemento array[j]

BubbleSort:
    # Inicializa swap = 1
    li $t3, 1           # swap = 1

BubbleSort_while:
    beq $t3, $zero, BubbleSort_end  # Se swap == 0, sai do loop
    li $t3, 0           # swap = 0

    li $t0, 0           # i = 0
    add $t1, $t0, 1     # j = i + 1

BubbleSort_for:
    bge $t1, $a1, BubbleSort_while_end  # Se j >= size, termina o for

    # Carregar array[i] e array[j] em $t4 e $t5
    sll $t6, $t0, 2     # $t6 = i * 4 (offset para acessar array[i])
    add $t7, $a0, $t6   # Endereço de array[i]
    lw $t4, 0($t7)      # Carrega array[i] em $t4

    sll $t6, $t1, 2     # $t6 = j * 4 (offset para acessar array[j])
    add $t7, $a0, $t6   # Endereço de array[j]
    lw $t5, 0($t7)      # Carrega array[j] em $t5

    # Comparar se array[i] > array[j]
    ble $t4, $t5, BubbleSort_no_swap  # Se array[i] <= array[j], não troca

    # Troca array[i] com array[j]
    move $t2, $t4      # temp = array[i]
    sw $t4, 0($t7)     # array[j] = array[i]
    sll $t6, $t0, 2    # $t6 = i * 4
    add $t7, $a0, $t6  # Endereço de array[i]
    sw $t5, 0($t7)     # array[i] = array[j]
    li $t3, 1          # swap = 1

BubbleSort_no_swap:
    addi $t0, $t0, 1   # i++
    addi $t1, $t1, 1   # j++
    j BubbleSort_for   # Volta para o início do for

BubbleSort_while_end:
    j BubbleSort_while # Volta para o início do while

BubbleSort_end:
    jr $ra             # Retorna da função
