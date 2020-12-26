# Automatic_Seller_Machine_MIPS32
Assembly of software programmed for 32-bit MIPS processor, which controls a vending machine in Brazil. This activity is an academic work.

## Problem Description
Develop software for a product vending machine, whose hardware is based on MIPS 32 bits. The requirements are as follows:
* The system should inform the machine's display of the amount of money inserted;
* The system should inform on the machine's display the price of the selected product;
* The system should inform on the machine's display the change value;
* The system should calculate the quantity of each banknote and currency that must be provided as change, optimizing so that    the quantity of the banknote / currency is the minimum possible (always supply as much change as possible the highest amount of banknotes and coins).
* The system should display the output following the format:
    Valor pago: R$XX,XX
    Valor do produto selecionado: R$XX,XX
    Troco: R$XX,XX

## Assembly Specifications
### Number of Banknotes and Coins:
The machine has hardware for receiving and counting banknotes and coins, and stores the counting result in the MIPS processor registers. The table with the description of each register used follows:

Register | Descrição
---------|-----------
$s0      | amount of R$ 20.00 banknotes inserted.
$s1      | amount of R$ 10.00 banknotes inserted.
$s2      | amount of R$ 5.00 banknotes inserted.
$s3      | amount of R$ 2.00 banknotes inserted.
$s4      | amount of R$ 1.00 coins inserted.
$s5      | amount of R$ 0.50 coins inserted.
$s6      | amount of R$ 0.25 coins inserted.
$s7      | amount of R$ 0.10 coins inserted.

### Value of Selected Product:
After a customer selects the desired product, its price is stored, by the hardware, in a processor register. The register used for this is $t9.
Attention: The register $t9 stores the product value multiplied by 100. This means that if the product costs R$ 3.50 the value stored in $t9 will be 350. This is done so that there is no need to work with a floating point.

### Parameters for Change:
When the program finishes its execution, the hardware that separates the change will check the amount of notes and coins that it should provide as change, investigating the status of the registrars according to the following table:

Register | Descrição
---------|-----------
$s0      | amount of banknotes of R$ 20.00 for change.
$s1      | amount of banknotes of R$ 10.00 for change.
$s2      | amount of banknotes of R$ 5.00 for change.
$s3      | amount of banknotes of R$ 2.00 for change.
$s4      | amount of banknotes of R$ 1.00 for change.
$s5      | amount of coins of R$ 0.50 for change.
$s6      | amount of coins of R$ 0.25 for change.
$s7      | amount of coins of R$ 0.10 for change.
$t9      | amount of coins of R$ 0.05 for change.

### Data Output:
The machine implements the same system calls available for use in the QtSpim simulator (see Development Environment topic), and to write messages on the machine's display, the system calls they write on the simulator console must be used.

### Exception Handling:
The only exception that the software should handle, is if the amount entered for payment is lower than the price of the product, the message “Valor insuficiente para compra.” (translating into english, "Insufficient amount to purchase.") should be shown on the display, and registers $ s0 to $ s7 must not be changed. In this case, register $t0 should return the value 1.

### If There Are No Exceptions (Happy Path):
If the amount entered is sufficient to make the purchase, the register $t0 should return 0. In addition, a message should be shown on the display informing the amount entered, the price of the selected product and the change amount following the format previously presented.

## Development Environment
The software was developed using VSCode. Its execution took place using the QtSpim simulator.