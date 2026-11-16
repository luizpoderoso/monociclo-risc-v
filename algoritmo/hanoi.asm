.globl main

.data

origem: .word 3, 2, 1
destino: .space 12
auxiliar: .space 12

.text
main:
	li s11, 1
	la s0, origem # base_origem
	li s1, 2 # i_topo_origem
	la s2, destino # base_destino
	li s3, -1 # i_topo_destino
	la s4, auxiliar # base_auxiliar
	li s5, -1 # i_topo_auxiliar
	addi s6, s1, 1 # n = número de discos
	
	jal hanoi
	
	fim: j fim
	
mover:
	# remove do pino de origem
	slli t0, s1, 2
	add t0, s0, t0
	lw t1, 0(t0)
	# sw zero, 0(t0) # opcional
	addi s1, s1, -1
	
	# adiciona no pino de destino
	addi s3, s3, 1
	slli t0, s3, 2
	add t0, s2, t0
	sw t1, 0(t0)
	
	ret
	
hanoi:
	beq s6, s11, mover

	addi sp, sp, -8
	sw s6, 0(sp)
	sw ra, 4(sp)
	
	mv t0, s2
	mv t1, s3
	mv s2, s4
	mv s3, s5
	mv s4, t0
	mv s5, t1
	
	addi s6, s6, -1
	
	jal hanoi
	
	mv t0, s2
	mv t1, s3
	mv s2, s4
	mv s3, s5
	mv s4, t0
	mv s5, t1
	
	jal mover
	
	mv t0, s0
	mv t1, s1
	mv s0, s4
	mv s1, s5
	mv s4, t0
	mv s5, t1
	
	lw s6, 0(sp)
	addi s6, s6, -1
	
	jal hanoi
	
	mv t0, s0
	mv t1, s1
	mv s0, s4
	mv s1, s5
	mv s4, t0
	mv s5, t1
	
	lw ra, 4(sp)
	addi sp, sp, 8
	
	ret