# Dato un numero naturale dall'utente, controlla se esso e' primo.
# NON e' ottimizzato.
.data
msg_request:  .asciiz  "Digitare un numero naturale.\n"
msg_success:  .asciiz  " e' un numero primo.\n"
msg_failure:  .asciiz  " NON"

.text
#region Main
main:
    li    $v0, 4                        # Carica la syscall print_string.
    la    $a0, msg_request              # Prepara il primo messaggio per essere stampato.
    syscall                             # Stampa il primo messaggio.

    li    $v0, 5                        # Carica la syscall read_integer.
    syscall                             # Chiama read_integer.
    add   $s0, $v0, $zero               # Salva il numero nel registro $s0.
    addi  $sp, $sp -4                   # Decrementa lo stack pointer di 4 byte.
    sw    $s0, 0($sp)                   # Carica il valore digitato dall'utente sullo stack.

    jal   isPrime                       # Chiama isPrime.
    add   $s1, $v0, $zero               # Recupera il valore di ritorno e lo salva in $s1.

    add   $a0, $s0, $zero               # Carica il numero in $a0 per essere stampato.

    li    $v0, 1                        # Carica la syscall print_integer.
    syscall                             # Stampa il numero.

    li    $v0, 4                        # Carica la syscall print_string.

    IF_PRIME:
        bne   $s1, $zero, ELSE          # Se n e' primo, salta (non stampa il messaggio failure).
        la    $a0, msg_failure          # Prepara il messaggio failure per essere stampato.
        syscall                         # Stampa il messaggio failure.
    ELSE:
        la    $a0, msg_success          # Prepara il messaggio success per essere stampato.
        syscall                         # Stampa il messaggio success.

exit:
    li        $v0, 10                   # Prepara la chiamata a exit.
    syscall                             # Chiama exit.
#endregion


#region Methods
isPrime:
                                        # DATI:
                                        # $t0 = numero da controllare
                                        # $t1 = divisore (attuale, da incrementare ad ogni iterazione)
                                        # $t2 = resto della divisione (numero / divisore)

    lw    $t0, 0($sp)                   # Pop dallo stack del valore da controllare.
    addi  $sp, $sp 4                    # Incrementa lo stack pointer di 4 byte.

                                        # Controlla se il valore passato e' 1.
    li    $v0, 0                        # Inizializza il valore di ritorno a 0 (NON primo).
    beq   $t0, 0x1, return              # Se il numero e' 1, termina (NON primo).

    addi  $t1, $zero, 2                 # Inizializza il divisore a 2.

    BEGIN_WHILE:
        beq   $t1, $t0, END_WHILE       # Cicla fino a quando il divisore non raggiunge n.
        div   $t0, $t1                  # numero / divisore
        mfhi  $t2                       # $t2 = resto.
        BEGIN_IF:
            bne   $t2, $zero, END_IF    # Se il resto della divisione e' diverso da zero, salta.
            li    $v0, 0                # Imposta il valore di ritorno a 0 (il numero NON e' primo).
            jr    $ra                   # return
        END_IF:
        addi  $t1, $t1, 1               # divisore++
        j     BEGIN_WHILE               # Ripete il ciclo.
    END_WHILE:

    li    $v0, 1                        # Imposta il valore di ritorno a 1 (il numero e' primo).

return:
    jr    $ra                           # return
#endregion
