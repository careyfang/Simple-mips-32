# Program prints out first and last name
# Enter an integer (0 to exit)
# Computes Sum, and finds biggest and smallest number.
	
# The data Section
	.data
Name:	.asciiz "My name is xxxxx xxxxx\n"
Task:	.asciiz "Enter an integer (0 to end): "
Sum:	.asciiz "\nTheir sum is: "
Small:	.asciiz "\nThe smallest is: "
Big:	.asciiz "\nThe biggest is: "
		.align 2
	
# The text Section
	.text
	.globl main

main:							
	li $v0, 4
	la $a0, Name			# Load Address
	syscall				# Print name to console
	
	li $v0, 4
	la $a0, Task
	syscall				# Ask the user for input
	
	# Read an integer
	li $v0, 5			# Call code for read integer
	syscall 
	move $t0, $v0
	
	beq $v0, $zero, Result		# Branch if input is 0 (Ask for input again when not 0)
	
	add $t1, $t1, $t0		# Sum the number into $t1
	move $t2, $t0			# Move the smallest number into $t2
	move $t3, $t0			# Move the biggest number into $t3
	
	j L1				# Program jump to L1
	
L2:
	move $t2, $t0			# Move $t0 into $t2
	j L1
	
L3: 
	move $t3, $t0
	
	
L1:							
	# Print Task to console
	li $v0, 4
	la $a0, Task
	syscall				# Ask the user for input
	
	# Read an integer
	li $v0, 5			# Call code for read integer
	syscall

	move $t0, $v0			# Move input to $t0
	beq $v0, $zero, Result		# Branch if input is 0 (Ask for input again when not 0)
	
	add $t1, $t1, $t0		# $t1 = $t1 + $t0 (add with previous integer)	
	
	blt $t0, $t2, L2			# Branch to L2 if $t0 < $t2
					# Keep going if $t2 < $t0
	
	bgt $t0, $t3, L3		# Branch to L3 if $t0 > $t3
	j L1				# Loop to L1


	
Result:
	
	li $v0, 4
	la $a0, Sum				
	syscall				# Print the sum statement
	
	li $v0, 1				
	move $a0, $t1
	syscall				# Print out the sum value
	
	li $v0, 4
	la $a0, Small			
	syscall				# Print the smallest value statement
	
	li $v0, 1
	move $a0, $t2
	syscall				# Print out the smallest value
	
	li $v0, 4
	la $a0, Big				
	syscall				# Print the biggest value statement
	
	li $v0, 1
	move $a0, $t3
	syscall				# Print out the biggest value
	
	# Exit the program
	li $v0, 10
	syscall
