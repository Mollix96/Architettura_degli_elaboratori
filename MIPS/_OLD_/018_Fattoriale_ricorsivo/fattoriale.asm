.data
msg_request:  .asciiz  "Digitare un numero naturale.\n"
msg_result:   .asciiz  "! = "

.text
#region Main
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
    addi  $sp, $sp, -8                               # Decrementa lo stack pointer di 8 byte.
    sw    $ra, 0($sp)                                # Carica sullo stack l'indirizzo di ritorno.
    sw    $s0, 4($sp)                                # Carica sullo stack l'argomento.

    # Caso di arresto
    # if (argument == 0) then (return 1)
    li    $v0, 1                                     # Carica il valore 1 nel registro $v0.
    beq   $a0, $zero, return                         # Salta a return se argument e' 0.

    # else (factorial(argument - 1))
    add   $s0, $a0, $zero                            # Copia $a0 nel registro $s0.
    sub   $a0, $a0, 1                                # argument--
    jal   factorial                                  # Chiamata ricorsiva.

    # result = argument * factorial(argument - 1)
    mul   $v0, $s0, $v0


    return:
        lw    $ra, 0($sp)                            # Pop dallo stack dell'indirizzo di ritorno.
        lw    $s0, 4($sp)                            # Pop dallo stack dell'argomento.
        addi  $sp, $sp, 8                            # Incrementa lo stack pointer di 8 byte.
        jr    $ra                                    # return
#endregion
