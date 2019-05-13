.data
count:  .word    120                                       # Numero di lanci.
msg:    .asciiz  "Numero di successi: "

.text
#region Main
main:
    la    $s0, count                                       # Carica l'indirizzo di count nel registro $s0.
    lw    $a2, 0($s0)                                      # Carica il numero di lanci nel registro $a2.

    jal   roll_three                                       # Chiamata a roll_three.

    la    $a0, msg                                         # Carica msg nel registro $a0.
    li    $v0, 4                                           # Prepara la chiamata a print_string.
    syscall                                                # Stampa msg.

    move  $a0, $a3                                         # Carica il risultato di roll_three in $a0.
    li    $v0, 1                                           # Prepara la chiamata a print_integer.
    syscall                                                # Stampa il risultato.

exit:
    li    $v0, 10                                          # Carica la syscall exit.
    syscall                                                # Termina l'esecuzione.
#endregion


#region Methods
#
# Effettua il lancio di 1 dado.
# $a0 = risultato del lancio.
roll:
    li    $a1, 6                                           # Imposta il range di numeri pseudo-random generabili
                                                           # affinché la chiamata alla syscall seguente generi
                                                           # solo valori pseudo-random da 0 a 5.
    li    $v0, 42                                          # Carica la syscall random_int_range.
    syscall                                                # $a0 = random(0, 5)

    addi  $a0, $a0, 1                                      # Somma 1 a $a0 (le facce del dado hanno valori da 1 a 6).

    jr    $ra                                              # Restituisce il controllo al chiamante.


# Controlla quanti lanci hanno
# prodotto 3 risultati uguali.
# $a3 = numero di successi.
roll_three:
    addi  $sp, $sp -4                                      # Decrementa lo stack pointer di 4 byte.
    sw    $ra, 0($sp)                                      # Carica l'indirizzo di ritorno sullo stack pointer.

    move  $t0, $a2                                         # Carica il numero di lanci nel registro $t0.
    BEGIN_WHILE:
        beq   $t0, $zero, END_WHILE                        # Cicla fino a quando (count > 0).

        jal   roll                                         # Chiama roll.
        move  $t1, $a0                                     # $t1 = roll()

        jal   roll                                         # Chiama roll.
        bne   $t1, $a0, CONTINUE                           # Se il secondo lancio non ha prodotto un risultato
                                                           # uguale al primo, salta alla fine del ciclo.
            jal   roll                                     # Chiama roll
            bne $t1, $a0, CONTINUE                         # Se il tezo lancio non ha prodotto un risultato
                                                           # uguale al primo (e al secondo), salta alla fine del ciclo.
            # Se si arriva in questo punto, i tre lanci
            # Hanno prodotto risultati uguali.
                addi  $a3, $a3, 1                          # result++

        CONTINUE:
            addi  $t0, $t0, -1                             # count--
            j     BEGIN_WHILE                              # Ripete il ciclo.
    END_WHILE:
    lw    $ra, 0($sp)                                      # Recupera l'indirizzo di ritorno della chiamata
                                                           # a roll_three e lo carica in $ra.
    addi  $sp, $sp, 4                                      # Incrementa lo stack pointer di 4 byte.
    jr    $ra                                              # Restituisce il controllo al chiamante.
#endregion
