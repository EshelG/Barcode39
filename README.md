# Barcode39
Integrated system which conatins DMA,RAM,INT,stimuli,TIMER
The system should be able to decode an binary string from text file to code39 plain text.

* DISCLAIMER all units name are for illustration purposes only, all rights reserve to INTEL corporation. *
* Code is written by Gal Eshel & Tal Leron *

Units:

Timer (8254)
The timer should collect every 200/400 ms a binary character given by the stimuli.
The timer distinguishes from a narrow bar to a wide bar by sending the bus 4/8 [N/W].

DMA (8237)
the direct memory access unit operates the data transfering from the IO(Timer) peripherial unit into the RAM memory storage
with control signals: DACK,DREQ etc.

RAM (Single port 16 bit)
The memory purpose is to hold the barcode data represented as 4/8 as indicated before.

INTERRUPT (8259)
the INT unit purpose is to tell the CPU(testbench) when the read operation of the barcode is done and send EOP(end of process) to CPU.

Other Units:
AD_LATCH : Demuxing the bus to data and address bus.
BUFFER : the buffer unit purpose is to hold data from the timer to the bus untill DACK received from DMA.

Testbench ( Stimluli)
First step is to send the binary data to RAM memory.
Second step is to collect the data from the RAM memory and decode it with the following algorithm,

The indices which contain 8 [wide bar] of each character is saved.
Then we Compare it to encoded_table to search if it matches.
After finding a match we store the index of encoded_table and export from code39_table the right character.

Assume that The whole barcode is 11 character long which start and end with ASTERICK (*) sign that indicate the START and STOP of barcode information.
