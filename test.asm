fd010113          	addi	sp,sp,-48
02812623          	sw	s0,44(sp)
03010413          	addi	s0,sp,48
00100793          	li	a5,1
fef42023          	sw	a5,-32(s0)
00200793          	li	a5,2
fef42223          	sw	a5,-28(s0)
00600793          	li	a5,6
fcf42c23          	sw	a5,-40(s0)
00400793          	li	a5,4
fcf42e23          	sw	a5,-36(s0)
fe042423          	sw	zero,-24(s0)
fe042623          	sw	zero,-20(s0)
0400006f          	j	101c4 <main+0x74>
fec42783          	lw	a5,-20(s0)
00279793          	slli	a5,a5,0x2
ff040713          	addi	a4,s0,-16
00f707b3          	add	a5,a4,a5
ff07a703          	lw	a4,-16(a5) 
fec42783          	lw	a5,-20(s0)
00279793          	slli	a5,a5,0x2
ff040693          	addi	a3,s0,-16
00f687b3          	add	a5,a3,a5
fe87a783          	lw	a5,-24(a5)
00f707b3          	add	a5,a4,a5
fef42423          	sw	a5,-24(s0)
fec42783          	lw	a5,-20(s0)
00178793          	addi	a5,a5,1
fef42623          	sw	a5,-20(s0)
fec42703          	lw	a4,-20(s0)
00100793          	li	a5,1
fae7dee3          	bge	a5,a4,10188 <main+0x38>
00000793          	li	a5,0
00078513          	mv	a0,a5
02c12403          	lw	s0,44(sp)
03010113          	addi	sp,sp,48
00008067          	ret