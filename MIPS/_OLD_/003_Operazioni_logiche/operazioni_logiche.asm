.data
args: .word 2, 10, 15

.text
main:
### CARICAMENTO VARIABILI ###
    la   $t0, args        # Carica, all'interno del registro $t0, l'indirizzo di args.
    lw   $a0, 0($t0)      # a = args[0]  ->  a = 2
    lw   $a1, 4($t0)      # b = args[1]  ->  b = 10
    lw   $a2, 8($t0)      # c = args[2]  ->  c = 15


### AND BITWISE ###
    and  $s0, $a0, $a1    # Carica in $s0 il risultato di $a0 AND $a1 (0010 AND 1010).
    andi $s1, $a2, 0x7    # AND immediate (1111 AND 0111 -> 0111).


### OR BITWISE ###
    or   $s2, $a0, $a1    # Carica in $s2 il risultato di $a0 OR $a1 (0010 OR 1010).
    ori  $s3, $a1, 0xD    # OR immediate (1010 OR 1101 -> 1111).


### NOT ###
                          # in MIPS l'operazione di NOT su una variabile a e' data da
                          # NOT (a OR 0) = (a NOR 0)
    nor  $s4, $a0, $zero  # (a NOR 0) = (NOT a).


### SHIFT A DESTRA ###
    srl  $s5, $a2, 1      # Shift a destra di 1 bit.


## SHIFT A SINISTRA ###
    sll  $s6, $a2, 2      # Shift a sinistra di 2 bit.


### USCITA ###
exit:
    li   $v0, 10          # Carica il codice della syscall exit (10) nel registro $v0.
    syscall               # Chiama exit.
