import ufc2x as cpu
import sys
import memory as mem
import clock as clk 
import disk

disk.read('CSW.bin')

clk.start([cpu])

print("Resultado: ", mem.read_word(1))