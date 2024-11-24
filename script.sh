#!/bin/bash

#Voici le menu d'interaction avec le menu principal

#echo "2. Gestion des logiciels : "
#read VAR
#if [ "$VAR" -eq 2 ]  Utilitaire qui va servir à définir quelle interface on va lancer

 
function interface_utilisateur_logiciel() {
echo "Veuillez choisir une option parmis  : "
echo "1 - Voulez-vous voir l'ensemble des logiciels installés sur le système ?"
echo
echo "2 - Souhaitez-vous installer un nouveau logiciel ?"
echo
echo "3 - Préférez-vous supprimer un logiciel ?"
echo
echo "4 - Revenir au menu principal. "
}

function lister_logiciel() {
echo "1. Préférez-vous lister l'ensemble des logiciels ?"
echo
echo "2. Ou préférez-vous consulter si un logiciel précis est présent ?"
echo
echo "3. Revenir à l'interface précédente. "
read VAR

CONTINUE = true
while $CONTINUE 
do
case $VAR in
1) 
apt list --installed
CONTINUE = false
;;
2)
read -p "Veuillez écrire le nom du logiciel que vous souhaitez consulter : " LOGICIEL
grep -A 5 -i "Package: $LOGICIEL" /var/lib/dpkg/status
if [ $? -ne 0 ]
echo "ERREUR : le $LOGICIEL n'a pas été trouvé, veuillez réessayer."
echo "Peut-être que le logiciel n'est pas installé, n'hésitez pas à consulter la liste complète"
else 
CONTINUE = false
fi
;;
3)
CONTINUE = false
done
}

function installer_logiciel() {
echo "Veuillez choisir votre mode d'installation."
echo
echo "1. Vous souhaitez le faire via dépôts officiels ?"
echo
echo "2. Préférez-vous le faire depuis un fichier source ?"
read VAR

CONTINUE = true
while $CONTINUE
do
case $VAR in
1)
read -p "Entrer le nom du logiciel à installer : " LOGICIEL
echo "Je préfère vous prévenir que si vous êtes simple utilisateur, vous ne pourrez rien installer."
sudo apt update
sudo apt-install $LOGICIEL
if [ $? -ne 0 ]
then
echo "On vous avait dit que vous ne pourriez rien installer"
fi
CONTINUE = false
;;
2)
echo "Pour installer un logiciel via un fichier source, voici les 5 étapes qui vont être réalisés." #Proposer la page --help ici.
echo "Il faudra d'abord télécharger le code source avec un lien HTTP / HTTPS, vous devrez donc nous indiquer le lien."
echo "On va extraire l'archive puis entrer dans le dossier pour compiler le code. On finira pas installer le logiciel."
echo "Veuillez noter qu'il vous faudra des droits admins pour installer le logiciel malgré le fait que les autres étapes vont être faites"
read -p "Veuillez insérer l'URL de téléchargement pour le logiciel à installer : " FICHIER
if [ -f "$FICHIER" ]
then
wget $FICHIER
tar -xzf 





while true
do
interface_utilisateur_logiciel
read VAR

case $VAR in
1) 

*)
echo "ERROR- Veuillez sélectionner un menu valide"



