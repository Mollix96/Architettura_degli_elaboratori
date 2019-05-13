.data
even_message:  .asciiz "Il numero e' pari.\n"
odd_message:   .asciiz "Il numero e' dispari.\n"

.text
main:
init:
    li  $s0, 4                     # Carica il numero da controllare nel registro $s0.

    andi  $t0, $s0, 0x1            # L'operazione di AND tra ($s0) e (0x1) restituisce 0 se l'ultimo
                                   # bit di $s0 vale 0 ($s0 pari) oppure 1 ($s0 dispari).
    li    $v0, 4                   # Prepara la chiamata a print_string.

    BEGIN_IF:
        bne   $t0, $zero, ELSE     # Se il numero e' dispari, entra nel ramo ELSE.
        la    $a0, even_message    # Carica il messaggio per numero pari.
        syscall                    # Stampa il messaggio.
        j     END_IF
    ELSE:
        la    $a0, odd_message     # Carica il messaggio per numero dispari.
        syscall                    # Stampa il messaggio.
    END_IF:

exit:
    li  $v0, 10                    # Prepara la chiamata a exit.
    syscall                        # Chiama exit.
