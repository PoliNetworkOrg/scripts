#!/bin/bash

RED='\033[0;31m'
NC='\033[0m'

courses=( Bioinformatics,"Bioinformatics","LM Bioinformatics" Gestionale,"Gestionale","raccolta corso di Gestionale" Gest1y,"Gestionale 1y","Gestionale primo anno LT" Gest2y,"Gestionale 2y","Gestionale secondo anno LT" Gest3y,"Gestionale 3y","Gestionale terzo anno LT" Manag1y,"Management 1y","Management first year LM" Manag2y,"Management 2y","Management second year LM" Mech1y,"Mechanical 1y","Mechanical first year LM" Mech2y,"Mechanical 2y","Mechanical second year LM" DES-Moda,"Design della Moda","raccolta corso di Design della Moda LT" DES-Interni,"Design degli Interni","raccolta corso di Design degli Interni LT" DES-Comm,"Design della Communicazione","raccolta corso di Design della Communicazione LT" DES-Prod,"Design del Prodotto","raccolta corso di Design del Prodotto Industriale LT" )

echo -e "${RED}starting work ${NC}"
for i in "${courses[@]}"
do
   IFS="," read -r -a arr <<< "${i}"
   echo -e "${RED}creating |${arr[0]}| - |${arr[1]}| - |${arr[2]}|${NC}"
   curl --request POST --header "PRIVATE-TOKEN: $1" \
     --header "Content-Type: application/json" --data '{"name": "'"${arr[1]}"'", "description": "'"${arr[2]}"'", "path": "'"${arr[0]}"'", "namespace_id": "4827903", "initialize_with_readme": "true"}' --url 'https://gitlab.com/api/v4/projects/'
   # curl --request PUT --header "PRIVATE-TOKEN: $1" --url https://gitlab.com/api/v4/projects/polinetwork%2F${arr[0]} --data "visibility=public"
   sleep 5
done
