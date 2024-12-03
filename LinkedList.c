#include <stdio.h>
#include <stdlib.h>
#include <string.h>

// Declarações das funções Assembly
extern struct LinkedList *CreateList_asm();
extern struct Student *CreateStudent_asm(char *name, unsigned int registration, char *course, unsigned int month, unsigned int year, unsigned int day, char *hometown);
extern void InsertStudent_asm(struct LinkedList *list, struct Student *newStudent);
extern void PrintListReverse_asm(struct Node *ptr);

/*** List element definition ***/
struct Student {   
    char course[45];
    unsigned int registration;
    char name[130];
        
    /* Birth date */
    unsigned int year;
    unsigned char month;
    unsigned char day;
    
    char hometown[20];
};


/*** List node definition ***/
struct Node {
    void *data;
    struct Node *next;
};


/*** List descriptor definition ***/ 
struct LinkedList {
    struct Node *head;  /* Points the first node (lower registration) */
    struct Node *tail;  /* Points the last node (higher registration) */
    unsigned int size;  /* Current number of nodes */            
};


/*** Initialize the list struct as an empty list ***/
struct LinkedList *CreateList() {
    // Chamada da função Assembly
    return CreateList_asm();
}

    
/*** Creates a new instance of struct Student and fill it ***/
struct Student *CreateStudent(char *name, unsigned int registration, char *course, unsigned int month, unsigned int year, unsigned int day, char *hometown) {
    // Chamada da função Assembly
    return CreateStudent_asm(name, registration, course, month, year, day, hometown);
}

/* Insert student according to registration order (lower registration first) */
void InsertStudent(struct LinkedList *list, struct Student *newStudent) {
    // Chamada da função Assembly
    InsertStudent_asm(list, newStudent);
}

/* Prints the list from head to tail */
void PrintList(struct LinkedList *list) {

    struct Node *aux;
    struct Student *student; 
    char buffer[] = "%s %d %s %d/%d/%d %s\n";  /**** IMPORTANTE: este array deve ser alocado no stack frame da função ****/
    
    aux = list->head;
    
    while (aux) {
        student = (struct Student *)aux->data;
        printf(buffer, student->name, student->registration, student->course, student->day, student->month, student->year, student->hometown);
        aux = aux->next;
    }    
}

void PrintListReverse(struct Node *ptr) {
    // Chamada da função Assembly
    PrintListReverse_asm(ptr);
}

int main() {

    struct LinkedList *list;
    
    list = CreateList();
    
    InsertStudent(list, CreateStudent("Ozzy Osbourne", 666, "Heavy Metal", 12, 1948, 3, "Aston"));   /* Empty list: insert the node as first and last */
    InsertStudent(list, CreateStudent("Mick Jagger", 650, "Rock and Roll", 7, 1943, 26, "Dartford"));/* Inserts before the head node (new head node) */
    InsertStudent(list, CreateStudent("Scott Ian", 670, "Thrash Metal", 12, 1963, 31, "New York"));  /* Inserts after the tail node (new tail node) */
    InsertStudent(list, CreateStudent("Vince Neil", 668, "Hard Rock", 2, 1961, 6, "Hollywood"));     /* Inserts between two nodes */
    InsertStudent(list, CreateStudent("Lemmy Kilmister", 660, "Extreme Rock and Roll", 12, 1945, 24, "Stoke-on-Trent"));   /* Inserts between two nodes */
    InsertStudent(list, CreateStudent("Robert Johnson", -1, "Delta Blues", 5, 1911, 8, "Greenwood"));/* Inserts after the tail node (new tail node) */
    
    printf("\nList size: %d\n",list->size);
    PrintList(list);
    printf("\n");
    
    PrintListReverse(list->head);
    printf("\n");
           
    return 0;
}