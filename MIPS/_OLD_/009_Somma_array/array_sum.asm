.data
array:   .word    1, 1, 2, 3, 5, 8, 13, 21    # Array
dim:     .word    8                           # Dimensione dell'array
message: .asciiz  "La somma dei valori e': "

.text
main:
init:
    la   $s0, array                           # Carica l'indirizzo dell'array nel registro $t0.
    lw   $s1, dim                             # Carica la dimensione dell'array nel registro $t1.

    sll  $s1, $s1, 2                          # dim  *=  4
                                              # Moltiplica per 4 byte la dimensione dell'array.

    add  $t0, $s0, $zero                      # $t0 = pointer($s0)
                                              # Inizializza un puntatore all'array ($s0) nel registro $t0.

    add  $t1, $s0, $s1                        # Carica l'indirizzo dell'ultimo elemento dell'array in $t1.
                                              # Servira' per stabilire la condizione di arresto del ciclo.

    BEGIN_WHILE:
        beq  $t0, $t1, END_WHILE              # Cicla fino a quando l'indirizzo contenuto nel puntatore
                                              # non raggiunge l'indirizzo dell'ultimo elemento dell'array
                                              # puntato.

        lw   $s2, 0($t0)                      # Carica il valore contenuto nell'indirizzo dell'array
                                              # puntato (ovvero l'elemento corrente dell'array).

        add  $a1, $a1, $s2                    # somma += array[i]
                                              # Aggiunge al registro $a1 (contenente la somma degli
                                              # elementi dell'array) l'elemento corrente dell'array
                                              # puntato.

        addi $t0, $t0, 4                      # Incrementa l'indirizzo dei memoria a cui punta il
                                              # puntatore (ovvero passa al prossimo elemento dell'array).

        j    BEGIN_WHILE                      # Ripete il ciclo.
    END_WHILE:

print:
    li    $v0, 4                              # Carica la syscall print_string.
    la    $a0, message                        # Carica il messaggio preimpostato.
    syscall                                   # Stampa il messaggio.

    li    $v0, 1                              # Carica la syscall print_integer.
    add   $a0, $zero, $a1                     # Carica la somma per essere stampata.
    syscall                                   # Stampa la somma.

exit:
    li    $v0, 10                             # Prepara la chiamata a exit.
    syscall                                   # Chiama exit.
