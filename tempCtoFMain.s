# Filename: tempCtoFMain.s
# Take input of int degrees C, output degrees F. 

.text
.global main
main:
    SUB sp, sp, #4
    STR lr, [sp, #0]

    #Prompt and read
    LDR r0, =prompt
    BL printf
    LDR r0, =format
    LDR r1, =Celsius
    BL scanf
    
    #Multiply by 9, divide by 5, add 32
    #Multiply
    LDR r4, =Celsius
    LDR r4, [r4]
    MOV r1, #9
    MUL r0, r4, r1 // r0 = Celsius * 9

    #Divide
    MOV r1, #5
    BL __aeabi_idiv
    MOV r5, r0 // r5 = quotient

    #Add
    MOV r6, #32
    ADD r0, r5, r6 // r0 = quotient + 32
    MOV r1, r0 // put result in r1

    LDR r0, =output
    BL printf

    LDR lr, [sp, #0]
    ADD sp, sp, #4
    MOV pc, lr
.data
Celsius: .word 0
Fahrenheit:  .word 0
prompt: .asciz "\nEnter Temp in Celsius: "
output: .asciz "\nThat is %d Degrees F\n"
format: .asciz "%d"
