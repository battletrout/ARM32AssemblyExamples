#
# Program Name: intLoopMain.s
# Date: 20 Aug, 2023
# Purpose: Take int inputs from the user until they enter -1, implement using a loop structure
# Inputs: 
#   -int user_input (iteratively taken until -1 entered)
# Output:
#   -console: count of ints, total sum of ints, average of ints
#

#   Dictionary:
#   r4 : user_input
#   r5 : count of integers
#   r6 : total of integers
#   r7 : average of integers
#   

.global main

.text
main:
    SUB sp, sp, #4
    STR lr, [sp, #0]

    # Initialize user_input, count, total, and avg to 0
    MOV r4, #0
    MOV r5, #0
    MOV r6, #0
    MOV r7, #0

    # Take first input
    # Prompt and read into user_input, store in r4
    LDR r0, =prompt_a
    BL printf
    LDR r0, =format
    LDR r1, =user_input
    BL scanf
    LDR r4, =user_input
    LDR r4, [r4]

    # iterate until user inputs -1
    StartLoop:
    # Check if user entered -1
    CMP r4, #-1
    BEQ EndOutputValues
        # If they did not enter -1:
        # 1. Increment Count
        ADD r5, #1

        # 2. Add input to the total
        ADD r6, r6, r4

        # 3. Calculate average
        # multiply count by 10 into r1
        MOV r2, #10
        MUL r1, r5, r2
        
        # mult total by 10 into r0
        MUL r0, r6, r2

        # divide total*10 / count*10
        BL __aeabi_idiv
        # r0 is average, move to r7
        MOV r7, r0

        # 4. Take next user input
        LDR r0, =prompt_a
        BL printf
        LDR r0, =format
        LDR r1, =user_input
        BL scanf
        LDR r4, =user_input
        LDR r4, [r4]

        # Return to start of loop
        B StartLoop
        
    EndOutputValues:
        # Output Count
        LDR r0, =count_msg
        MOV r1, r5
        BL printf

        # Output Total
        LDR r0, =total_msg
        MOV r1, r6
        BL printf        

        # Output Average
        LDR r0, =avg_msg
        MOV r1, r7
        BL printf

        # Pop stack
        LDR lr, [sp, #0]
        ADD sp, sp, #4
        MOV pc, lr

.data
user_input: .word 0
prompt_a: .asciz "\nInput an integer or -1 to stop: "
count_msg: .asciz "Count: %d \n"
total_msg: .asciz "Total: %d \n"
avg_msg: .asciz "Average: %d \n"
format: .asciz "%d"

# END OF MAIN
