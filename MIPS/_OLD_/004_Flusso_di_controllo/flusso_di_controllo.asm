.data
args: .word 2, 10, 10

.text 
main:
	la    $t0, args                # Carica, all'interno del registro $t0, l'indirizzo di args.
	lw    $a0, 0($t0)              # a = args[0]  ->  a = 2
	lw    $a1, 4($t0)              # b = args[1]  ->  b = 10
	lw    $a2, 8($t0)              # c = args[2]  ->  c = 10

### IF - THEN (branch equal) ###
	BEGIN_IF_1:
		beq   $a0, $a1, ELSE_1     # if (a != b) then:
		addi  $s0, $zero, 0x1      # $s0 = 1
	ELSE_1:                        # else:

### IF - THEN (branch NOT equal) ###
	BEGIN_IF_2:
		bne   $a1, $a2, ELSE_2     # if (b == c) then:
		addi  $s1, $zero, 0x1      # $s1 = 1
	ELSE_2:                        # else: do nothing.

### IF - THEN - ELSE ###
	BEGIN_IF_3:
		bne   $a0, $a1, ELSE_3     # if (a == b) then:
		addi  $s2, $zero, 0x1      # $s2 = 1
		j     END_IF_3             # Salta oltre il ramo ELSE
	ELSE_3:                        # Entra nel ramo ELSE:
		addi  $s2, $zero, 0x2      # $s2 = 2
	END_IF_3:

### CICLO ###
	BEGIN_WHILE:
		beq   $a0, $a1, END_WHILE  # Cicla fino a quando $a0 non diventa uguale a $a1.
		addi  $a0, $a0, 1          # Ad ogni iterazione incrementa di 1 $a0.
		j     BEGIN_WHILE          # Ripete il ciclo.
	END_WHILE:

### USCITA ###
exit:
	li    $v0, 10                  # Carica il codice della syscall exit.
	syscall                        # Chiama exit.
