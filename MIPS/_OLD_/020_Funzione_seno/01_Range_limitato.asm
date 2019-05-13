.data
.include      "sintable.asm"
msg: .asciiz  "Digitare un numero reale positivo.\n"

.text
#region Main
main:
    li    $v0, 4                     # Carica la syscall print_string.
    la    $a0, msg                   # Prepara il messaggio per essere stampato
    syscall                          # Stampa il messaggio.

    li    $v0, 6                     # Carica la syscall read_float
    syscall                          # Legge un float e lo salva in $f0.

    jal sin                          # Chiama sin.

    li    $v0, 2                     # Carica la syscall print_float.
    syscall                          # Stampa il risultato.

exit:
    li    $v0, 10                    # Carica la syscall exit.
    syscall                          # Termina l'esecuzione.
#endregion


#region Methods
sin:
    la         $t1, sintable         # *p = sintable[] ($t1 punta all'array sintable).
    l.s        $f1, x0               # $f1 = x0
    l.s        $f2, xstep            # $f2 = xstep

    sub.s      $f3, $f0, $f1         # $f3 = a = x - x0
    div.s      $f3, $f3, $f2         # $f3 = a / xstep

    floor.w.s  $f3, $f3              # $f3 = floor($f3).
    mfc1       $t0, $f3              # Recupera il valore (che ora e' da intendersi come intero) 
                                     # dal registro $f3 del coprocessore 1.
    sll        $t0, $t0, 2           # Moltiplica per 4 il valore.
    add        $t1, $t1, $t0         # Incrementa il puntatore del valore (raggiungendo l'elemento
                                     # della sintable corretto).
    lw         $t2, 0($t1)           # Carica il risultato nel registro $t2.
    mtc1       $t2, $f12             # Sposta il risultato nel registro $f12 del coprocessore 1.

    jr         $ra                   # Restituisce il controllo al chiamante.
#endregion
