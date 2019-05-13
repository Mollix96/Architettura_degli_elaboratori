.data
args:  .word 10, 20
message:    .asciiz  "Il maggiore tra i due valori e': "

.text
main:
    la    $v0, args                 # array = [10, 20];
                                    # Carica nel registro $t0 l'indirizzo di args.

    addi  $sp, $sp -8               # Decrementa lo stack pointer di 2 * (4 byte).

    lw    $t0, 0($v0)               # a = array[0]
    lw    $t1, 4($v0)               # b = array[1]
    sw    $t0, 0($sp)               # push(array[0])  ->  push(10)
    sw    $t1, 4($sp)               # push(array[1])  ->  push(20)
    jal   print_max                 # Chiama print_max.

exit:
    li    $v0, 10                   # Prepara la chiamata ad exit.
    syscall                         # Chiama exit.


#
# Funzioni.
#
print_max:
                                    # ===== Fetch dei dati dallo stack pointer ===== #
    lw    $t0, 0($sp)               # a = pop()  ->  a = 10
    lw    $t1, 4($sp)               # b = pop()  ->  b = 20
    addi  $sp, $sp 8                # Inrementa lo stack pointer di 2 * (4 byte).

# Stampa il messaggio.
                                    # ============== Stampa (message) ============== #
    li    $v0, 4                    # Prepara la chiamata a print_string.
    la    $a0, message              # Carica nel registro $a0 l'indirizzo di 'message'.
    syscall                         # Stampa il messaggio.

# Stampa il valore.
    li    $v0, 1                    # Prepara la chiamata a print_int per stampare il valore massimo.

    slt   $t3, $t0, $t1             # Carica nel registro $t3, il risultato di (a < b).
    BEGIN_IF:
        beq   $t3, $zero, A_IS_MAX  # Se (b > a)...
        add   $a0, $zero, $t1       # carica b nel registro $a0...
        syscall                     # ...lo stampa...
        jr    $ra                   # ...e restituisce il controllo al chiamante.

    A_IS_MAX:                       # Altrimenti (se a > b)...
        add   $a0, $zero, $t0       # carica a nel registro $a0...
        syscall                     # ...stampa a...
        jr $ra                      # e... restituisce il controllo al chiamante.
    END_IF:
