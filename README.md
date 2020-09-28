# Barcode39
Integrated system which conatins DMA,RAM,INT,stimuli,TIMER


The system should be able to decode an binary string from text file to code39 plain text.

Units:

Timer 
The timer should collect every 200/400 ms a binary character given by the stimuli.
The timer distinguishes from a narrow bar to a wide bar by sending the bus 4/8 [N/W].

DMA 
the direct memory access unit operates the data transfering from the IO(Timer) peripherial unit into the RAM memory storage
with control signals: DACK,DREQ etc.

RAM 
The memory is to hold the barcode data represented as 4/8 as indicated before.

INTERRUPT
the INT unit is to tell the CPU(testbench) when the read operation of the barcode is done and send EOP(end of process) to CPU.

Testbench ( Stimluli)
First step is to send the binary data to RAM memory.
Second step is to collect the data from the RAM memory and decode it with the following algorithm,

The indices which contain 8 [wide bar] of each character is saved.
Then we Compare it to encoded_table to search if it matches.
After finding a match we store the index of encoded_table and export from code39_table the right character.

Assume that The whole barcode is 11 character long which start and end with ASTERICK (*) sign that indicate the START and STOP of barcode information.
