; RPG Scene Test for Atari VCS/2600
; Created by D Cooper Dalrymple 2021 - dcdalrymple.com
; Licensed under GNU LGPL V3.0

    processor 6502
    include "vcs.h"
    include "macro.h"

;================
; Constants
;================

NTSC                = 1
PAL                 = 0
SYSTEM              = NTSC
#if SYSTEM = NTSC
KERNEL_SCANLINES    = #192
KERNEL_TOTAL        = #262
KERNEL_FRAMES       = #60
KERNEL_IMAGE_LINE   = #8
#endif
#if SYSTEM = PAL
KERNEL_SCANLINES    = #242
KERNEL_TOTAL        = #312
KERNEL_FRAMES       = #50
KERNEL_IMAGE_LINE   = #10
#endif
KERNEL_VSYNC        = #3
KERNEL_VBLANK       = #37
KERNEL_OVERSCAN     = #30
KERNEL_WIDTH        = #40*8
KERNEL_HBLANK       = #68

KERNEL_IMAGE_MIRROR_DATA   = #3
KERNEL_IMAGE_FULL_DATA = #6
KERNEL_IMAGE_SIZE   = #24

;================
; Variables
;================

    SEG.U vars
    org $80

; Global

Temp                ds 4
Rand8               ds 1
Rand16              ds 1

VBlankPtr           ds 2
KernelPtr           ds 2
OverScanPtr         ds 2

Frame               ds 1
FrameTimer          ds 2
InputState          ds 2

AudioStep           ds 1
SampleStep          ds 1

; Object X Positions

XPositions:
SpritePosX          ds 2 ; 0/1
MisslePosX          ds 2 ; 2/3
BallPosX            ds 1 ; 4

; Graphics

G48                 ds 12

    SEG
    org $F000           ; Start of cart area

    include "assets.asm"
    include "routines.asm"

InitSystem:

.init_clean:
    ; Resets RAM, TIA registers, and CPU registers
    CLEAN_START

.init_seed:
    ; Seed the random number generator
    lda INTIM       ; Unknown value
    sta Rand8       ; Use as seed
    eor #$FF        ; Flip bits
    sta Rand16      ; Just in case INTIM was 0

.init_game:

    jsr SceneInit

;=======================================
; Game Kernel
;=======================================

Main:

    jsr VerticalSync
    jsr VerticalBlank
    jsr Kernel
    jsr OverScan
    jmp Main

VerticalSync:

    lda #0
    sta VBLANK

    ; Turn on Vertical Sync signal and setup timer
    lda #2
    sta VSYNC

    ; Increment frame count and reduce frame counter
    inc Frame
    dec FrameTimer
    dec FrameTimer+1

    ; VSYNCH signal scanlines
    REPEAT #KERNEL_VSYNC
        sta WSYNC
    REPEND

    ; Turn off Vertical Sync signal
    lda #0
    sta VSYNC

.vsync_return:
    rts

VerticalBlank:
    ; Setup Timer
    lda #44 ; KERNEL_VBLANK*76/64
    sta TIM64T

.vblank_logic:
    ; Perform Game Logic
    jsr .vblank_logic_call_ptr

.vblank_loop:
    ; WSYNC until Timer is complete
    sta WSYNC
    lda INTIM
    bne .vblank_loop

.vblank_return:
    rts

.vblank_logic_call_ptr:
    jmp (VBlankPtr)

Kernel:

    ; Perform Selected Kernel
    jsr .kernel_call_ptr
    rts

.kernel_call_ptr:
    jmp (KernelPtr)

OverScan:

    ; End of screen, enter blanking
    lda #%01000010
    sta VBLANK

    ; Setup Timer
    lda #36 ; KERNEL_OVERSCAN*76/64
    sta TIM64T

.overscan_reset:
    ; Check for reset switch
    lda SWCHB
    lsr                     ; Push D0 to carry (C)
    bcs .overscan_logic     ; If D0 is set, no reset

    ; Perform reset
    jsr SceneInit
    jmp .overscan_loop

.overscan_logic:
    ; Perform OverScan Logic
    jsr .overscan_logic_call_ptr

.overscan_loop:
    ; WSYNC until Timer is complete
    sta WSYNC
    lda INTIM
    bne .overscan_loop

.overscan_return:
    rts

.overscan_logic_call_ptr:
    jmp (OverScanPtr)

;================
; State Code
;================

    include "scene.asm"

;================
; End of cart
;================

    ORG $F7FA ; 2k = $F7FA, 4k = $FFFA

InterruptVectors:

    .word InitSystem    ; NMI
    .word InitSystem    ; RESET
    .word InitSystem    ; IRQ

    END
