.data
    array:   .word    1, 1, 2, 3, 5, 8, 13, 21
    dim:     .word    8
    message_min: .asciiz  "Il valore minimo e' : "
    message_max: .asciiz  "Il valore massimo e': "
    newline:     .asciiz  "\n"

.text
main:
    la    $s0, array                          # Carica l'indirizzo dell'array nel registro $t0.
    lw    $s1, dim                            # Carica la dimensione dell'array nel registro $t1.

    sll   $s1, $s1, 2                         # dim  *=  4
                                              # Moltiplica per 4 byte la dimensione dell'array.
                                              # Ottenendo l'indirizzo di memoria dell'ultimo elemento
                                              # dell'array.

    add   $t0, $s0, $zero                     # $t0 = pointer($s0)
                                              # Inizializza un puntatore all'array ($s0) nel registro $t0.

    add   $t1, $s0, $s1                       # Carica l'indirizzo dell'ultimo elemento dell'array in $t1.
                                              # Servira' per stabilire la condizione di arresto del ciclo.

    lw    $s2, 0($t0)                         # Legge il primo valore dell'array...
    add   $s4, $zero, $s2                     # ...e lo imposta come valore minimo (contenuto nel registro $s4).

    BEGIN_WHILE:
        beq   $t0, $t1, END_WHILE             # Cicla fino a quando l'indirizzo contenuto nel puntatore
                                              # non raggiunge l'indirizzo dell'ultimo elemento dell'array
                                              # puntato.

        lw    $s2, 0($t0)                     # Carica il valore contenuto nell'indirizzo dell'array
                                              # puntato (ovvero l'elemento corrente dell'array).

        slt   $t3, $s3, $s2                   # Carica in $t3 il valore 1 se e solo se il registro $s3
                                              # (che rappresentera' il valore massimo) contiene un valore
                                              # minore del valore dell'array attualmente caricato ($s2).

        slt   $t4, $s2, $s4                   # Stesso ragionamento ma per il valore minimo.
                                              # Da notare che ora i registri $s2 (valore dell'array caricato)
                                              # e $s4 (valore minimo) sono invertiti, perche' $t4 vale 1 in
                                              # presenza di un nuovo minimo.
        BEGIN_IF_MAX:
            beq   $t3, $zero, END_IF_MAX      # Al momento, $s3 contiene il valore massimo (0 alla prima iterazione).
                                              # Se ($s3 < $s2) allora il valore dell'array attualmente caricato ($s2)
                                              # e' maggiore del valore massimo ($s3), a significare che in $s2 e'
                                              # presente il nuovo valore massimo.

            add   $s3, $zero, $s2             # Carica in $s3 il nuovo valore massimo ($s2).
        END_IF_MAX:

        BEGIN_IF_MIN:
            beq   $t4, $zero, END_IF_MIN      # Al momento, $s4 contiene il valore minimo (primo valore dell'array
                                              # alla prima iterazione).
                                              # Se ($s2 < $s4) allora il valore dell'array attualmente caricato ($s2)
                                              # e' minore del valore minimo ($s4), a significare che in $s2 e'
                                              # presente il nuovo valore minimo.

            add   $s4, $zero, $s2             # Carica in $s4 il nuovo valore minimo ($s2).
        END_IF_MIN:

        addi  $t0, $t0, 4                     # Incrementa l'indirizzo dei memoria a cui punta il
                                              # puntatore (ovvero passa al prossimo elemento dell'array).

        j     BEGIN_WHILE                     # Ripete il ciclo.
    END_WHILE:

print:
    li    $v0, 4                              # Carica la syscall print_string.
    la    $a0, message_min                    # Carica il messaggio preimpostato (valore minimo).
    syscall                                   # Stampa il messaggio.

    li    $v0, 1                              # Carica la syscall print_integer.
    add   $a0, $zero, $s4                     # Carica il valore minimo.
    syscall                                   # Stampa il valore minimo.

    li    $v0, 4                              # Carica la syscall print_string.
    la    $a0, newline                        # Carica il messaggio preimpostato (nuova riga).
    syscall                                   # Stampa il messaggio.

    la    $a0, message_max                    # Carica il messaggio preimpostato (valore massimo).
    syscall                                   # Stampa il messaggio.

    li    $v0, 1                              # Carica la syscall print_integer.
    add   $a0, $zero, $s3                     # Carica il valore massimo.
    syscall                                   # Stampa il valore massimo.

exit:
    li    $v0, 10                             # Carica la syscall exit.
    syscall                                   # Chiama exit.
