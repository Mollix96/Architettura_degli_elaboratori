.data
message:  .asciiz "Hello, world!\n"

.text
main:
	li  $v0, 4        # Carica nel registro $v0 il codice della chiamata a 'print_string' (4).
	la  $a0, message  # Carica nel registro $a0 l'indirizzo di 'message'.
	syscall           # Chiama print_string.

exit:
	li  $v0, 10       # Carica nel registro $v0 il codice della chiamata a 'exit'.
	syscall           # Chiama exit.
