target remote localhost:1234
br *0x7c21
set architecture i8086
cont
disp /3i $pc



// x/10i $eip
// x/10i $cs*16+$eip

// disas $pc,+32
// disp /3i $pc