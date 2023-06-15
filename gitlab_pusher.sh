#!/bin/bash

RED='\033[0;31m'
NC='\033[0m'

if [ -z "$1" ]
then
  echo -e "${RED}No password supplied, terminating script.${NC}"
  exit 1
fi

PASSWORD=$1

# URL encode the password
urlencode() {
    # urlencode <string>
    old_lc_collate=$LC_COLLATE
    LC_COLLATE=C

    local length="${#1}"
    for (( i = 0; i < length; i++ )); do
        local c="${1:$i:1}"
        case $c in
            [a-zA-Z0-9.~_-]) printf '%s' "$c" ;;
            *) printf '%%%02X' "'$c"
        esac
    done

    LC_COLLATE=$old_lc_collate
}
ENCODED_PASSWORD=$(urlencode $PASSWORD)

courses=( aes,aero1y,aero2y,AES1y,AES2y,AES3y,AES_corsi6cfu,space1y,space2y automazione,automazione1y,automazione2y,automazione3y chimica,chimica1y,chimica2y,chimica3y info,info1y,info2y,info3y,CompSc,CompSc1,CompSc2 electronics,elettronica1y,elettronica2y,elettronica3y energetica,energetica1y,energetica2y,energetica3y matnano,matnano1y,matnano2y,matnano3y meccanica,meccanica1y,meccanica2y,meccanica3y mobilitymd,mobilityMDy1,mobilityMDy2 bioinformatics,Bioinformatics management,Gest1y,Gest2y,Gest3y,Manag1y,Manag2y mechanical,Mech1y,Mech2y design,DES-Moda,DES-Interni,DES-Comm,DES-Prod )

echo -e "${RED}Starting push to all repos ${NC}"

for i in "${courses[@]}"
do
   IFS="," read -r -a arr <<< "${i}"
   cd ${arr[0]}
   for e in "${arr[@]:1}"
   do
     cd $e
     echo -e "${RED}pushing for $e ${NC}"
     git pull
     git push https://polibot:"$ENCODED_PASSWORD"@gitlab.com/polinetwork/$e.git --all
     cd ..
   done
   cd ..
done

echo -e "${RED}All repos pushed ${NC}"
