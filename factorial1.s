# factorial.s
#
# factorial 재귀함수 예제
#
# int fact(int n) {
#   if (n == 0) return 1;
#   else return n * fact(n - 1);
# }
# int main(void) {
#   int n = fact(8);
#   printf("%d\n", n);
#   return 0;
# }

        .data
endl:	.asciiz "\n"

        .text
        .globl main

fact:
	addi $sp, $sp, -8 # 스택 포인터를 두word만큼 내림
	sw $a0, 4($sp)    # 내린 그 위치에 하나 위에 $a0 값을 저장
	sw $ra, 0($sp)    # 내린 그 위치에 $ra 값을 저장

	# if ( a0 == 0 ) return 1;
	bne $a0, $zero, factelse
	lw $a0, 4($sp)    # 맨 처음 fact 시작할 때 $a0값 복원
	lw $ra, 0($sp)    # 맨 처음 fact 시작할 때 $ra값 복원
	addi $sp, $sp, 8  # 스택 포인터도 원래 위치로
	li $v0, 1
	jr $ra

factelse:
	# else return a0 * fact(a0 - 1);
	addi $a0, $a0, -1
	jal fact

	lw $a0, 4($sp)    # 맨 처음 fact 시작할 때 $a0값 복원
	lw $ra, 0($sp)    # 맨 처음 fact 시작할 때 $ra값 복원
	addi $sp, $sp, 8  # 스택 포인터도 원래 위치로
	# 리턴값 계산은 복원된 a0 와 v0 의 곱
	mult $a0, $v0
	mflo $v0 # 곱셈결과 32비트만 사용 (더 큰 값은 고려하지 않음)
	jr $ra

main:
	addi $sp, $sp, -4
	sw $ra, 0($sp)

	li $a0, 5
	jal fact
	move $t0, $v0

	# print integer value in t0
	li $v0, 1       # syscall 1 (print_int)
	move $a0, $t0   # argument: integer 
 	syscall         # print the integer 

	# print a newline charactor
	li $v0, 4       # syscall 4 (print_string)
	la $a0, endl    # argument: string
	syscall         # print the string

	lw $ra, 0($sp)
	addi $sp, $sp, 4

  	jr $ra          # retrun to caller