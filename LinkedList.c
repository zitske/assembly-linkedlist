#include <stdio.h>
#include <stdlib.h>
#include <string.h>

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
    struct LinkedList *list = (struct LinkedList *)malloc(sizeof(struct LinkedList));

    list->head = NULL;
    list->tail = NULL;
    list->size = 0;
    
    return list;
}

    
/*** Creates a new instance of struct Student and fill it ***/
struct Student *CreateStudent(char *name, unsigned int registration, char *course, unsigned int month, unsigned int year, unsigned int day, char *hometown) {
    
    struct Student *newStudent;
    
    /* Allocates a new student struct in order to hold the new student informations */
    newStudent = (struct Student *)malloc(sizeof(struct Student));
    
    /* Sets the student information */
    strcpy(newStudent->course, course);
    newStudent->registration = registration;
    strcpy(newStudent->name, name);
    newStudent->year = year;
    newStudent->month = month;
    newStudent->day = day;    
    strcpy(newStudent->hometown, hometown);
    
    return newStudent;
}

/* Insert student according to registration order (lower registration first) */
void InsertStudent(struct LinkedList *list, struct Student *newStudent) {
    
    /* Auxiliary pointer */
    struct Node *aux, *newNode;
    struct Node *auxPrev;  /* Points the node right before aux */
    
    unsigned int currentRegistration;
    
    /* Allocates a new node to be inserted in the list */
    newNode = (struct Node *)malloc(sizeof(struct Node));
         
    /* Set the new node to point the new created student */
    newNode->data = (struct Student *)newStudent;  // Casts the void pointer (data)
    
    /* Initialize the new node next pointer to NULL */
    newNode->next = NULL;
     
    /* Searches for the right place to insert the student */
    /* Students are linked following registration order */
    /* list->head points the lower registration */
    for (aux = list->head; aux != NULL; auxPrev = aux, aux = aux->next) {
        currentRegistration = ((struct Student *)aux->data)->registration;
        if (newStudent->registration < currentRegistration) 
            /* Verifies if the new student has the lower registration */
            if (aux == list->head) {
                /* Inserts before the first node (new head node) */
                list->head = newNode;
                newNode->next = aux;                
                break;
            }
            else {                
                /* Inserts between two nodes */
                auxPrev->next = newNode;
                newNode->next = aux;
                break;
            }
    }
    
    /* If aux == NULL, then the list is empty or the student has the higher registration */
    if (aux == NULL) { 
        
        /* Verifies if the list is empty */
        if (list->size == 0)    
            /* Empty list: inserts the new node as head */
            list->head = newNode;            
        else 
            /* Inserts after the tail node (new tail node) */
            auxPrev->next = newNode;
        
        /* Set the new node as tail */
        list->tail = newNode;
    }
    
    /* Updates the list size */
    list->size++;               
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

    struct Node *aux;
    struct Student *student; 
    char buffer[] = "%s %d %s %d/%d/%d %s\n";  /**** IMPORTANTE: este array deve ser alocado no stack frame da função ****/
        
    if (ptr->next != NULL) 
        PrintListReverse(ptr->next);
    
    student = (struct Student *)ptr->data;
    printf(buffer, student->name, student->registration, student->course, student->day, student->month, student->year, student->hometown);
 
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