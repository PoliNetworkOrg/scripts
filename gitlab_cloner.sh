#!/bin/bash

RED='\033[0;31m'
NC='\033[0m'

courses=( AES,aero1y,aero2y,AES1y,AES2y,AES3y,AES_corsi6cfu,space1y,space2y Automazione,automazione1y,automazione2y,automazione3y Chimica,chimica1y,chimica2y,chimica3y Info,info1y,info2y,info3y,CompSc,CompSc1,CompSc2 Electronics,elettronica1y,elettronica2y,elettronica3y Energetica,energetica1y,energetica2y,energetica3y MatNano,matnano1y,matnano2y,matnano3y Meccanica,meccanica1y,meccanica2y,meccanica3y MobilityMD,mobilityMDy1,mobilityMDy2 )

echo -e "${RED}starting work ${NC}"
for i in "${courses[@]}"
do
   IFS="," read -r -a arr <<< "${i}"
   mkdir ${arr[0]}
   cd ${arr[0]}
   for e in "${arr[@]:1}"
     do
     if ls | grep $e -q;
     then
       echo -e "${RED} Repo $e exists ${NC}"
       continue
     fi
     echo -e "${RED}initializing repo for $e ${NC}"
     git clone https://gitlab.com/polinetwork/$e --bare
     mkdir $e
     mkdir $e/.git
     mv $e.git/* $e/.git
     rm -r $e.git
     master=true
     wget https://gitlab.com/polinetwork/$e/-/archive/master/$e-master.zip || master=false
     if master
     then
       unzip $e-master.zip -d $e
       rm $e-master.zip
       cd $e
       mv $e-master/* .
       rm $e-master/ -r
       git config --unset core.bare
       git add .
       git branch --set-upstream-to master
     else
       wget https://gitlab.com/polinetwork/$e/-/archive/main/$e-main.zip
       unzip $e-main.zip -d $e
       rm $e-main.zip
       cd $e
       mv $e-main/* .
       rm $e-main/ -r
       git config --unset core.bare
       git add .
       git branch --set-upstream-to main
     fi
     echo -e "${RED}git successfully initialized with result: ${NC}"
     git status
     sleep 2
     echo -e "${RED}terminating $e${NC}"
     cd ..
   done
   cd ..
done
