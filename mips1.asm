.data
    message: .asciiz "Invalid Hexedecimal number"
    userInput: .space 9
    newline: .asciiz "\n"
.text
    main:
        #Getting user input as text
        li $v0, 8
        la $a0, userInput
        li $a1, 9
        #save string to $t0
        move $t0, $a0
        syscall
