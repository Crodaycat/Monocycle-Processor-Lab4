.data 
	vec0: .word 3, 1, 2, 4, 7, 6, -9999
	vec1: .word 9, 4, 7, 5, 3, 2, 8, 6, -9999
	
.text

	replacePairsByOdds:
	
		# Save in stack the previous values of t(0..4).
		addi $sp, $sp, -20
		sw $t0, 0($sp)
		sw $t1, 4($sp)
		sw $t2, 8($sp)
		sw $t3, 12($sp)
		sw $t4, 16($sp)
		
		# Get initial vec0 & vec1
		la $t0, vec0($zero)
		la $t1, vec1($zero)
		
		# Move vec0 1 ahead & test vec1 position
		lw $t2, 0($t1)
		beq $t2, -9999, exitReplace
		addi $t1, $t1, 4
		
		addi $t4, $zero, 1
		
		# Loop through vec0 & replace with vec1
		loopReplace:
			lw $t2, 0($t0)
			lw $t3, 0($t1)
			beq $t2, -9999, exitReplace
			beq $t3, -9999, exitReplace
			bne $t4, 1, continueLoop
			
			sw $t3, 0($t0)
			
		continueLoop:
			addi $t0, $t0, 4
			addi $t1, $t1, 4
			mul $t4, $t4, -1
			
			beq $zero, $zero, loopReplace
#			j loopReplace
			
		exitReplace:
			
			# Load previous values of t(0..4) & release stack
			lw $t0, 0($sp)
			lw $t1, 4($sp)
			lw $t2, 8($sp)
			lw $t3, 12($sp)
			lw $t4, 16($sp)
			addi $sp, $sp, 20
			
	# To this point the program is done
	li $v0, 10
	syscall
