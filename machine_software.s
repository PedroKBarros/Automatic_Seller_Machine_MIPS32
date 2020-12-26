.data
msg1:   .asciiz "Valor pago: R$"
msg2:   .asciiz "Valor do produto selecionado: R$"
msg3:   .asciiz "Troco: R$"
msg4:   .asciiz "Valor insuficiente para compra"
pula:   .asciiz "\n"
virgula:   .asciiz ","

.text
        .globl main
main:
		#Carregando valores iniciais nos registradores $s0 a $s7 e $t9 para fim de testes:
		
		li $s0, 3
		li $s1, 1
		li $s2, 1
		li $s3, 1
		li $s4, 1
		li $s5, 1
		li $s6, 1
		li $s7, 1
		li $t9, 30
		li $t3, 100
		mult $t9, $t3
		mflo $t9 				#O $t9 representa o valor do produto selecionado x 100

		
		#Calculando valor em reais de notas:
        
		li $t3, 20              #Carregando operador imediato 20 em registrador $t3 para representar as notas de 20 reais
        mult $s0, $t3           #Multiplicando valor em $s0, que contém a qtd de notas de R$ 20,00, por $t3
		mflo $t1                #Movendo o resultado da multiplicação para o registrador $t1

		li $t3, 10				#Carregando operador imediato 10 em registrador $t3 para representar as notas de 10 reais
		mult $s1, $t3			#Multiplicando valor em $s1, que contém a qtd de notas de R$ 10,00, por $t3
		mflo $t2				#Movendo o resultado da multiplicação para o registrador $t2
		add $t1, $t1, $t2		#Adicionando ao valor anterior de $t1, o valor de $t2

        li $t3, 5				#Carregando operador imediato 5 em registrador $t3 para representar as notas de 5 reais
		mult $s2, $t3			#Multiplicando valor em $s2, que contém a qtd de notas de R$ 5,00, por $t3
		mflo $t2				#Movendo o resultado da multiplicação para o registrador $t2
		add $t1, $t1, $t2		#Adicionando ao valor anterior de $t1, o valor de $t2

		li $t3, 2				#Carregando operador imediato 2 em registrador $t3 para representar as notas de 2 reais
		mult $s3, $t3			#Multiplicando valor em $s3, que contém a qtd de notas de R$ 2,00, por $t3
		mflo $t2				#Movendo o resultado da multiplicação para o registrador $t2
		add $t1, $t1, $t2		#Adicionando ao valor anterior de $t1, o valor de $t2

		li $t3, 1				#Carregando operador imediato 1 em registrador $t3 para representar as notas de 1 real
		mult $s4, $t3			#Multiplicando valor em $s4, que contém a qtd de notas de R$ 1,00, por $t3
		mflo $t2				#Movendo o resultado da multiplicação para o registrador $t2
		add $t1, $t1, $t2		#Adicionando ao valor anterior de $t1, o valor de $t2

        li $t3, 100             #Carregando operador imediato 100 em registrador $t3
        mult $t1, $t3           #Multiplicando o valor total em notas, que está em $t1, por 100 para que possamos trabalhar com as moedas como números inteiros
        mflo $t1                #Movendo o resultado da multiplicação para $t1
        
		#Calculando valor de moedas, mas trabalhando com o valor delas x 100 para não utilizar ponto flutuante:
		
		li $t3, 50				#Carregando operador imediato 50 em registrador $t3 para representar as moedas de 50 centavos
		mult $s5, $t3			#Multiplicando valor em $s5, que contém a qtd de moedas de R$ 0,50, por $t3
		mflo $t2				#Movendo o resultado da multiplicação para o registrador $t2
		add $t1, $t1, $t2		#Adicionando ao valor anterior de $t1, o valor de $t2

		li $t3, 25				#Carregando operador imediato 25 em registrador $t3 para representar as moedas de 25 centavos
		mult $s6, $t3			#Multiplicando valor em $s6, que contém a qtd de moedas de R$ 0,25, por $t3
		mflo $t2				#Movendo o resultado da multiplicação para o registrador $t2
		add $t1, $t1, $t2		#Adicionando ao valor anterior de $t1, o valor de $t2

		li $t3, 10				#Carregando operador imediato 10 em registrador $t3 para representar as moedas de 10 centavos
		mult $s7, $t3			#Multiplicando valor em $s7, que contém a qtd de moedas de R$ 0,10, por $t3
		mflo $t2				#Movendo o resultado da multiplicação para o registrador $t2
		add $t1, $t1, $t2		#Adicionando ao valor anterior de $t1, o valor de $t2
		
		beq $t1, $t9, result	#verificando se o valor inserido pelo usuário ($t1) é igual ao valor do produto selecionado ($t9)
		slt $t6, $t9, $t1		#Verificando se o valor do produto selecionado ($t9) é menor do que o valor inserido pelo usuário ($t1)
		beq $t6, $0, exception	#Caso, o registrador $t6 tenha valor 0, significa que $t1 é menor do que $t9. Nesse caso, ocorrerá o desvio para a label 'exception' para tratamento dessa exceção

result:
		#Fluxo para apresentação da saída padrão:

		li $t0, 0 				#Carregando 0 no registrador $t0 para indicar que o valor inserido é suficiente para pagamento do produto selecionado
		
		sub $t4, $t1, $t9		#Calculando troco:

		#Convertendo o valor inserido para um valor com parte inteira e fracionária:

		li $t3, 100
		div $t1, $t3
		mflo $t1
		mfhi $t2

		#Apresentando valor inserido:

		li $v0, 4
		la $a0, msg1
		syscall

		li $v0, 1
		move $a0, $t1
		syscall

		li $v0, 4
		la $a0, virgula
		syscall

		li $v0, 1
		move $a0, $t2
		syscall

		li $v0, 4
		la $a0, pula
		syscall

		#Convertendo o valor do produto selecionado para um valor com parte inteira e fracionária:

		li $t3, 100
		div $t9, $t3
		mflo $t1
		mfhi $t2

		#Apresentando valor do produto selecionado:

		li $v0, 4
		la $a0, msg2
		syscall

		li $v0, 1
		move $a0, $t1
		syscall

		li $v0, 4
		la $a0, virgula
		syscall

		li $v0, 1
		move $a0, $t2
		syscall

		li $v0, 4
		la $a0, pula
		syscall

		#Convertendo o valor do troco para um valor com parte inteira e fracionária:

		li $t3, 100
		div $t4, $t3
		mflo $t1
		mfhi $t2

		#Apresentando valor do troco:

		li $v0, 4
		la $a0, msg3
		syscall

		li $v0, 1
		move $a0, $t1
		syscall

		li $v0, 4
		la $a0, virgula
		syscall

		li $v0, 1
		move $a0, $t2
		syscall

initchange:
		#Inicializando registradores que conterão a quantidade de notas e moedas que deverão ser dadas como troco:

		li $s0, 0
		li $s1, 0
		li $s2, 0
		li $s3, 0
		li $s4, 0
		li $s5, 0
		li $s6, 0
		li $s7, 0
		li $t9, 0

		#Inicializando registradores responsáveis por controlar os loops para calculo da qtd de notas e moedas do troco:

		li $t3, 20 					#notas
		li $t5, 50 					#moedas (tratadas como inteiros, sendo 50 equivalente a R$ 0,50)

loopnotes:
		#Fluxo responsável pelo cálculo de cada nota (e moeda de 1 real) que deverá ser devolvida como troco, considerando dar a menor quantidade de notas e moedas possíveis:

		div $t1, $t3;				#Dividindo $t1 (parte inteira do troco) por $t3 (valor da nota atual) para ver quantas notas de determinado valor deverão ser dadas como troco
		mflo $t4;
		mult $t3, $t4
		mflo $t7
		sub $t1, $t1, $t7			#Subtraindo da parte inteira do troco, o valor que da nota atual que já será dado como troco			

		
		#Definindo qual será a próxima nota (ou moeda de 1 real) e em qual registrador a quantidade de notas, para troco, da nota atual deverá ser colocado:
		
		li $t7, 1
		beq $t3, $t7, condloopnotes1 #Verificando se a nota atual ($t3) é igual a 1 e chamando label correspondente

		li $t7, 2
		beq $t3, $t7, condloopnotes2 #Verificando se a nota atual ($t3) é igual a 2 e chamando label correspondente

		li $t7, 5
		beq $t3, $t7, condloopnotes5 #Verificando se a nota atual ($t3) é igual a 5 e chamando label correspondente

		li $t7, 10
		beq $t3, $t7, condloopnotes10 #Verificando se a nota atual ($t3) é igual a 10 e chamando label correspondente

		li $t7, 20
		beq $t3, $t7, condloopnotes20 #Verificando se a nota atual ($t3) é igual a 20 e chamando label correspondente
		
		j loopcoins					  #Ao final desse loop, o fluxo saltará para o loop responsável pelo cálculos das qtds de cada moeda para troco

