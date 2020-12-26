# Automatic_Seller_Machine_MIPS32
Assembly programmed software for the 32-bit MIPS processor, which simulates an automatic vending machine.

## Problem Description
Develop software for a product vending machine, whose hardware is based on MIPS 32 bits. The requirements are as follows:
* The system should inform the machine's display of the amount of money inserted;
* The system should inform on the machine's display the price of the selected product;
* The system should inform on the machine's display the change value;
* The system should calculate the quantity of each banknote and currency that must be provided as change, optimizing so that    the quantity of the banknote / currency is the minimum possible (always supply as much change as possible the highest amount of banknotes and coins).

## Assembly Specifications
### Number of Banknotes and Coins:
The machine has hardware for receiving and counting banknotes and coins, and stores the counting result in the MIPS processor registers. The table with the description of each register used follows:

Registrador | Descrição
----------- |----------

