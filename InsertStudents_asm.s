.text
.globl InsertStudent_asm

InsertStudent_asm:
    # Salvar o endereço de retorno e o ponteiro de quadro
    addi $sp, $sp, -8
    sw $ra, 4($sp)
    sw $fp, 0($sp)
    move $fp, $sp

    # Alocar memória para o novo nó
    li $a0, 8  # sizeof(struct Node)
    jal malloc
    move $s0, $v0  # Salvar ponteiro para o novo nó

    # Definir dados do novo nó
    lw $t0, 12($fp)  # Carregar argumento newStudent
    sw $t0, 0($s0)  # newNode->data = newStudent

    # Inicializar o ponteiro next do novo nó para NULL
    sw $zero, 4($s0)  # newNode->next = NULL

    # Ponteiros auxiliares
    lw $t1, 8($fp)  # Carregar argumento list
    lw $t2, 0($t1)  # aux = list->head
    move $t3, $zero  # auxPrev = NULL

    # Procurar o lugar certo para inserir o estudante
    insert_loop:
        beq $t2, $zero, insert_end  # Se aux == NULL, sair do loop
        lw $t4, 0($t2)  # Carregar aux->data
        lw $t5, 45($t4)  # Carregar currentRegistration
        lw $t6, 12($fp)  # Carregar newStudent
        lw $t7, 45($t6)  # Carregar newStudent->registration
        bge $t7, $t5, next_node  # Se newStudent->registration >= currentRegistration, ir para o próximo nó

        # Inserir antes do primeiro nó (novo nó head)
        beq $t2, $t1, insert_head
        # Inserir entre dois nós
        sw $s0, 4($t3)  # auxPrev->next = newNode
        sw $t2, 4($s0)  # newNode->next = aux
        j insert_end

    next_node:
        move $t3, $t2  # auxPrev = aux
        lw $t2, 4($t2)  # aux = aux->next
        j insert_loop

    insert_head:
        sw $s0, 0($t1)  # list->head = newNode
        sw $t2, 4($s0)  # newNode->next = aux
        j insert_end

    insert_end:
        beq $t2, $zero, insert_tail  # Se aux == NULL, definir nova cauda
        j update_size

    insert_tail:
        lw $t8, 4($t1)  # Carregar list->tail
        beq $t8, $zero, set_head  # Se a lista estiver vazia, definir nova cabeça
        sw $s0, 4($t8)  # list->tail->next = newNode
        sw $s0, 4($t1)  # list->tail = newNode
        j update_size

    set_head:
        sw $s0, 0($t1)  # list->head = newNode
        sw $s0, 4($t1)  # list->tail = newNode

    update_size:
        lw $t9, 8($t1)  # Carregar list->size
        addi $t9, $t9, 1  # list->size++
        sw $t9, 8($t1)  # Atualizar tamanho da lista

    # Restaurar ponteiro de quadro e endereço de retorno
    lw $ra, 4($sp)
    lw $fp, 0($sp)
    addi $sp, $sp, 8
    jr $ra
