                la      sp, stack_base  ; set sp pointing to the end of our stack
                j       main


print_char      equ     0               ; Define names to aid readability
stop            equ     5
print_str       equ     2
print_no        equ     3

cLF             equ     10              ; Line-feed character

wasborn         defb    "This person was born on ",0
was             defb    "This person was ",0
on              defb    " on ",0
is              defb    "This person is ",0
today           defb    " today!",0
willbe          defb    "This person will be ",0
another         defb    "Another person",10,0

pDay            defw    22              ;  pDay = 22    //or whatever is today's date
pMonth          defw    11              ;  pMonth = 11  //or whatever is this month
pYear           defw    2025            ;  pYear = 2025 //or whatever is this year

stack           defs    100             ; this chunk of memory is for the stack
stack_base                              ; This label is 'just after' the stack space

align

; ============================================================================
;                       printTheDate method goes here
; ============================================================================

printTheDate
                subi    sp, sp, 4       ; opens a space for 4 b
                sw      ra, 0[sp]       ; stores teh return argument on stack

                lw      t0, 12[sp]      ; Load day parameter into t0
                mv      a0, t0          ; Move to a0 for syscall
                li      a7, print_no    ; Syscall number
                ecall                   ; print day

                ; Print '/'
                li      a0, '/'         
                li      a7, print_char
                ecall

                lw      t0, 8[sp]       ; Load month parameter into t0
                mv      a0, t0          ; Move to a0
                li      a7, print_no
                ecall                   ; print month

                li      a0, '/'
                li      a7, print_char
                ecall
                
                lw      t0, 4[sp]       ; Load year parameter into t0
                mv      a0, t0          ; Move to a0
                li      a7, print_no
                ecall                   ; Print year
                
                lw      ra, 0[sp]       ;load the argument from stack into ra
                addi    sp, sp, 4       ;removes the space for 1 argument
                jr      ra              ;return


; ============================================================================
; def printAgeHistory (bDay, bMonth, bYear)
; local variables
;  s0 = year
;  s1 = age
;t0 -> now every register is changed by this register
;t1 this register might be removed as well but I did not(requires 8 registers)
;t2 this register ,ight be removed as well but I did not(requires 8 registers)

printAgeHistory
                subi    sp, sp, 12      ;opens a space for 3 params on stack
                sw      ra, 8[sp]       ; Save return address at offset 8
                
                ;year = bYear + 1
                lw      t0, 12[sp]      ; Load bYear from stack(12)
                addi    t0, t0, 1       ; year = bYear + 1
                sw      t0, 4[sp]       ; Store year at offset 4
                
                ; age = 1
                li      t0, 1           ; age = 1
                sw      t0, 0[sp]       ; store back on stack
                
                ; Print "This person was born on "
                la      a0, wasborn
                li      a7, print_str
                ecall
                
                ; Call printTheDate(bDay, bMonth, bYear)
                addi    sp, sp, -12     ; open space for 3 params
                lw      t0, 24[sp]      ; Load bYear on stack
                sw      t0, 0[sp]       ; Store year parameter on stack(8)
                lw      t0, 28[sp]      ; Load bMonth
                sw      t0, 4[sp]       ; Store month param on stack(4)
                lw      t0, 32[sp]      ; Load bDay param
                sw      t0, 8[sp]       ; Store day param
                jal     printTheDate
                addi    sp, sp, 12      ; remove the space for 3 params
                
                li      a0, cLF
                li      a7, print_char
                ecall

; part 4: while year < pYear or
;                               (year == pYear and bMonth < pMonth) or
;                               (year == pYear and bMonth == pMonth and bDay < pDay):

loop1

                lw      t0, 4[sp]                ; Load year from stack
                lw      a0, pYear                ;load pYear into a0 register
                bne     a0, t0, loop_text        ;if year != pYear then jump to loop_text
                j end1                           ;if they are equal then jump to end1


loop_text
                ; Print "This person was "
                la      a0, was
                li      a7, print_str
                ecall
                
                ; Print age 
                lw      t0, 0[sp]       ; Load age from stack
                mv      a0, t0          ; copy into a0
                li      a7, print_no    ; syscall
                ecall
                
                ; Print " on "
                la      a0, on
                li      a7, print_str
                ecall
