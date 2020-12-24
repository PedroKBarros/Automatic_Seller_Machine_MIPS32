.data
msg1:   .asciiz "Valor pago: R$"
msg2:   .asciiz "Valor do produto selecionado R$"
msg3:   .asciiz "Troco: R$"
msg4:   .asciiz "Valor insuficiente para compra"
pula:   .asciiz "\n"

.text
        .globl main
main:
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