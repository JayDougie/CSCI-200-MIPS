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
    create_decimal:
        sll $s2, $s2, 4		#shift register left by 4
        add $s2, $s2, $s1	#add decimal value to register
        j Pushloop
    end:
        #Print new line
        li $v0, 4
        la $a0, newline
        syscall
        #Test if there is a 1 in the highhest bit of the register
        addi $s3,$s3,1			#add 1 to a random register
        sll $s3,$s3,31			#shift the register by 31 so that 0 is in the higest bit
        and $s4,$s2,$s3			#test to see if our register with the decimal has a 1 in the highest bit
        bne $s4, $0, special_print	#if there is a 1 in the highest bit go to the special print
       
        #Print $s2 register which has the decimal
        li $v0, 1
        add $a0, $s2, $zero
        syscall
         
        # Tell the system this is the end of the program
        li $v0, 10
        syscall
    
    special_print:
        li $t3, 10		#Load 10 into a register
        divu $s2, $t3		#Divide our decimal by 10
        mflo $t4		#Move from low
        mfhi $t5		#move from hi    
        
        #Print low register
        li $v0, 1		
        add $a0, $t4, $zero
        syscall
        #print high register
        li $v0, 1
        add $a0, $t5, $zero
        syscall
        
        # Tell the system this is the end of the program
        li $v0, 10
        syscall 