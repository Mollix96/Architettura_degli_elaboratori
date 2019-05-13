# Stampa a schermo il maggiore tra due valori.

.data
message: .asciiz "Maggiore: "

.text
main:
#
# Stampa il messaggio.
#
	li   $v0, 4                 # Carica il codice della syscall 'print_string'.
	la   $a0, message           # Carica il messaggio da stampare.
	syscall                     # Stampa il messaggio.

#
# Valori da confrontare.
#
	li   $a0, 1
	li   $a1, 2

#
# Confronto.
#
                                # $a0 deve arrivare a contenere il maggiore, che deve essere stampato.
	slt  $t0, $a0, $a1          # Se $a0 < $a1, imposta $t0 a 1.
	beq  $t0, $zero, print_max  # Controlla il contenuto del registro $t0:
							    # - Se vale 0, allora $a0 > $a1  -->  salta.
	                            # - Se vale 1, allora $a0 < $a1

switch:
	add  $a0, $a1, $zero        # Carica il maggiore nel registro $a0
	j    print_max

print_max:
	li   $v0, 1                 # Carica il codice della syscall 'print_integer'.
	syscall                     # Stampa il maggiore.

exit:
	li   $v0, 10                # Carica il codice della syscall 'exit'.
	syscall                     # Chiama exit.
