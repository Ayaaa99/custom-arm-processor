import sys
from bitstring import Bits
opcodes = {
    'lsl': 0, 'lsr': 1, 'add': 2, 'and': 3, 'orr': 4, 'eor': 5, 
    'take': 6, 'mov': 7, 'ldr': 8, 'str': 9,  'cmp': 10, 'b': 11,
    'beq': 12, 'bne': 13, 'stop': 14
}
registers = {
    'r0': 0, 'r1': 1, 'r2': 2, 'r3': 3, 'r4': 4, 'r5': 5,
    'r6': 6, 'r7': 7, 'r8': 8,  'r9': 9, 'r10': 10, 'r11': 11,
    'r12': 12, 'r13': 13, 'r14': 14, 'r15': 15
}
LUT = {
    '0': 0, '1': 1, '2': 2, '3': 3, '4': 4, '5': 5, 
    '6': 6, '7': 7, '8': 8, '9': 9, '10': 10, '11': 11,
    '12': 12, '13': 13, '14': 14, '15': 15
}
if __name__ == "__main__":
    args = sys.argv
    if len(args) != 3:
        sys.exit(0);
    with open(args[1], 'r') as programFile, open(args[2], 'w') as machineCodeFile:
        instr = ''
        for i in programFile:
            i = i.split('#', 1)[0]      
            if ':' in i:
                instr = i.split(':', 1)[1]
            else:
                instr = i
            words = instr.split()
            if len(words) == 0:
                pass
            elif len(words) == 1: 
                opcode = opcodes[words[0]]
                machineCodeFile.write(format(1, 'b').zfill(1))
                machineCodeFile.write(format(opcode, 'b').zfill(4))
                machineCodeFile.write(format(0, 'b').zfill(4))
                machineCodeFile.write('\n')
            elif len(words) == 2:
                if words[0] in ['b','bne','beq']:       
                    opcode = opcodes[words[0]]
                    register = LUT[words[1]]
                    machineCodeFile.write(format(1, 'b').zfill(1))
                    machineCodeFile.write(format(opcode, 'b').zfill(4))
                    machineCodeFile.write(format(register, 'b').zfill(4))
                    machineCodeFile.write('\n')
                else:                           
                    if words[0] == 'imm':        
                        machineCodeFile.write(format(0, 'b').zfill(1))
                        imm_num = int(words[1])
                        machineCodeFile.write(format(imm_num, 'b').zfill(8))
                        machineCodeFile.write('\n')
                    else:                     
                        opcode = opcodes[words[0]]
                        register = registers[words[1]]
                        machineCodeFile.write(format(1, 'b').zfill(1))
                        machineCodeFile.write(format(opcode, 'b').zfill(4))
                        machineCodeFile.write(format(register, 'b').zfill(4))
                        machineCodeFile.write('\n')
            else:
                exit(0)

