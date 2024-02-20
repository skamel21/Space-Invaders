#######################################
# struct Missile (3 int) :            #
# 1er int : x                         #
# 2eme int : y                        #
# 3eme int : direction (0 bas 1 haut) #
#######################################

.data
# Missiles :
M_couleur: .word 0xFFFFFF
M_vitesse: .word 5
M_hauteur: .word 5
M_largeur: .word 1
M_nb_max: .word 5

.text
##################################################
## Fonction M_creer:                             #
##                                               #
## Entrees :                                     #
##    a0 <- addresse du lanceur de missile       #
##                (spawn du missile)             #
##    a1 <- direction du missile                 # 
##            (bas / haut)                       #
## Sorties : a0 <- tableau du missile            #
##                                               #
## (Creer la struct Missile)                     #
##################################################
M_creer:
    addi sp sp -32
	sw t0 (sp)
	sw t1 4(sp)
	sw t2 8(sp)
	sw t3 12(sp)
	sw t4 16(sp)
	sw t5 20(sp)
	sw t6 24(sp)
	sw ra 28(sp)

    mv t1 a1
    jal I_addr_to_xy
    mv t0 a0
    li a0 12
    li a7 9
    ecall

    sw t0 0(a0) # x
    sw a1 4(a0) # y
    sw t1 8(a0) # direction

	lw t0 (sp)
	lw t1 4(sp)
	lw t2 8(sp)
	lw t3 12(sp)
	lw t4 16(sp)
	lw t5 20(sp)
	lw t6 24(sp)
	lw ra 28(sp)
	addi sp sp 32
    jr ra

##############################################
## Fonction M_afficher:                      #
##                                           #
## Entrees :                                 #
##          a0 <- tableau du missile         #
##                                           #
## Sorties : aucunes                         #
##                                           #
## (Affiche la struct Missile)               #
##############################################
M_afficher:
    addi sp sp -32
	sw t0 (sp)
	sw t1 4(sp)
	sw t2 8(sp)
	sw t3 12(sp)
	sw t4 16(sp)
	sw t5 20(sp)
	sw t6 24(sp)
	sw ra 28(sp)

    mv t0 a0

    lw a0 (t0)
    lw a1 4(t0)
    lw a2 M_largeur
    lw a3 M_hauteur
    lw a4 M_couleur

	# dessiner le missile
    jal I_rectangle

	lw t0 (sp)
	lw t1 4(sp)
	lw t2 8(sp)
	lw t3 12(sp)
	lw t4 16(sp)
	lw t5 20(sp)
	lw t6 24(sp)
	lw ra 28(sp)
	addi sp sp 32
    jr ra

##############################################
## Fonction M_deplacer:                      #
##                                           #
## Entrees :                                 #
##          a0 <- tableau du missile         #
##                                           #
## Sorties : aucunes                         #
##                                           #
## (Deplace la struct Missile)               #
##############################################
M_deplacer:
	addi sp sp -32
	sw t0 (sp)
	sw t1 4(sp)
	sw t2 8(sp)
	sw t3 12(sp)
	sw t4 16(sp)
	sw t5 20(sp)
	sw t6 24(sp)
	sw ra 28(sp)

    # prog
	mv t0 a0 # t0 <- tableau du missile
	lw t1 8(t0) # direction du missile
	beq zero t1 M_deplacer_bas

M_deplacer_haut:
	lw t1 4(t0)
	addi t1 t1 -1 # monter le missile en y
	j Fin_M_deplacer

M_deplacer_bas:
	lw t1 4(t0)
	addi t1 t1 1 # descendre le missile en y
	j Fin_M_deplacer

Fin_M_deplacer:
	sw t1 4(a0)
	lw t0 (sp)
	lw t1 4(sp)
	lw t2 8(sp)
	lw t3 12(sp)
	lw t4 16(sp)
	lw t5 20(sp)
	lw t6 24(sp)
	lw ra 28(sp)
	addi sp sp 32
    jr ra