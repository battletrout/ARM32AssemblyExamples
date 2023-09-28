.text
.global main
main:
# Push and pop for program stack
# Put these in every program
    SUB sp, sp, #4
    STR lr, [sp]

    LDR r0, =helloWorld
    BL printf

# Pop program stack
    LDR lr, [sp]
    ADD sp, sp, #4
    MOV pc, lr 
.data
    helloWorld: .asciz "Hello World\n"
#End main
