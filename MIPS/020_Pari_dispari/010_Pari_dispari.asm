.data
msg_request:  .asciiz  "Digitare un valore intero.\n"
msg_even:     .asciiz  "Il valore digitato e' pari.\n"
msg_odd:      .asciiz  "Il valore digitato e' dispari.\n"

.text
#region Main
main:
                                    # Stampa il messaggio di richiesta.
    la    $a0, msg_request          # Carica il messaggio di richiesta.
    li    $v0, 4                    # Carica il codice della syscall 'print_string'.
    syscall                         # Stampa il messaggio di richiesta.

                                    # Legge il valore.
    li    $v0, 5                    # Carica il codice della syscall 'read_integer'.
    syscall                         # Lettura del valore.
    move  $s0, $v0                  # Salva il valore letto.

                                    # Chiama la funzione 'setOnEven'.
    addi  $sp, $sp, -4              # Decrementa lo stack pointer di 4 byte.
    sw    $s0, 0($sp)               # Carica il valore sullo stack.
    jal   setOnEven                 # Imposta $v0 ad 1 se il valore e' pari.

    move  $t0, $v0                  # Salva il valore di ritorno.

                                    # Stampa il messaggio di risposta in base al
                                    # risultato della chiamata.
    li    $v0, 4                    # Carica il codice della syscall 'print_string'.
    beq   $t0, 0x0, main_odd        # Se il valore e' dispari, salta.

                                    # Se si arriva qui, il valore e' pari.
    la    $a0, msg_even             # Carica il messaggio da stampare.
    syscall                         # Stampa il messaggio.
    j     exit                      # Salta al termine del programma.

main_odd:                           # Se si arriva qui, il valore e' dispari.
    la    $a0, msg_odd              # Carica il messaggio da stampare.
    syscall                         # Stampa il messaggio.

exit:
    li    $v0, 10                   # Carica il codice della syscall 'exit'.
    syscall                         # Exit.
#endregion


#region Functions
#
# Controlla se un valore e' pari.
#
# Arguments
# 0($sp) = Valore da controllare.
#
# Result
# $v0 = 0x0  Se il valore e' pari.
# $v0 = 0x1  Se il valore e' dispari.
#
setOnEven:
    lw    $t0, 0($sp)               # Pop del valore dallo stack.
    addi  $sp, $sp, 4               # Incrementa lo stack pointer di 4.

    andi  $v0, $t0, 0x1             # L'operazione di AND tra ($t0) e (0x1) restituisce 0 se l'ultimo
                                    # bit di $t0 vale 0 ($t0 pari), altrimenti 1 ($t0 dispari).
    xori  $v0, $v0, 0x1             # Nega il risultato dell'operazione precedente, poiche' si vuole
                                    # che il valore di ritorno sia 1 quando il valore e' pari.
se_return:
    jr    $ra                       # Torna al chiamante.
#endregion
