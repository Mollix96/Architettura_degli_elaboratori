.data
n1:      .word    0xAB             # Primo valore da confrontare.
n2:      .word    0xCD             # Secondo valore da confrontare.
maxVal:  .word    0x00             # Per salvare il maggiore.
msg:     .asciiz  "Maggiore: "

.text
main:
	lw   $t0, n1                   # Carica il primo valore.
	lw   $t1, n2                   # Carica il secondo valore.
	slt  $t2, $t0, $t1             # $t2 = (n1 < n2)
	beq  $t2, $zero, n1_max        # Se (n1 > n2) salta e stampa n1.

n2_max:                            # Se si arriva qui, allora (n2 >= n1).
	sw   $t1, maxVal               # maxVal = n2
	j    print                     # Salta -> stampa n2.

n1_max:                            # Se si arriva qui, allora (n1 > n2).
	sw   $t0, maxVal               # maxVal = n1

print:                             # Stampa un messaggio seguito dal valore maggiore.
	la   $a0, msg                  # Carica l'indirizzo del messaggio da stampare.
	li   $v0, 0x4                  # Carica il codice della syacall "print_string".
	syscall                        # Stampa il messaggio.

                                   # Stampa il valore maggiore.
	lw   $a0, maxVal               # Carica il maggiore per essere stampato.
	li   $v0, 0x1                  # maxVal = n2
	syscall                        # Stampa il maggiore.

exit:
	li    $v0, 0xA                 # Carica il codice della syacall "exit".
	syscall                        # exit.
