   addi $t1, $zero, 17
   addi $t9, $zero, 0x6DCE4F55
   ori  $t3, $zero, -1
   sll  $t3, $t3, 16
   ori  $t3, $t3, -1
   sll  $t3, $t3, 2
   ori  $t8, $zero, 1
   sll  $t8, $t8, 16
   sll  $t8, $t8, 15
start:
   andi $s1, $t1, 1
   beq  $s1, $zero, else
   srl  $t9, $t9, 1
   and  $t9, $t9, $t3
   ori  $t9, $t9, 1
   j    ctrl
else:
   srl  $t9, $t9, 1
   or   $t9, $t9, $t8
   sra  $t9, $t9, 1
ctrl:
   addi $t1, $t1, -3
   slt  $s5, $t1, $zero
   bne  $s5, $zero, done
   j    start
done:
   srl $t9, $t9, 2
