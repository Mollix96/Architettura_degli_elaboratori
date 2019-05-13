.data
message:  .asciiz "Hello, World!\n"

.text
main:
    la    $v0, message      # Carica l'indirizzo di message nel registro $v0.
    addi  $sp, $sp -4       # Decrementa lo stack pointer di 4 byte.
    sw    $v0, 0($sp)       # push(message)
                            # Prepara la chiamata caricando message sullo stack.

    jal   print             # Chiama print.

exit:
    li    $v0, 10           # Prepara la chiamata ad exit.
    syscall                 # Chiama exit.


#
# Funzioni.
#
print:
    lw    $t0, 0($sp)       # $t0 = pop()  ->  $t0 = message;
                            # Rimuove message dallo stack e lo carica nel registro $t0.
    addi  $sp, $sp 4        # Incrementa lo stack pointer di 4 byte.

    add   $a0, $zero, $t0   # Carica message nel registro $a0.
    li    $v0, 4            # Prepara la chiamata a print_string. 
    syscall                 # Stampa il messaggio.

    jr    $ra               # return