;-----------------------------------------------------------------------------
                ; Call printTheDate(bDay, bMonth, year)
                addi    sp, sp, -12     ; open space for 3 params
                lw      t0, 16[sp]      ; Load year from our stack frame
                sw      t0, 0[sp]       ; Store year param
                lw      t0, 28[sp]      ; Load bMonth
                sw      t0, 4[sp]       ; Store month parameter on stack(4)
                lw      t0, 32[sp]      ; Load bDay
                sw      t0, 8[sp]       ; Store day parameter on stack(8)
                jal     printTheDate
                addi    sp, sp, 12      ; remove teh space for 3 params
                
                ; Print newline
                li      a0, cLF
                li      a7, print_char
                ecall
                
                ; year = year + 1 
                lw      t0, 4[sp]       ; Load year
                addi    t0, t0, 1       ; Increment by 1
                sw      t0, 4[sp]       ; Store back
                
                ; age = age + 1
                lw      t0, 0[sp]       ; Load age
                addi    t0, t0, 1       ; Increment by 1
                sw      t0, 0[sp]       ; Store back
                j       loop1

end1
                ; part 4: if (bMonth == pMonth and bDay == pDay)
                lw      t0, 16[sp]      ; Load bMonth
                lw      a0, pMonth      ; Load pMonth
                bne     t0, a0, else1   ; If not equal, go to else1

                lw      t0, 20[sp]      ; Load bDay
                lw      a0, pDay        ; Load pDay
                bne     t0, a0, else1   ; If not equal, go to else1



                ; Print "This person is "
                la      a0, is
                li      a7, print_str
                ecall
                
                ; Print age
                lw      t0, 0[sp]       ; Load age from stack
                mv      a0, t0
                li      a7, print_no
                ecall
                
                ; Print " today!"
                la      a0, today
                li      a7, print_str
                ecall
                
                ; Print newline
                li      a0, cLF
                li      a7, print_char
                ecall
                
                j       end2

else1
                ; Print "This person will be "
                la      a0, willbe
                li      a7, print_str
                ecall
                
                ; Print age
                lw      t0, 0[sp]       ; Load age from stack
                mv      a0, t0
                li      a7, print_no
                ecall
                
                ; Print " on "
                la      a0, on
                li      a7, print_str
                ecall
                
                ; Call printTheDate(bDay, bMonth, year)
                addi    sp, sp, -12     ; open space for 3 params
                lw      t0, 16[sp]      ; Load year
                sw      t0, 0[sp]       ; Store year parameter on stack(0)
                lw      t0, 28[sp]      ; Load bMonth
                sw      t0, 4[sp]       ; Store month parameter on stack(4)
                lw      t0, 32[sp]      ; Load bDay
                sw      t0, 8[sp]       ; Store day parameter on stack(8)
                jal     printTheDate    ; jump and link the printTheDate method
                addi    sp, sp, 12      ; Deallocate params
                
                ; Print newline
                li      a0, cLF
                li      a7, print_char
                ecall

end2
                lw      ra, 8[sp]       ; Restore return address
                addi    sp, sp, 12      ; remove stack frame
                jr      ra              


; def main()
; printAgeHistory(pDay, pMonth, 2000)
; for part1
; pass the arguments to the method

main
                ; printAgeHistory(pDay, pMonth, 2000)
                addi    sp, sp, -12     ; open space for 3 arguments
                li      t0, 2000        ; Load 2000 into t0
                sw      t0, 0[sp]       ; Store bYear on stack(0)
                lw      t0, pMonth      ; Load pMonth into t0
                sw      t0, 4[sp]       ; Store bMonth on stack(4)
                lw      t0, pDay        ; Load pDay into t0
                sw      t0, 8[sp]       ; Store bDay on stack(8)
                jal     printAgeHistory  ;jump and link the printTheDate method
                addi    sp, sp, 12      ; remove the space for 3 params
                
                ; Print "Another person"
                la      a0, another
                li      a7, print_str
                ecall
                
                ; printAgeHistory(23, 12, 2000)
                addi    sp, sp, -12     ; open space for 3 params
                li      t0, 2000        ; Load 2000
                sw      t0, 0[sp]       ; bYear = 2000 on stack
                lw      t0, pMonth      ; Load pMonth into 0
                addi    t0, t0, 1       ;just increase by 1
                sw      t0, 4[sp]       ; bMonth = 12 on stack
                lw      t0, pDay        ; Load pDay in a0
                addi    t0, t0, 1       ;just increase by 1
                sw      t0, 8[sp]       ; bDay = 23 on stack
                jal     printAgeHistory
                addi    sp, sp, 12      ; Deallocate arguments
                
                li      a7, stop        ; exit the program
                ecall
; //end of main
