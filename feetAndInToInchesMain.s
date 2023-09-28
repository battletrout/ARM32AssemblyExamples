# Filename: feetAndInToInchesMain.s
# Take input of int feet and int inches, output total inches

.text
.global main
main:
    SUB sp, sp, #4
    STR lr, [sp, #0]

    #Prompt and read into Feet, store in r4
    LDR r0, =prompt_a
    BL printf
    LDR r0, =format
    LDR r1, =Feet
    BL scanf
    LDR r4, =Feet
    LDR r4, [r4] // r4 contains feet

    #Prompt and read into Inches, store in r5
    LDR r0, =prompt_b
    BL printf
    LDR r0, =format
    LDR r1, =Inches
    BL scanf
    LDR r5, =Inches
    LDR r5, [r5] //r5 contains the remaining distance in inches

    #Multiply feet * 12
    MOV r1, #12
    MUL r0, r4, r1 // r0 = ft*12

    #Add remaining distance in inches, store in r1
    ADD r1, r0, r5

    LDR r0, =output
    BL printf

    LDR lr, [sp, #0]
    ADD sp, sp, #4
    MOV pc, lr
.data
Inches: .word 0
Feet:  .word 0
prompt_a: .asciz "\nEnter distance in Feet (first): "
prompt_b: .asciz "\nEnter distance in Inches: "
output: .asciz "\nTotal distance is %d Inches\n"
format: .asciz "%d"
