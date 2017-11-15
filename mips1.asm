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
    Pushloop:
        lb $s0, 0($t0)		# Loads current character into $s0
        addi $t0, $t0, 1	# Moves to the next character
        beq $s0, 0, end		# exit if null
        beq $s0, 10, end	#exit if newline character		
        jal checked		# Jumps to checked function
        j Pushloop		

    checked:
        # Check whether character is digit 0-9, lowercase a-f, or uppercase A-F by ascii value
        blt $s0, 48, invalid
        blt $s0, 58, is_number
        blt $s0, 65, invalid
        blt $s0, 71, is_uppercase
        blt $s0, 97, invalid
        blt $s0, 103, is_lowercase
        bgt $s0, 102, invalid
    is_number:
        #Convert asciii num to hex equivalent 
        addi $t1, $s0, -48
        addi $s1, $t1, 0
        j create_decimal
    is_lowercase:
        #Convert asciii num to hex equivalent
        addi $t1, $s0, -97
        addi $s1, $t1, 10
        j create_decimal
    is_uppercase:
        #Convert asciii num to hex equivalent
        addi $t1, $s0, -65
        addi $s1, $t1, 10
        j create_decimal
    invalid:
       #Print invalid message
        li $v0, 4
        la $a0, message
        syscall 