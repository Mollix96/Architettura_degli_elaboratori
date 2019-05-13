.text
main:
	addi  $s0, $zero, 2    # a = 2

# Chiama la funzione 'increment'.
	add   $a0, $zero, $s0  # Prepara la chiamata a increment copiando a nel registro $a0.
	jal   increment        # Chiama increment sulla variabile a.
	
	add   $s0, $zero, $a0  # a = increment(a)
	                       # Recupera il valore di ritorno di increment e lo copia nel registro
	                       # $s0 (variabile a).

exit:
	addi  $v0, $zero, 10
	syscall


increment:
	addi  $a0, $a0, 1
	jr    $ra               # Return.
