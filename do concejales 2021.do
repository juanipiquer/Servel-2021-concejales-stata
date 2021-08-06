
****Manipulación bases 
cd ""

clear all
import delimited "/Resutlados por mesa concejales.csv"


*Tratamiento bases 2021
rename glosa mesa
rename mesa_electores electores
rename votos_provisorio votos

gen total=.
replace total=1 if strpos(candidato, "Total")
drop if total==1
drop total


split lista
drop  lista
rename lista1 lista

split partido, p("  ")
drop partido_politico
rename partido_politico1 partido

egen tag = tag(candidato)
gen electo1=0
replace electo1=1 if tag==1 & electo==1
rename electo electoorig
rename electo1 electo
replace electo=. if strpos(candidato, "Voto")


replace lista="IND" if lista==""
replace lista="" if strpos(candidato, "Voto")

gen chv=0
replace chv=1 if lista=="ZG"
replace chv=1 if lista=="XK"
replace chv=1 if lista=="ZJ"
replace chv=1 if lista=="YM"

gen evo=0
replace evo=1 if lista=="ZG"

gen pri=0
replace pri=1 if lista=="YM"

gen prep=0
replace prep=1 if lista=="XO"

gen derecha=0 
replace derecha=1 if chv==1 | prep==1

replace lista="rn"   if lista=="XK"
replace lista="udi"  if lista=="ZJ"
replace lista="evo"  if lista=="ZG"
replace lista="pri"  if lista=="YM"
replace lista="prep" if lista=="XO"


gen votoval=votos
replace votoval=0  if strpos(candidato, "Voto")



replace lista="UPA"  if lista=="ZB"
replace lista="PTR"  if lista=="ZR"


replace lista="PHIG"  if lista=="XY"
replace lista="PEV"   if lista=="XZ"

replace lista="FA"    if lista=="XS"
replace lista="CHD"   if lista=="M"

replace lista="PSPPD"   if lista=="YW"
replace lista="PR"      if lista=="ZU"
replace lista="DCCsPRO" if lista=="XU"





/*
gen     frentedigno=0
replace frentedigno=1 if strpos(pacto, "FRENTE AMPLIO")
replace frentedigno=0 if strpos(partido, "FRENTE AMPLIO")

Pa poder hacer esto falta la variable subpacto uwu
*/


***tabs ejemplos
ssc install xtable
tab derecha electo


table region if evo==1 & electoorig==0, c(sum votos) col row


table region derecha, c(sum votov) col row

table region chv if prep!=1 , c(sum votov) col row

table candidato if evo==1 & comuna=="ESTACION CENTRAL", c(sum votos) col row

table lista comuna if derecha==1, c(sum votos) col row

replace comuna="PEÑALOLEN"  if strpos(comuna, "ALOLEN")

table candidato if comuna=="PEÑALOLEN", c(sum votos sum electo) by(pacto) col row con


xtable distrito derecha if electo==1, col row
 
xtable distrito lista if electo==1 & derecha==1, col row


xtable distrito lista if derecha==1, c(sum votoval) col row

xtable distrito derecha, c(sum votoval) con col row

