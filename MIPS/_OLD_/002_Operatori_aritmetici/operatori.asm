### OPERATORI ARITMETICI FONDAMENTALI ###
# Esegue addizione, sottrazione, moltiplicazione e divisione fra due valori.
#
### RISULTATI ###
# $s0 contiene $a0 + $a1
# $s1 contiene $a0 - $a1
# $s2 contiene $a0 * $a1
# $s3 contiene i bit piu' "bassi" di $a0 * $a1
# $s4 contiene i bit piu' "alti"  di $a0 * $a1
# $s5 contiene i bit piu' "bassi" di $a0 / $a1
# $s6 contiene i bit piu' "alti"  di $a0 / $a1

.data
arguments: .word 16, 4     # Array degli operandi (valori per le variabili a e b) (32 bit)

.text
main:
    la   $t0, arguments    # Carica, all'interno del registro (t0), l'indirizzo di (arguments).
    lw   $a0, 0($t0)       # a = arguments[0]  ->  a = 16
                           # Carica il primo operando all'interno del registro (a0).
    lw   $a1, 4($t0)       # b = arguments[1]  ->  b = 4
                           # Carica il secondo operando all'interno del registro (a1)
                           # (shift di 4 byte rispetto alla posizione in memoria del primo).


### ADDIZIONE ###
    add  $s0, $a0, $a1     # c = a + b
                           # Salva, all'interno del registro (s0), la somma dei contenuti
                           # dei registri (a0) e (a1).


### SOTTRAZIONE ###
    sub  $s1, $a0, $a1     # d = a - b
                           # Salva, all'interno del registro (s1) il risultato di (a0) - (a1).


### MOLTIPLICAZIONE (pseudo-istruzione) ###
    mul  $s2, $a0, $a1     # e = a * b
                           # Salva, all'interno del registro (s2) il risultato di (a0) * (a1).


### MOLTIPLICAZIONE ###
    mult $a0, $a1          # f = a * b
                           # Moltiplica i contenuti di (a0) e (a1) e divide i bit del risultato fra
                           # i registri (hi) e (lo).
    mflo $s3               # Copia il valore contenuto nel registro (lo) nel registro (s3).
    mfhi $s4               # Copia il valore contenuto nel registro (hi) nel registro (s4).


### DIVISIONE ###
    div  $a0, $a1          # i = a / b
                           # Divide i contenuti di (a0) e (a1) e divide i bit del risultato fra
                           # i registri (hi) e (lo).
    mflo $s5               # Copia il valore contenuto nel registro (lo) nel registro (s3).
    mfhi $s6               # Copia il valore contenuto nel registro (hi) nel registro (s4).


### USCITA ###
exit:
    li   $v0, 10           # Carica il codice della syscall exit (10) nel registro $v0.
    syscall                # Chiama exit.
