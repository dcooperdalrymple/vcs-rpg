; All assets used in scene

TextGfx:

    ; 1st column
    .byte $A6
    .byte $A8
    .byte $AC
    .byte $CA
    .byte $06
    .byte $00
    .byte $00
    .byte $6A
    .byte $8A
    .byte $8A
    .byte $CC
    .byte $80
    .byte $60


    ; 2nd column
    .byte $54
    .byte $A4
    .byte $A5
    .byte $46
    .byte $00
    .byte $00
    .byte $00
    .byte $68
    .byte $88
    .byte $CA
    .byte $AD
    .byte $60
    .byte $00


    ; 3rd column
    .byte $40
    .byte $00
    .byte $40
    .byte $40
    .byte $20
    .byte $20
    .byte $00
    .byte $A6
    .byte $A8
    .byte $AC
    .byte $0A
    .byte $26
    .byte $00


    ; 4th column
    .byte $00
    .byte $00
    .byte $00
    .byte $00
    .byte $00
    .byte $00
    .byte $00
    .byte $E0
    .byte $21
    .byte $40
    .byte $80
    .byte $60
    .byte $00


    ; 5th column
    .byte $00
    .byte $00
    .byte $00
    .byte $00
    .byte $00
    .byte $00
    .byte $00
    .byte $D0
    .byte $51
    .byte $D5
    .byte $59
    .byte $40
    .byte $00


    ; 6th column
    .byte $00
    .byte $00
    .byte $00
    .byte $00
    .byte $00
    .byte $00
    .byte $00
    .byte $CA
    .byte $15
    .byte $91
    .byte $51
    .byte $C0
    .byte $00

BackdropColors: ; 8
    .byte $46
    .byte $48
    .byte $58
    .byte $68
    .byte $66
    .byte $76
    .byte $74
    .byte $72

BackdropPF0: ; mirrored, 8 lines
    .byte $F0
    .byte $F0
    .byte $F0
    .byte $F0
    .byte %00110000
    .byte $00
    .byte $00
    .byte $00

BackdropPF1:
    .byte $FF
    .byte %11111110
    .byte %11110000
    .byte %10000000
    .byte $00
    .byte $00
    .byte $00
    .byte $00

BackdropPF2:
    .byte %00000111
    .byte $00
    .byte $00
    .byte $00
    .byte $00
    .byte $00
    .byte $00
    .byte $00

EnemyColor:
    .byte $D2
    .byte $D2
    .byte $D2
    .byte $D2
    .byte $D2
    .byte $FE
    .byte $C2
    .byte $C2
    .byte $C2
    .byte $C2
    .byte $C2
    .byte $C2

EnemyP0:
    .byte $19
    .byte $31
    .byte $32
    .byte $1C
    .byte $0E
    .byte $1F
    .byte $3F
    .byte $70
    .byte $40
    .byte $80
    .byte $00
    .byte $00

EnemyP1:
    .byte $80
    .byte $00
    .byte $20
    .byte $64
    .byte $4C
    .byte $F0
    .byte $E0
    .byte $60
    .byte $38
    .byte $3F
    .byte $36
    .byte $18

PlayerSpriteP0:
    .byte $6C ; shoes
    .byte $24
    .byte $24 ; legs
    .byte $3C ; pants
    .byte $7E ; hands
    .byte $BD
    .byte $BD ; arms
    .byte $7E
    .byte $3C ; shoulder
    .byte $18 ; neck
    .byte $3C
    .byte $54 ; face
    .byte $7C ; hair
    .byte $FE
    .byte $7C
    .byte $7C ; hat

PlayerColorP0:
    .byte $D6 ; shoes
    .byte $94
    .byte $94 ; legs
    .byte $94 ; pants
    .byte $EA ; hands
    .byte $EA
    .byte $EA ; arms
    .byte $EA
    .byte $EA ; shoulder
    .byte $FE ; neck
    .byte $FE
    .byte $FE ; face
    .byte $00 ; hair
    .byte $92
    .byte $92
    .byte $92 ; hat

PlayerSpriteP1:
    .byte $00 ; shoes
    .byte $00
    .byte $00 ; legs
    .byte $00 ; pants
    .byte $42 ; hands
    .byte $81
    .byte $81 ; arms
    .byte $42
    .byte $00 ; shoulder
    .byte $08 ; neck
    .byte $04
    .byte $2C ; face
    .byte $00 ; hair
    .byte $00
    .byte $00
    .byte $00 ; hat

PlayerColorP1:
    .byte $00 ; shoes
    .byte $00
    .byte $00 ; legs
    .byte $00 ; pants
    .byte $FE ; hands
    .byte $E6
    .byte $E6 ; arms
    .byte $E6
    .byte $00 ; shoulder
    .byte $00 ; neck
    .byte $00
    .byte $00 ; face
    .byte $00 ; hair
    .byte $00
    .byte $00
    .byte $00 ; hat
