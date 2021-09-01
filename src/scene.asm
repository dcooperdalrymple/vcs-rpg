
BG_P0 = $B6
BG_P1 = $C8
BG_LINES = #8
BG_END  = $C8

ENEMY_H = #12
ENEMY_W = #16
ENEMY_X = #(160-ENEMY_W*3)/2-12

PLAYER_H = #16
PLAYER_W = #8
PLAYER_X = #(160-PLAYER_W*5)/2+12

TEXT_H = #13
TEXT_X = #(160-48)/2

SceneInit:

    SET_POINTER VBlankPtr, SceneVerticalBlank
    SET_POINTER KernelPtr, SceneKernel
    SET_POINTER OverScanPtr, SceneOverScan

    lda #0
    sta AUDV0
    sta AUDV1

    ; load gfx

    lda #<TextGfx
    sta G48
    lda #>TextGfx
    sta G48+1
    lda #<(TextGfx+(TEXT_H))
    sta G48+2
    lda #>(TextGfx+(TEXT_H))
    sta G48+3
    lda #<(TextGfx+(TEXT_H*2))
    sta G48+4
    lda #>(TextGfx+(TEXT_H*2))
    sta G48+5
    lda #<(TextGfx+(TEXT_H*3))
    sta G48+6
    lda #>(TextGfx+(TEXT_H*3))
    sta G48+7
    lda #<(TextGfx+(TEXT_H*4))
    sta G48+8
    lda #>(TextGfx+(TEXT_H*4))
    sta G48+9
    lda #<(TextGfx+(TEXT_H*5))
    sta G48+10
    lda #>(TextGfx+(TEXT_H*5))
    sta G48+11

    rts

SceneVerticalBlank:
    rts

SceneKernel:

    jsr DrawBackground ; 41

    ldx #14
    jsr BlankLines

    jsr DrawEnemy

    ldx #13
    jsr BlankLines

    jsr DrawPlayer

    ldx #12
    jsr BlankLines

    jsr DrawTextBox

    lda #0
    sta WSYNC
    sta COLUBK
    sta COLUP0
    sta COLUP1
    sta COLUPF

    rts

SceneOverScan:
    rts

DrawBackground:

    lda #%00000011 ; reflect
    sta CTRLPF

    lda #BG_P0
    sta COLUP0
    lda #BG_P1
    sta COLUP1

    ldy #BG_LINES-1

.background_loop:

    lda BackdropColors,y
    sta WSYNC
    sta COLUBK

    lda BackdropPF0,y
    sta PF0
    lda BackdropPF1,y
    sta PF1
    lda BackdropPF2,y
    sta PF2

    ldx #4
    jsr BlankLines

    dey
    bpl .background_loop

    sta WSYNC

    lda #0
    sta PF0
    sta PF1
    sta PF2

    lda #BG_END
    sta COLUBK

    rts

DrawEnemy:
    lda #%00000010
    sta NUSIZ0
    sta NUSIZ1

    lda #ENEMY_X
    sta SpritePosX
    lda #ENEMY_X+ENEMY_W/2
    sta SpritePosX+1
    jsr PosObjects

    ldy #ENEMY_H-1

    lda EnemyColor+ENEMY_H-1
    sta COLUP0

.enemy_loop:
    lda EnemyP0,y
    ldx EnemyP1,y
    sta WSYNC
    sta GRP0
    lda EnemyColor,y
    stx GRP1
    sta COLUP1

    sta WSYNC

    dey
    bpl .enemy_loop

    sta WSYNC

    lda #0
    sta GRP0
    sta GRP1
    sta COLUP0
    sta COLUP1

    rts

DrawPlayer:
    lda #%00000011
    sta NUSIZ0
    sta NUSIZ1

    lda #PLAYER_X
    sta SpritePosX
    sta SpritePosX+1
    jsr PosObjects

    ldy #PLAYER_H-1

.player_loop:

    lda PlayerSpriteP0,y
    ldx PlayerColorP0,y
    sta WSYNC
    sta GRP1
    lda PlayerSpriteP1,y
    stx COLUP1
    ldx PlayerColorP1,y
    sta GRP0
    stx COLUP0

    sta WSYNC

    dey
    bpl .player_loop

    sta WSYNC

    lda #0
    sta GRP0
    sta GRP1
    sta COLUP0
    sta COLUP1

    rts

DrawTextBox:

    lda #0
    sta GRP0
    sta GRP1
    sta PF0
    sta PF1
    sta PF2

    ; Setup sprites

    lda #%00000011 ; triple copies
    sta NUSIZ0
    sta NUSIZ1
    sta VDELP0 ; vertical delay
    sta VDELP1

    sta WSYNC

    lda #TEXT_X
    sta SpritePosX+0
    lda #TEXT_X+8
    sta SpritePosX+1
    jsr PosObjects

    ; Draw Border

    lda #$0E
    sta COLUPF
    sta COLUP0
    sta COLUP1

    lda #$FF
    sta WSYNC
    sta PF0
    sta PF1
    sta PF2
    sta WSYNC
    lda #$36
    sta COLUBK
    sta WSYNC
    sta WSYNC

    lda #%00010000
    sta PF0
    lda #0
    sta PF1
    sta PF2
    sta WSYNC
    sta WSYNC
    sta WSYNC

    ; draw gfx
    ldy #TEXT_H-1
    jsr DrawG48

    lda #$34
    sta COLUBK
    ldx #4
    jsr BlankLines
    lda #$32
    sta COLUBK
    ldx #4
    jsr BlankLines

    ; draw border
    lda #$FF
    sta WSYNC
    sta PF0
    sta PF1
    sta PF2
    sta WSYNC
    sta WSYNC
    sta WSYNC

    ; reset

    lda #0
    sta COLUPF
    sta COLUBK
    sta PF0
    sta PF1
    sta PF2
    sta COLUP0
    sta COLUP1
    sta VDELP0
    sta VDELP1

    rts
