# Função: InsertStudent
# Parâmetros:
#   $a0 = ponteiro para a lista (struct LinkedList *list)
#   $a1 = ponteiro para o novo estudante (struct Student *newStudent)

InsertStudent:
    # Passo 1: Alocar memória para o novo nó
    li $v0, 9           # 9 = chamada de sistema sbrk (syscall de malloc)
    li $a0, 8           # Tamanho da struct Node (2 pointers de 4 bytes)
    syscall
    move $t4, $v0       # $t4 armazena o ponteiro para o novo nó

    # Passo 2: Configurar o novo nó
    sw $a1, 0($t4)      # newNode->data = newStudent (armazenar o ponteiro)
    li $t3, 0           # newNode->next = NULL
    sw $t3, 4($t4)      # Armazenar NULL no campo 'next' do nó

    # Passo 3: Procurar a posição correta para o novo nó
    lw $t0, 0($a0)      # Carregar list->head em $t0 (aux = list->head)
    li $t1, 0           # auxPrev = NULL (início)
    
InsertStudent_for:
    beq $t0, $zero, InsertStudent_end_for # Se aux == NULL, sai do for

    # Carregar registration do estudante no nó atual
    lw $t2, 0($t0)      # aux->data
    lw $t5, 0($t2)      # registration = aux->data->registration
    lw $t6, 0($a1)      # registration de newStudent
    blt $t6, $t5, InsertStudent_insert_position # Se newStudent->registration < currentRegistration, insere o nó
    
    # Atualizar auxPrev e aux
    move $t1, $t0       # auxPrev = aux
    lw $t0, 4($t0)      # aux = aux->next
    j InsertStudent_for # Continua o loop

InsertStudent_insert_position:
    # Verifica se o novo nó deve ser o novo head
    lw $t2, 0($a0)      # list->head
    beq $t0, $t2, InsertStudent_new_head # Se aux == list->head, insere como novo head
    
    # Insere entre dois nós (auxPrev e aux)
    sw $t0, 4($t4)      # newNode->next = aux
    sw $t4, 4($t1)      # auxPrev->next = newNode
    j InsertStudent_update_size # Atualizar o tamanho da lista

InsertStudent_new_head:
    sw $t0, 4($t4)      # newNode->next = aux
    sw $t4, 0($a0)      # list->head = newNode
    j InsertStudent_update_size # Atualizar o tamanho da lista

InsertStudent_end_for:
    # Caso o for termine, verifica se a lista está vazia ou se o novo nó será o novo tail
    lw $t7, 8($a0)      # list->size
    beq $t7, $zero, InsertStudent_empty_list # Se list->size == 0, insere no início
    
    # Insere o novo nó no final da lista
    sw $t4, 4($t1)      # auxPrev->next = newNode

InsertStudent_empty_list:
    sw $t4, 0($a0)      # list->head = newNode
    sw $t4, 4($a0)      # list->tail = newNode

InsertStudent_update_size:
    lw $t7, 8($a0)      # Carregar list->size
    addi $t7, $t7, 1    # list->size++
    sw $t7, 8($a0)      # Atualizar list->size
    jr $ra              # Retorna da função
