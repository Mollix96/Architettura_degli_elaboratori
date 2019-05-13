.data
even_message:  .asciiz "Il numero e' pari.\n"
odd_message:   .asciiz "Il numero e' dispari.\n"

.text
main:
    addi  $a1, $zero, 7              # a = 7
                                     # Carica il numero da controllare nel registro $a1.
    addi  $sp, $sp -4                # Decrementa lo stack pointer di 4 byte.
    sw    $a1, 0($sp)                # push(a);

    jal   evenOrOdd                  # Chiama la funnzione.

# Stampa.
    li    $v0, 4                     # Prepara la chiamata a print_string.

    BEGIN_IF:
        bne   $v1, $zero, ELSE       # Se il numero e' dispari, entra nel ramo ELSE.
        la    $a0, even_message      # Carica il messaggio per numero pari.
        syscall                      # Stampa il messaggio.
        j     END_IF
    ELSE:
        la    $a0, odd_message       # Carica il messaggio per numero dispari.
        syscall                      # Stampa il messaggio.
    END_IF:

exit:
    li    $v0, 10                    # Prepara la chiamata a exit.
    syscall                          # Chiama exit.


#
# Funzioni.
#
evenOrOdd:
    lw    $t0, 0($sp)                # temp0 = pop();
    addi  $sp, $sp 4                 # Inrementa lo stack pointer di 4 byte.

    andi  $v1, $t0, 0x1              # L'operazione di AND tra ($t0) e (0x1) restituisce 0 se l'ultimo
                                     # bit di $t0 vale 0 ($t0 pari) oppure 1 ($t0 dispari).

    jr    $ra                        # return
