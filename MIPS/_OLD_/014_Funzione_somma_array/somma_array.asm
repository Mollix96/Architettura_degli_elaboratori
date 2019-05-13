.data
array:   .word    1, 1, 2, 3, 5, 8, 13, 21    # Array
dim:     .word    8                           # Dimensione dell'array
message: .asciiz  "Lasomma dei valori e': "

.text
main:
    la    $s0, array                          # Carica nel registro $s0 l'indirizzo dell'array.
    lw    $s1, dim                            # Carica nel registro $a1 la lunghezza dell'array.
    
    sll   $s1, $s1, 2                         # DIM  *=  4
                                              # Moltiplica per 4 byte la dimensione dell'array.

    add   $a0, $s0, $zero                     # $a0 = pointer($s0)
                                              # Inizializza un puntatore all'array ($s0) 
                                              # nel registro $a0.

    add   $a1, $s0, $s1                       # Carica l'indirizzo dell'ultimo elemento 
                                              # dell'array (ottenuto dalla somma tra
                                              # l'indirizzo del primo elemento e la
                                              # dimensione dell'array moltiplicata per 4)
                                              # nel registro $a1.
                                              # Servira' per stabilire la condizione 
                                              # di arresto del ciclo.

    addi  $sp, $sp, -8                        # Decrementa lo stack pointer di 8 byte.
    sw    $a0, 0($sp)                         # Carica l'indirizzo dell'array sullo stack.
    sw    $a1, 4($sp)                         # Carica l'indirizzo dell'ultimo elemento sullo s.p.
    jal   array_sum                           # Chiama array_sum.

PRINT_MESSAGE:
    add   $a1, $zero, $v0                     # Recupera il valore di ritorno di array_sum.

    li    $v0, 4                              # Carica la syscall print_string.
    la    $a0, message                        # Carica il messaggio preimpostato.
    syscall                                   # Stampa il messaggio.
    
    li    $v0, 1                              # Carica la syscall print_integer.
    add   $a0, $zero, $a1                     # Carica la somma per essere stampata.
    syscall                                   # Stampa la somma.

EXIT:
    li    $v0, 10                             # Prepara la chiamata a exit.
    syscall                                   # Chiama exit.


array_sum:
    li    $v0, 0                              # Azzera il registro $v0 (ritorno della funzione).

    lw    $t0, 0($sp)                         # Pop dell'indirizzo dell'array dallo stack.
    lw    $t1, 4($sp)                         # Pop della dimensione dell'array dallo stack.
    addi  $sp, $sp, 8                         # Incrementa lo stack pointer di 8 byte.

    BEGIN_WHILE:
        beq   $t0, $t1 END_WHILE              # Cicla fino a quando l'indirizzo contenuto nel
                                              # puntatore non raggiunge l'indirizzo dell'ultimo
                                              # elemento dell'array puntato.

        lw    $t2, 0($t0)                     # Carica il valore contenuto nell'indirizzo dell'array
                                              # puntato (ovvero l'elemento corrente dell'array).

        add   $v0, $v0, $t2                   # Somma al valore di ritorno (registro $v0) il valore
                                              # attuale dell'array.

        addi  $t0, $t0, 4                     # Incrementa l'indirizzo dei memoria a cui punta il
                                              # puntatore all'array.

        j     BEGIN_WHILE                     # Ripete il ciclo.
    END_WHILE:

    jr        $ra                             # return
