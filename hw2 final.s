# hw2.s
#
# 이름: 이재우 
# 학번: 2012270409
#
# 과제2:
# binomial coefficent (n개에서 k개를 순서없이 선택하는 경우의 수) 
# 수업시간에 다룬 factorial.s 와 마찬가지 방식으로 재귀함수로 구현
#
# C로 작성된 binomial coefficent 재귀함수 예제
#
# int choose(int n, int k) {
#   if (n < k) return 0;
#   if (k < 1) return 1; // k==0
#   return choose(n -1 , k - 1) + choose(n - 1, k);
# }
# int main(void) {
#   int num = fact(10,5);
#   printf("%d\n", n);
#   return 0;
# }
		.data
endl:   .asciiz "\n"

        .text
        .globl main

factorial:
    addi $sp, $sp, -4
    sw $ra, 0($sp)

    li $v0, 1
    li $s0, 1

start:
    beq $s0, $a0, end # n == 1?
    mul $v0, $v0, $a0 # $v0 = $v0 * n
    addi $a0, $a0, -1  # n = n - 1
    j start

end:
    lw $ra, 0($sp)
    addi $sp, $sp, 4
    jr $ra


main:
    li $t0, 10 # $t0 = n
      
    # factorial of n
    move $a0, $t0
    jal factorial
    move $t1, $v0 # $t1 = n!

 	li $t2, 4

    # factorial of k
    move $a0, $t2
    jal factorial
    move $t3, $v0 # $t3 = k!

    sub $a0, $t0, $t2 # $a0 = n - k
    jal factorial
    move $t4, $v0 # $t4 = (n-k)!

    mul $t3, $t3, $t4 # $t3 = k! * (n-k)!
    div $t1, $t1, $t3 # $t1 = n! / (k! * (n-k)!)

    # print integer value in t1
    move $a0, $t1
    li $v0, 1
    syscall

	# print a newline charactor
	li $v0, 4       # syscall 4 (print_string)
	la $a0, endl    # argument: string
	syscall         # print the string
    
	li $v0, 10      # syscall 10 (exit)
	syscall         # 이거 안하면 PC가 다음으로 넘어가서 명령어 없다고 경고문 뜸