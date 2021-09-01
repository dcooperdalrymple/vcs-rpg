;=======================================
; Global Kernel Subroutines
;=======================================

;=======================================
; PosObject
; ---------
; A - holds the X position of the object
; X - holds which object to position
;   0 = player0
;   1 = player1
;   2 = missile0
;   3 = missile1
;   4 = Ball
;=======================================

PosObject:
    sec
    sta WSYNC
.posobject_divide_loop:
    sbc #15
    bcs .posobject_divide_loop
    eor #7
    REPEAT 4
        asl
    REPEND
    sta.wx HMP0,x
    sta RESP0,x
    rts

;=======================================
; PosObjects
; ----------
; Updates all x positions from ram
;=======================================

PosObjects:
    ldx #4
.posobjects_loop:
    lda XPositions,x
    jsr PosObject
    dex
    bpl .posobjects_loop
    sta WSYNC
    sta HMOVE
    rts

;=======================================
; Random
; ---------
; Uses: A
; Sets 16-bit number in Rand8/16
; Returns: A
;
; Sourced from https://www.randomterrain.com/atari-2600-lets-make-a-game-spiceware-10.html
;=======================================

Random:
    lda Rand8
    lsr
    rol Rand16
    bcc .random_noeor
    eor #$B4
.random_noeor:
    sta Rand8
    eor Rand16
    rts

;=======================================
; BinBcdConvert
; ---------
; Input: A
; Uses: A,X,Y,Temp0/1/2
; Converts binary value to decimal value (BCD)
; Returns: X,Y
; Sourced from http://www.6502.org/source/integers/hex2dec-more.htm
;=======================================

BinBcdConvert:
    sta Temp+0

    clc
    sed                 ; Switch to decimal mode

    lda #0              ; Clear result
    sta Temp+1
    sta Temp+2

    ldx #8              ; Number of source bits
.bin_bcd_convert_bit:
    asl Temp+0          ; Shift out one bit

    lda Temp+1          ; And add into result
    adc Temp+1
    sta Temp+1

    lda Temp+2          ; Propagating any carry
    adc Temp+2
    sta Temp+2

    dex                 ; Repeat for next bit
    bne .bin_bcd_convert_bit

    cld                 ; Back to binary

    ldx Temp+1          ; Load result into registers
    ldy Temp+2

    rts

;=======================================
; BlankLines
; ---------
; X - Number of lines to draw
;
; Uses: A,X
; Draws blank playfield lines
;=======================================

BlankLines:
    ;lda #0
    ;sta PF0
    ;sta PF1
    ;sta PF2

.blank_lines_loop:
    sta WSYNC
    dex
    bne .blank_lines_loop

    rts

;=======================================
; ByteDivide
; ---------
; Input: A - dividend, Y - divisor
; Uses: A,Y,Temp0
; Returns: Y - quotient, A - Remainder
;=======================================

;ByteDivide:
;    sty Temp+0  ; Divisor
;    ldy #0
;    sec
;.byte_divide_1:
;    sbc Temp+0
;    bcc .byte_divide_2  ; if carry cleared, subtraction below 0
;    iny
;    bne .byte_divide_1
;.byte_divide_2:
;    rts

;==============
; DrawG48
; Input: Y = lines-1 to show, G48 = graphics data
; Uses: Y,G48
; Description: 48 pixel graphics
;==============

DrawG48:
    sty Temp+0
    sta WSYNC
.g48_loop:
    ldy Temp+0
    lda (G48),y
    sta GRP0
    sta WSYNC
    lda (G48+$2),y
    sta GRP1
    lda (G48+$4),y
    sta GRP0
    lda (G48+$6),y
    sta Temp+1
    lda (G48+$8),y
    tax
    lda (G48+$A),y
    tay
    lda Temp+1
    sta GRP1
    stx GRP0
    sty GRP1
    sta GRP0
    dec Temp+0
    bpl .g48_loop

    lda #0
    sta GRP0
    sta GRP1
    sta GRP0
    sta GRP1

    rts
