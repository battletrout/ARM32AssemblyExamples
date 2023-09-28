# Filename: inchesToFtAndInMain.s
# Take input as int number of Inches, output the equivalent in Ft and In

.text
.global main
main:
    SUB sp, sp, #4
    STR lr, [sp, #0]

    #Prompt and read into Inches, store in r5
    LDR r0, =prompt_b
    BL printf
    LDR r0, =format
    LDR r1, =Inches
    BL scanf
    LDR r5, =Inches
    LDR r5, [r5] //r5 contains the total distance in inches

    #Divide by 12 to get feet
    MOV r0, r5
    MOV r1, #12
    BL __aeabi_idiv
    MOV r4, r0 // r4 = feet

    #Get remainder in inches
    MUL r0, r1, r4
    SUB r6, r5, r0


    #Add remaining distance in inches, store in r1
    ADD r1, r0, r5

    LDR r0, =output
    MOV r1, r4
    MOV r2, r6
    BL printf

    LDR lr, [sp, #0]
    ADD sp, sp, #4
    MOV pc, lr
.data
Inches: .word 0
prompt_b: .asciz "\nEnter distance in Inches: "
output: .asciz "\nTotal distance is %d Feet, %d Inches\n"
format: .asciz "%d"
