.data
msg_request:   .asciiz  "Digitare due numeri interi.\n"
msg_first_gt:  .asciiz  "Il primo valore e' il maggiore.\n"
msg_first_le:  .asciiz  "Il primo valore e' minore o uguale al secondo.\n"

.text
#region Main
main:
                                    # Stampa il messaggio di richiesta.
    la    $a0, msg_request          # Carica il messaggio di richiesta.
    li    $v0, 4                    # Carica il codice della syscall 'print_string'.
    syscall                         # Stampa il messaggio di richiesta.

                                    # Legge il primo valore intero.
    li    $v0, 5                    # Carica il codice della syscall 'read_integer'.
    syscall                         # Lettura del valore.
    move  $s0, $v0                  # Salva il valore letto.

                                    # Legge il secondo valore intero.
    li    $v0, 5                    # Carica il codice della syscall 'read_integer'.
    syscall                         # Lettura del valore.
    move  $s1, $v0                  # Salva il valore letto.

                                    # Chiama la funzione 'setOnGreaterThan'.
    addi  $sp, $sp, -8              # Decrementa lo stack pointer di 8 byte (spazio per 2 valori).
    sw    $s0, 0($sp)               # Carica il primo valore sullo stack.
    sw    $s1, 4($sp)               # Carica il secondo valore sullo stack.
    jal   setOnGreaterThan          # $v0 = (a < b).

    move  $t0, $v0                  # Salva il valore di ritorno.

                                    # Stampa il messaggio di risposta in base al
                                    # risultato della chiamata.
    li    $v0, 4                    # Carica il codice della syscall 'print_string'.
    beq   $t0, 0x0, main_first_le   # Se il primo valore NON e' maggiore, salta.

                                    # Se si arriva qui, il primo valore e' maggiore del secondo.
    la    $a0, msg_first_gt         # Carica il messaggio da stampare.
    syscall                         # Stampa il messaggio.
    j     exit                      # Salta al termine del programma.

main_first_le:
    la    $a0, msg_first_le         # Carica il messaggio da stampare.
    syscall                         # Stampa il messaggio.

exit:
    li    $v0, 10                   # Carica il codice della syscall 'exit'.
    syscall                         # Exit.
#endregion


#region Functions
#
# Controlla se il primo valore e' maggiore del secondo.
#
# Arguments
# 0($sp) = Primo valore intero.
# 4($sp) = Secondo valore intero.
#
# Result
# $v0 = 0x0  Se il primo valore e' minore del secondo.
# $v0 = 0x1  Se il primo valore e' maggiore del secondo.
#
setOnGreaterThan:
                                    # Pop dei valori dallo stack.
    lw    $t0, 0($sp)               # Pop del primo valore.
    lw    $t1, 4($sp)               # Pop del secondo valore.
    addi  $sp, $sp, 8               # Incrementa lo stack pointer di 8 byte (pop di 2 valori).

    li    $v0, 0x0                  # Inizializza il valore di ritorno a false.

    beq   $t0, $t1, sgt_return      # Se i due falori sono uguali, restituisce false.

    slt   $t2, $t0, $t1             # Se il primo valore e' il minore, imposta ($t2 = 1)...
    beq   $t2, 0x1, sgt_return      # ...e restituisce false.

                                    # Se si arriva qui, il primo valore e' maggiore del secondo.
    li    $v0, 0x1                  # Imposta il valore di ritorno a 0x1.
sgt_return:
    jr    $ra                       # Torna al chiamante.
#endregion