condloopnotes1:
		add $s4, $t4, $0				#Atribuindo a qtd de moedas de 1 real que deverão ser dadas como troco, ao registrador $s4
		li $t3, 0						#Atribuindo próximo valor de nota que deverá ser testado. No caso, é zero para que se encerre o loopnotes
		j loopnotes						#Saltando de volta para o loopnotes

condloopnotes2:
		add $s3, $t4, $0				#Atribuindo a qtd de notas de 2 reais que deverão ser dadas como troco, ao registrador $s3
		li $t3, 1						#Atribuindo próximo valor de nota que deverá ser testado.
		j loopnotes						#Saltando de volta para o loopnotes

condloopnotes5:
		add $s2, $t4, $0				#Atribuindo a qtd de notas de 5 reais que deverão ser dadas como troco, ao registrador $s2	
		li $t3, 2						#Atribuindo próximo valor de nota que deverá ser testado.
		j loopnotes						#Saltando de volta para o loopnotes

condloopnotes10:
		add $s1, $t4, $0				#Atribuindo a qtd de notas de 10 reais que deverão ser dadas como troco, ao registrador $s1
		li $t3, 5						#Atribuindo próximo valor de nota que deverá ser testado.
		j loopnotes						#Saltando de volta para o loopnotes

condloopnotes20:
		add $s0, $t4, $0				#Atribuindo a qtd de notas de 20 reais que deverão ser dadas como troco, ao registrador $s0
		li $t3, 10						#Atribuindo próximo valor de nota que deverá ser testado.
		j loopnotes						#Saltando de volta para o loopnotes

loopcoins:

		#Fluxo responsável pelo cálculo de cada moeda que deverá ser devolvida como troco, considerando dar a menor quantidade de moedas possível:

		div $t2, $t5;				#Dividindo $t2 (parte fracionária do troco) por $t5 (valor da moeda atual) para ver quantas moedas de determinado valor deverão ser dadas como troco
		mflo $t4;
		mult $t5, $t4
		mflo $t7
		sub $t2, $t2, $t7			#Subtraindo da parte fracionária do troco, o valor que será dado como troco da moeda atual			

		#Definindo qual será a próxima moeda (desconsiderando a moeda de 1 real, já que ela foi tratada no loop de notas) e em qual registrador a quantidade de moedas, para troco, da moeda atual deverá ser colocado:
		
		li $t7, 5
		beq $t5, $t7, condloopcoins5 #Verificando se a moeda atual ($t5) é igual a 5 e chamando label correspondente

		li $t7, 10
		beq $t5, $t7, condloopcoins10 #Verificando se a moeda atual ($t5) é igual a 10 e chamando label correspondente

		li $t7, 25
		beq $t5, $t7, condloopcoins25 #Verificando se a moeda atual ($t5) é igual a 25 e chamando label correspondente

		li $t7, 50
		beq $t5, $t7, condloopcoins50 #Verificando se a moeda atual ($t5) é igual a 50 e chamando label correspondente
	
		j exit						  #Saindo do loop, saltando para a label 'exit', para encerramento da execução do programa

condloopcoins5:
		add $t9, $t4, $0				#Atribuindo a qtd de moedas de 5 centavos que deverão ser dadas como troco, ao registrador $t9
		li $t5, 0						#Atribuindo próximo valor de moeda que deverá ser testado. No caso, é zero para que se encerre o loopcoins
		j loopcoins						#Saltando de volta para o loopcoins

condloopcoins10:
		add $s7, $t4, $0				#Atribuindo a qtd de moedas de 10 centavos que deverão ser dadas como troco, ao registrador $s7
		li $t5, 5						#Atribuindo próximo valor de moeda que deverá ser testado.
		j loopcoins						#Saltando de volta para o loopcoins

condloopcoins25:
		add $s6, $t4, $0				#Atribuindo a qtd de moedas de 25 centavos que deverão ser dadas como troco, ao registrador $s6
		li $t5, 10						#Atribuindo próximo valor de moeda que deverá ser testado.
		j loopcoins						#Saltando de volta para o loopcoins

condloopcoins50:
		add $s5, $t4, $0				#Atribuindo a qtd de moedas de 50 centavos que deverão ser dadas como troco, ao registrador $s5
		li $t5, 25						#Atribuindo próximo valor de moeda que deverá ser testado.
		j loopcoins						#Saltando de volta para o loopcoins

exception:
		#Fluxo para tratamento da exceção de valor inserido menor do que valor do produto

		li $t0, 1

		li $v0, 4
		la $a0, msg4
		syscall

exit:
	#Fluxo para encerramento do programa