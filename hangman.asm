.MODEL SMALL
DATA SEGMENT
    Word   DB           'Hello$'
    Target DB           '_____$'
    Guess  DB           '_'
    Length DB           5
    Coreect_gusses DB   0
    Found_letter   DB   0
    Hearts DB           5
    
    Worng_msg DB   10, 13, "You were worng, you have _ hearts left",10, 13, '$'
    Correct_msg DB 10, 13, "Well done", 10, 13, '$' 
DATA ENDS 
CODE SEGMENT    
ASSUME CS:CODE,DS:DATA
INCLUDE lib.inc
start:
    MOV AX, DATA
    MOV DS, AX
 
    
    main_loop:
    ; Start reading letters
    MOV AH, 1
    
    ; Read letter
    INT 21h   
    
   
    MOV Guess, AL

    
    ; Searchs for the letter the user inputed
    
    MOV SI, 0
    LEA SI, Word
    MOV CL, Length
    
    iterate_word:
        ;              
        MOV AL, [SI]  
        CMP AL, Guess
        JNE next_letter
            INC Coreect_gusses
            MOV Found_letter, 1 
            MOV [SI], '_'
            ; Tell the user that he is right 
            MOV AH, 9
            MOV DX, OFFSET Correct_msg
            INT 21h
            ; Show him the correct guesses uptill now
            MOV DX, OFFSET Target
            INT 21h
    
        next_letter:
   

        
        INC SI
        LOOP iterate_word
        
    ; Check if letter found, if not decrease the user's ::Hearts and check if he still alive     
    CMP Found_letter, 1
    JE letter_not_found
         
        DEC Hearts
        
            ; If ::Hearts is 0, exit game   

        CMP Hearts, 0
        JE exit 
        
        ; TODO: Print the current state of the hang man by the ::Hearts
        MOV BH, '0'
        ADD BH, Hearts
        MOV Worng_msg[27], BH  
        MOV AH,9
        MOV DX,OFFSET Worng_msg 
        INT 21h 
                
    letter_not_found:
    MOV Found_letter, 0
    
          
    
    ; Print right answers count
    MOV AH, 2
    MOV DL, Coreect_gusses     
    ADD DL, '0'
    INT 21h     
    
    CMP Coreect_gusses, 4
    JNG main_loop 
    
    
    exit:
    
    MOV AH,4Ch 
    INT 21h 
CODE ENDS
END start