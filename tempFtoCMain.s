# Filename: tempFtoCMain.s
# Take input of int degrees F, output degrees C. 

.text
.global main
main:
    SUB sp, sp, #4
    STR lr, [sp, #0]

    #Prompt and read
    LDR r0, =prompt
    BL printf
    LDR r0, =format
    LDR r1, =Fahrenheit
    BL scanf

    #Sub 32, Multiply by 5, divide by 9
    LDR r4, =Fahrenheit
    LDR r4, [r4]
    SUB r5, r4, #32 // r0 = Fahrenheit - 32

    #Multiply
    MOV r1, #5
    MUL r0, r5, r1 // r0 = (F-32) * 5

    #Divide
    MOV r1, #9
    BL __aeabi_idiv
    MOV r1, r0 // r5 = quotient

    LDR r0, =output
    BL printf

    LDR lr, [sp, #0]
    ADD sp, sp, #4
    MOV pc, lr
.data
Celsius: .word 0
Fahrenheit:  .word 0
prompt: .asciz "\nEnter Temp in F: "
output: .asciz "\nThat is %d Degrees C\n"
format: .asciz "%d"
