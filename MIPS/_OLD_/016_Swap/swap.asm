.data
array:    .word    5, 2               # Array
dim:      .word    2                  # Dimensione dell'array
space:    .asciiz  " "                # Per spaziare gli elementi dell'array.
newline:  .asciiz  "\n"               # Nuova riga.

.text
main:
    la    $s0, array                 # Carica nel registro $s0 l'indirizzo dell'array.
    lw    $s1, dim                   # Carica nel registro $a1 la lunghezza dell'array.
    
    sll   $s1, $s1, 2                # DIM  *=  4
                                     # Moltiplica per 4 byte la dimensione dell'array.

    add   $a0, $s0, $zero            # $a0 = pointer($s0)
                                     # Inizializza un puntatore all'array ($s0) 
                                     # nel registro $a0.

    add   $a1, $s0, $s1              # Carica l'indirizzo dell'ultimo elemento 
                                     # dell'array (ottenuto dalla somma tra
                                     # l'indirizzo del primo elemento e la
                                     # dimensione dell'array moltiplicata per 4)
                                     # nel registro $a1.
                                     # Servira' per stabilire la condizione 
                                     # di arresto del ciclo.

    addi  $sp, $sp, -8               # Decrementa lo stack pointer di 8 byte.
    sw    $a0, 0($sp)                # Carica l'indirizzo dell'array sullo stack.
    sw    $a1, 4($sp)                # Carica l'indirizzo dell'ultimo elemento sullo s.p.
    jal   print_array                # Chiama print_array.

    jal   swap                       # Chiama swap.

    li    $v0, 4                     # Carica la syscall print_string.
    la    $a0, newline               # Carica il messaggio newline.
    syscall                          # Stampa il messaggio.

    jal   print_array                # Chiama print_array.

exit:
    li    $v0, 10                    # Prepara la chiamata a exit.
    syscall                          # Chiama exit.


#
# Funzioni.
#
print_array:
    lw    $t0, 0($sp)                # Pop dell'indirizzo dell'array dallo stack.
    lw    $t1, 4($sp)                # Pop della dimensione dell'array dallo stack.

    BEGIN_WHILE:
        beq   $t0, $t1, END_WHILE    # Cicla fino a quando l'indirizzo contenuto nel puntatore
                                     # non raggiunge l'indirizzo dell'ultimo elemento dell'array
                                     # puntato.

        li    $v0, 1                 # Carica la syscall print_integer.
        lw    $a0, 0($t0)            # Carica il valore contenuto nell'indirizzo dell'array
                                     # puntato (ovvero l'elemento corrente dell'array).
        syscall

        li    $v0, 4                 # Carica la syscall print_string.
        la    $a0, space             # Carica il messaggio space.
        syscall                      # Stampa il messaggio.

        addi  $t0, $t0, 4            # Incrementa l'indirizzo dei memoria a cui punta il
                                     # puntatore (ovvero passa al prossimo elemento dell'array).

        j     BEGIN_WHILE            # Ripete il ciclo.
    END_WHILE:
    jr    $ra                        # return


swap:
    lw    $t0, 0($sp)                # Pop dell'indirizzo dell'array dallo stack.

    lw    $t1, 0($t0)                # temp1 = array[0]
    lw    $t2, 4($t0)                # temp2 = array[1]

    sw    $t2, 0($t0)                # array[0] = temp2
    sw    $t1, 4($t0)                # array[1] = temp1

    jr    $ra                        # return
