# Simula il lancio di un dado a 6 facce.

.text
#region Main
main:
    jal roll                    # Chiamata a roll.

    # Stampa del valore.
    li    $v0, 1                # Carica la syscall print_integer.
    syscall                     # Stampa il valore generato.

exit:
    li    $v0, 10               # Carica la syscall exit.
    syscall                     # Termina l'esecuzione.
#endregion


#region Methods
roll:
    li    $a1, 6                # Imposta il range di numeri pseudo-random generabili
                                # affinché la chiamata alla syscall seguente generi
                                # solo valori pseudo-random da 0 a 5.
    li    $v0, 42               # Carica la syscall random_int_range.
    syscall                     # $a0 = random(0, 5)

    addi  $a0, $a0, 1           # Somma 1 a $a0 (le facce del dado hanno valori da 1 a 6).

    jr    $ra                   # Restituisce il controllo al chiamante.

#endregion
