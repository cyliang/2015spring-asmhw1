TITLE MASM Template						(main.asm)

; 
;========================================================
; Student Name: Chih-Yung Liang
; Student ID: 0116229
; Email:
;========================================================
; Instructor: Sai-Keung WONG
; Email: cswingo@cs.nctu.edu.tw
; Room: 706
; Assembly Language 
;========================================================
; Description:
;
; 
;
; Revision date:

INCLUDE Irvine32.inc
INCLUDE macros.inc

.data
NUM		DWORD	?

.code
main PROC
	mWriteLn "My Student Name: Chih-Yung Liang"
	mWriteLn "My Student ID: 0116229"
	mWriteLn "My Student Email: XXX"

	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;Input an integer
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
START:
	mWrite "Please enter the number of terms (0-100000): "
	call ReadInt

	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;Exit if 0 is entered
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	cmp eax, 0
	jnz NOT_EXIT
	exit
	
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;Set to 100000 if the number is greater than 100000
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
NOT_EXIT:
	cmp eax, 100000
	jng NOT_EXCEED
	mov eax, 100000


	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;NUM: Save 1, 3, 5, 7, 9...............
	;ECX: Count the term that haven't been computed
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
NOT_EXCEED:
	mWrite "Computing SUM......"
	mov ecx, eax
	mov NUM, 1
	
	finit
	fldz ; Push the sum into the FPU stack

	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;Make one term (1/NUM), accumulate it to sum, and 
	;change the sign of the sum
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
ONE_TERM:
	fld1
	fidiv NUM
	faddp
	fchs

	add NUM, 2
	loop ONE_TERM

	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;st(0) * 4 contains the answer or the negative of the answer.
	;Print out the absolute value of it and loop the program.
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	mov NUM, 4
	fimul NUM
	fabs
	call WriteFloat
	call CRLF
	jmp START

main ENDP

END main