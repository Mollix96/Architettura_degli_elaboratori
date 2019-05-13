.data
array:   .word    1, 1, 2, 3, 5, 8, 13, 21
dim:     .word    8
message_min: .asciiz  "Il valore minimo e' : "
message_max: .asciiz  "Il valore massimo e': "
newline:     .asciiz  "\n"


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
    jal   min_max_array                       # Chiama array_sum.

# Stampa.
    li    $v0, 4                              # Carica la syscall print_string.
    la    $a0, message_min                    # Carica il messaggio preimpostato (valore minimo).
    syscall                                   # Stampa il messaggio.

    li    $v0, 1                              # Carica la syscall print_integer.
    add   $a0, $zero, $v0                     # Carica il valore minimo.
    syscall                                   # Stampa il valore minimo.

    li    $v0, 4                              # Carica la syscall print_string.
    la    $a0, newline                        # Carica il messaggio preimpostato (nuova riga).
    syscall                                   # Stampa il messaggio.

    la    $a0, message_max                    # Carica il messaggio preimpostato (valore massimo).
    syscall                                   # Stampa il messaggio.    

    li    $v0, 1                              # Carica la syscall print_integer.
    add   $a0, $zero, $v1                     # Carica il valore massimo.
    syscall                                   # Stampa il valore massimo.
    

exit:
    li    $v0, 10                             # Prepara la chiamata a exit.
    syscall                                   # Chiama exit.


#
# Funzioni.
#
min_max_array:                                # Ritorna i valori minimo e massimo di un array
                                              # rispettivemente nei registri $v0 e $v1.
                                            
                                              # ============ Impostazione dei registri ============
                                              # $v0 = min
                                              # $v1 = max
                                              # $t0 = indirizzo array
                                              # $t1 = dimensione array
                                              # $t2 = valore caricato dall'array
                                              # $t3 = risultato di (max < valore)
                                              # $t4 = risultato di (valore < min)

    lw    $t0, 0($sp)                         # Pop dell'indirizzo dell'array dallo stack.
    lw    $t1, 4($sp)                         # Pop della dimensione dell'array dallo stack.
    addi  $sp, $sp, 8                         # Incrementa lo stack pointer di 8 byte.

    lw    $t2, 0($t0)                         # Legge il primo valore dell'array...
    add   $t4, $zero, $t2                     # ...e lo imposta come valore minimo (contenuto nel registro $t4).

    BEGIN_WHILE:
        beq   $t0, $t1, END_WHILE             # Cicla fino a quando l'indirizzo contenuto nel puntatore
                                              # non raggiunge l'indirizzo dell'ultimo elemento dell'array
                                              # puntato.

        lw    $t2, 0($t0)                     # Carica il valore contenuto nell'indirizzo dell'array
                                              # puntato (ovvero l'elemento corrente dell'array).

        slt   $t3, $v1, $t2                   # Carica in $t3 il valore 1 se e solo se il registro $v1
                                              # (che rappresentera' il valore massimo) contiene un valore
                                              # minore del valore dell'array attualmente caricato ($t2).

        slt   $t4, $t2, $v0                   # Stesso ragionamento ma per il valore minimo.
                                              # Da notare che ora i registri $t2 (valore dell'array caricato)
                                              # e $v0 (valore minimo) sono invertiti, perche' $t4 vale 1 in
                                              # presenza di un nuovo minimo.
        BEGIN_IF_MAX:
            beq   $t3, $zero, END_IF_MAX      # Al momento, $v1 contiene il valore massimo (0 alla prima iterazione).
                                              # Se ($v1 < $t2) allora il valore dell'array attualmente caricato ($t2)
                                              # e' maggiore del valore massimo ($v1), a significare che in $t2 e'
                                              # presente il nuovo valore massimo.

            add   $v1, $zero, $t2             # Carica in $v1 il nuovo valore massimo ($t2).
        END_IF_MAX:

        BEGIN_IF_MIN:
            beq   $t4, $zero, END_IF_MIN      # Al momento, $v0 contiene il valore minimo (primo valore dell'array
                                              # alla prima iterazione).
                                              # Se ($t2 < $v0) allora il valore dell'array attualmente caricato ($t2)
                                              # e' minore del valore minimo ($v0), a significare che in $t2 e'
                                              # presente il nuovo valore minimo.

            add   $v0, $zero, $t2             # Carica in $v0 il nuovo valore minimo ($t2).
        END_IF_MIN:

        addi  $t0, $t0, 4                     # Incrementa l'indirizzo dei memoria a cui punta il
                                              # puntatore (ovvero passa al prossimo elemento dell'array).

        j     BEGIN_WHILE                     # Ripete il ciclo.
    END_WHILE:

    jr        $ra                             # return
