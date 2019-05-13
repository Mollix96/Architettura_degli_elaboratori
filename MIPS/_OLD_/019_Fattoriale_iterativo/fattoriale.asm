.data
msg_request:  .asciiz  "Digitare un numero naturale.\n"
msg_result:   .asciiz  "! = "

#region Main
.text
main:
    li    $v0, 4                                     # Carica la syscall print_string.
    la    $a0, msg_request                           # Prepara il primo messaggio per essere stampato.
    syscall                                          # Stampa il primo messaggio.

    li    $v0, 5                                     # Carica la syscall read_integer.
    syscall                                          # Chiama read_integer.
    add   $s0, $v0, $zero                            # Carica il numero nel registro $s0 (per stampa).
    add   $a0, $v0, $zero                            # Carica il numero nel registro $a0.

    jal   factorial                                  # Chiama factorial.
    add   $s1, $v0, $zero                            # Recupera il valore di ritorno e lo salva in $s1.

    # Stampa il risultato:
    li    $v0, 1                                     # Carica la syscall print_integer.
    add   $a0, $s0, $zero                            # Carica l'argomento nel registro $a0.
    syscall                                          # Stampa l'argomento.

    li    $v0, 4                                     # Carica la syscall print_string.
    la    $a0, msg_result                            # Prepara il secondo messaggio per essere stampato.
    syscall                                          # Stampa il secondo messaggio.

    li    $v0, 1                                     # Carica la syscall print_integer.
    add   $a0, $s1, $zero                            # Carica il risultato nel registro $a0.
    syscall                                          # Stampa il risultato.

exit:
    li    $v0, 10                                    # Prepara la chiamata a exit.
    syscall                                          # Chiama exit.
#endregion


#region Methods
factorial:
    li    $v0, 1                                     # factorial = 1

    BEGIN_WHILE:
        beq   $a0, $zero, END_WHILE                  # Cicla fino a quando l'argomento non diventa 0.
        mul   $v0, $a0, $v0                          # factorial = factorial * argument
        addi  $a0, $a0, -1                           # argument--
        j     BEGIN_WHILE                            # Nuova iterazione.
    END_WHILE:
    jr    $ra                                        # return
#endregion
