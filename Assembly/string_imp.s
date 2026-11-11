;by default it will branch to label 'part1'

	j part4 ; part1 or part2 or part3 or part4



buffer	defs 100,0


is		defb	" >> is \0"
andstr  defb    " and \0"
        
strsize		defb	"The length of string >> \0 "
strcmp      defb    "The strings \0" 
equal       defb    " are equal\n\0"
not_equal   defb    " are not equal\n\0"
longest     defb    "Number of characters in the longest word: \0"
index       defb    "Starting index: \0"

        

str1    defb "store\0"
str2    defb "stack\0"
str3	defb "comp15111 \0"
str4	defb "COMP15111 \0"
str5    defb "equal\0"
str6    defb "equals\0"
str7	defb "Fundamentals of Computer Architecture\0"
str8    defb "The quick brown fox jumps over the lazy dog\0"


    align


printstring
    ; assumes a0 (x10) has the address of the msg	
    li   a7, 2		   
    ecall
    jr   ra		



;************************** part 1 **************************
stringLength	

  and  a1, a1, zero           ; len = 0


loop:
    lb   t0, 0[a0]          ; Load byte from address of a0(first char) and store into t0
    beqz t0, done           ; If t0 = 0 then jump to done
    addi a1, a1, 1          ; length = length + 1
    addi a0, a0, 1          ; a0 = a0 + 1(go for next char or element of the array)
    j    loop               ; Jump back to start of loop


done:
    mv   a0, a1             ;copy a1 into a0
    li   a7, 3
    ecall
    li   a0, 10
    li   a7, 0
    ecall
    jr   ra	




;************************** part 2 **************************
stringCmp	

;at the end of this block a1 must contain 1 if the strings 
;are equal, 0 otherwise. You need to write a piece of
;assembly code to check whether the strings pointed by a0 and
;a1 are equal

;your code goes here
    li   a2, 1

loop2:
lb t0, 0[a0]              ;load the first char of 1st string into t0
lb t1, 0[a1]              ;load the first char of 2nd string into t1
bne t0,t1, not_eq         ;if t0 and t1 are NOT equal then go to not_eq
beqz t0, done2
j eq                      ;else jump to eq


addition:
addi a0,a0,1              ;go for the next char of the 1st string
addi a1,a1,1              ;go for the next char of the 2nd string
j loop2                   ;jump back to loop2


not_eq:
   li a2, 0              ;a2 = 0/False
   j done2               ;jump to done2


eq:
   li a2,1               ;a2 = 1/True
   j addition            ;j addition


done2:
    beqz a2, print_not_equal   ; if a2 == 0 -> print "not equal"
    la   a0, equal             ; else load "equal"
    j print


print_not_equal:
    la   a0, not_equal      ; load "not equal"

print:
   li a7,2    ;print the string
   ecall
   jr ra








;************************** part 3 **************************
maxLength

;at the end of


    ; Initialize registers
li t1,0          ;current word length
li t2,0          ;maximum word length
li t3,0          ;current word index
li t4,0          ;starting index of the longest word
li t5,' '        ;space
li t6,0          ; ADDED: starting index of current word


loop3:
lb t0, 0[a0]             ;load the first char of the string
beq t0,t5, compare       ;if it equal to space then go to compare
beqz t0,end_string       ;if it is now equal to 0 then go to end_string
j counter                ;else go to increment again because it is a letter

compare:
blt t2,t1, store         ;if the maximum word length < current word length then store
addi a0,a0,1             ;increment the string by 1
li t1,0                  ;reset word length to 0
addi t6, t3, 1           ;; ADDED: reset current-word starting index
j loop3                  ;jump back to loop

counter:
addi a0,a0,1             ;increment the string by 1 to check the next char
addi t1,t1,1             ;increase the current word length by 1
addi t3,t3,1             ;increase the index number by 1
j loop3                  ;jump back to loop


store:
mv t2,t1                 ;now t2 holds the word with the longest word
mv t4,t6                 ;; ADDED: longest word starts at t6 (start index)
j loop3

end_string:
blt t2, t1, store        ;check again if it less than go to store
mv a0,t2                 ;insert longest word length into a0
mv a1,t4                 ;insert starting index into a1
j print3                 ;jump to print


;do not remove this line
print3:
jr ra                    ;return values


;************************** part 4 ***************************
stringCopy

;Your code goes here replacing the 3 lines given below


copy_first:
    lb t0, 0[a0]                 ; load char from a0
    beqz t0, copy_second         ; if char == 0 -> copy second 
    sb t0, 0[a2]                 ; else store char into a2
    addi a0, a0, 1               ; increment a0 by 1
    addi a2, a2, 1               ; increment a2 by 1
    j copy_first                 ; jump back to loop first again



