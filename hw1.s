# hw1.s
#
# 이름: 이재우
# 학번: 2012270409
#
# 과제1:
# 정수 배열(연속된 메모리에 저장된 정수들)의 합을 구하는 프로그램 작성
# 수동 반복이 아니라 jump/branch 연산을 이용해 작성할 것

        .data
endl:	.asciiz "\n"
arr:	
	.word	1 # arr 은 크기 10인 정수 배열에 해당
	.word	2
	.word	3
	.word	4
	.word	5
	.word	6
	.word	7
	.word	8
	.word	9
	.word	10


        .text
        .globl main
main:
	move $t0, $zero # t0을 0으로 초기화 (합을 저장할 레지스터)
	la $s0, arr     # s0에 arr 주소값 불러오기


	li $t4, 0
	li $t3, 10
	

Plus:
	lw $t1, 0($s0)
	add $t0, $t0, $t1
	addi $s0, $s0, 4
	addi $t4, $t4, 1

	bne $t4, $t3, Plus
	j Exit

	# print integer value in t0
Exit:
	li $v0, 1       # syscall 1 (print_int)
	move $a0, $t0   # argument: integer 
 	syscall         # print the integer 

	# print a newline charactor
	li $v0, 4       # syscall 4 (print_string)
	la $a0, endl    # argument: string
	syscall         # print the string
        
  	jr $ra          # retrun to caller