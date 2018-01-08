# name: 이재우 
# student no: 2012270409
#############################################
.data
m1: .word 1
m2: .word 1
#
.text
main:
	daddi $s1, $zero, m1 #la $s1, m1
	daddi $s2, $zero, m2 #la $s2, m2
	daddi $t7, $zero, 0
	daddi $t8, $zero, 10
loop:
	lw $t1, 0($s1)
	lw $t2, 0($s2)
	daddi $t7, $t7, 1
	nop

	dadd $t0, $t1, $t2

	nop
	sw $t2, 0($s1)       # m1 <- m2
	sw $t0, 0($s2)       # m2 <- m1 + m2
	
	bne $t7, $t8, loop
	halt

############################################################################
#
# 1. Run the assembly in WinMIPS64 with both "Enable Forwarding" and
#    "Enable Branch Target Buffer" in the Configure (Alt-C) menu.
#
#    (1) How many RAW stalls? 
#           1 loop = 2 RAW stall -> 20 RAW stall
#
#    (2) Can you explain where in the code and why the RAW stalls happenned?
#			(1) dadd $t0, $t1, $t2에서 윗줄의 lw $t2, 0($s2)이 완료되지 않았기 때문에 stall.
#			(2) bne $t7, $t8, loop에서 윗줄의 daddi $t7, $t7, 1이 완료되지 않았기 때문에 stall.
#		
#
# 2. Make a separate copy of the code for each (a) and (b) subproblems.
#
#  (a) Copy this code to filename "hw3a.s" and modify it to reduce stalls
#      by reordring some of the instructions without changing the result
#      of the program (i.e., memory values in m1 and m2). For this problem,
#      have both "Enable Forwarding" and "Enable Branch Target Buffer"
#      turned on in the Configure (Alt-C) menu of WinMIPS64.
#
#  (a) Copy this code to filename "hw3b.s" and modify it to reduce stalls
#      as much as possible by reordring the instructions and you can also
#      try to do loop unrolling if ncessary, without changing the result
#      of the program (i.e., memory values in m1 and m2). For this problem,
#      turn OFF "Enable Forwarding" and
#      turn ON "Enable Branch Target Buffer" only.
#
############################################################################