copy_second:
    lb t0, 0[a1]        ; load char from a1
    sb t0, 0[a2]        ; store char into destination
    beqz t0, done4      ; if char == 0 jump to done4
    addi a1, a1, 1      ; increment a1 by 1
    addi a2, a2, 1      ; increment a2 by 1
    j copy_second       ; jump back to loop second again


done4:
    jr ra               ; return




;***********************************************************
;                      part 5
;***********************************************************
;If the buffer is not big enough to copy or hold string or any other information which exceeds the limit, 
;the write instructions will overflow beyond the buffer which will cause critical issues in codes. RISC-V will
;not forbidden the code, but it will corrupt other strings,saved registers and so on and will start overwritting into
;other data.








;*********************** the various parts ********************
part1
    la   a0, strsize   
    li   a7, 2	
    ecall
    la   a0, str1
    ecall		   
    la   a0, is   
    ecall
    la   a0, str1
    jal stringLength
  

    la   a0, strsize   
    li   a7, 2	
    ecall
    la   a0, str2
    ecall		   
    la   a0, is   
    ecall
    la   a0, str2
    jal stringLength
  
    la   a0, strsize   
    li   a7, 2	
    ecall
    la   a0, str3
    ecall		   
    la   a0, is   
    ecall
    la   a0, str3
    jal stringLength
  
    la   a0, strsize   
    li   a7, 2	
    ecall
    la   a0, str4
    ecall		   
    la   a0, is   
    ecall
    la   a0, str4
    jal stringLength
  
    la   a0, strsize   
    li   a7, 2	
    ecall
    la   a0, str5
    ecall		   
    la   a0, is   
    ecall
    la   a0, str5
    jal stringLength

    la   a0, strsize   
    li   a7, 2	
    ecall
    la   a0, str6
    ecall		   
    la   a0, is   
    ecall
    la   a0, str6
    jal stringLength

    la   a0, strsize   
    li   a7, 2	
    ecall
    la   a0, str7
    ecall		   
    la   a0, is   
    ecall
    la   a0, str7
    jal stringLength

    la   a0, strsize   
    li   a7, 2	
    ecall
    la   a0, str8
    ecall		   
    la   a0, is   
    ecall
    la   a0, str8
    jal stringLength
    
    li   a7, 5
    ecall

part2
    la   a0, strcmp
    li   a7, 2
    ecall
    la   a0, str1
    ecall
    la   a0, andstr
    ecall
    la   a0, str2
    ecall
    la   a0, str1
    la   a1, str2
    jal  stringCmp

    la   a0, strcmp
    li   a7, 2
    ecall
    la   a0, str3
    ecall
    la   a0, andstr
    ecall
    la   a0, str4
    ecall
    la   a0, str3
    la   a1, str4
    jal  stringCmp

    la   a0, strcmp
    li   a7, 2
    ecall
    la   a0, str5
    ecall
    la   a0, andstr
    ecall
    la   a0, str6
    ecall
    la   a0, str5
    la   a1, str6
    jal  stringCmp

    la   a0, strcmp
    li   a7, 2
    ecall
    la   a0, str6
    ecall
    la   a0, andstr
    ecall
    la   a0, str6
    ecall
    la   a0, str6
    la   a1, str6
    jal  stringCmp
    
    
    li   a7, 5
    ecall


part3	
    la   a0, str7
    li   a7, 2
    ecall
    la   a0, 10
    li   a7, 0
    ecall
    la   a0, str7
    jal  maxLength
    mv   a2, a0
    la   a0, longest
    li   a7, 2
    ecall
    mv   a0, a2
    li   a7, 3
    ecall
    li   a0, 10
    li	 a7, 0 
    ecall
    la   a0, index
    li   a7, 2
    ecall
    mv   a0, a1
    li   a7, 3
    ecall
    li   a0, 10
    li   a7, 0
    ecall

    la   a0, str8
    li   a7, 2
    ecall
    la   a0, 10
    li   a7, 0
    ecall
    la   a0, str8
    jal  maxLength
    mv   a2, a0
    la   a0, longest
    li   a7, 2
    ecall
    mv   a0, a2
    li   a7, 3
    ecall
    li   a0, 10
    li	 a7, 0 
    ecall
    la   a0, index
    li   a7, 2
    ecall
    mv   a0, a1
    li   a7, 3
    ecall
    li   a0, 10
    li   a7, 0
    ecall   	

    li   a7, 5
    ecall


part4	
    la   a0, str4
    la   a1, str7
    la   a2, buffer
    jal  stringCopy
    la   a0, buffer
    jal  printstring
  
    li   a7, 5
    ecall


