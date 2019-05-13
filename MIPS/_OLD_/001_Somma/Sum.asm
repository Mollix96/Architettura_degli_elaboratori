# Somma di due o tre interi.
#
# Risultato:
# $s0 contiene la somma dei primi due argomenti.
# $s1 contiene la somma dei tre argomenti.

.data
arguments: .word 3, 4, 7     # Array degli operandi (valori per le variabili a, b e c) (32 bit).

.text
main:
    la  $t0, arguments       # Carica, all'interno del registro $t0, l'indirizzo di (arguments).
    lw  $a0, 0($t0)          # a = arguments[0]  ->  a = 3
                             # Carica, all'interno del registro $a0, il primo operando.
    lw  $a1, 4($t0)          # b = arguments[1]  ->  b = 4
                             # Carica, all'interno del registro $a1, il secondo operando.
    lw  $a2, 8($t0)          # c = arguments[2]  ->  c = 7
                             # Carica, all'interno del registro $a2, il terzo operando.

### ADDIZIONE CON DUE OPERANDI ###
    add $s0, $a0, $a1        # d = a + b
                             # Carica, all'interno del registro $s0, la somma dei contenuti dei registri $a0 e $a1.

### ADDIZIONE CON TRE OPERANDI ###
    add $s1, $a0, $a1        # e = a + b
                             # Carica, all'interno del registro $s1, la somma dei contenuti dei registri $a0 e $a1.
    add $s1, $s1, $a2        # e = e + c
                             # Aggiunge al contenuto del registro $s1, il valore contenuto nel registro $a2.

### USCITA ###
exit:
    li  $v0, 10              # Carica il codice della syscall exit (10) nel registro $v0.
    syscall                  # Chiama exit.
