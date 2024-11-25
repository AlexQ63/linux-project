#!/bin/bash

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

CONTINUE=true
while $CONTINUE 
do
case $VAR in
1) 
apt list --installed
CONTINUE=false
;;
2)
read -p "Veuillez écrire le nom du logiciel que vous souhaitez consulter : " LOGICIEL
grep -A 5 -i "Package: $LOGICIEL" /var/lib/dpkg/status
if [ $? -ne 0 ]
then
echo "ERREUR : le $LOGICIEL n'a pas été trouvé, veuillez réessayer."
echo "Peut-être que le logiciel n'est pas installé, n'hésitez pas à consulter la liste complète"
else 
CONTINUE=false
fi
;;
3)
CONTINUE=false
done
}

function installer_logiciel() {
echo "Veuillez choisir votre mode d'installation."
echo
echo "1. Vous souhaitez le faire via dépôts officiels ?"
echo
echo "2. Préférez-vous le faire depuis un fichier source ?"
echo
echo "3. Revenir au menu précédent."
read VAR

CONTINUE=true
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
CONTINUE=false
;;
2)
echo "Pour installer un logiciel via un fichier source, voici les 5 étapes qui vont être réalisés." #Proposer la page --help ici.
echo "Il faudra d'abord télécharger le code source avec un lien HTTP / HTTPS, vous devrez donc nous indiquer le lien."
echo "On va extraire l'archive puis entrer dans le dossier pour compiler le code. On finira pas installer le logiciel."
echo "Veuillez noter qu'il vous faudra des droits admins pour installer le logiciel malgré le fait que certaines étapes vont être faites"
read -p "Veuillez insérer l'URL de téléchargement pour le logiciel à installer : " FICHIER

wget $FICHIER
if [ $? == 0 ]
then
echo "Le téléchargement s'est bien déroulé, la suite va suivre son cours."
else
echo "erreur lors du téléchargement. URL invalide."
CONTINUE=false
fi
NOM_FICHIER=${ FICHIER##*/ } 
#ici, le ##*/ signifie la partie la plus longue incluant jusqu'au dernier / va être supprimer

if [ -f "$FICHIER" ]  #ici on va vérifier que le fichier installé est bien un fichier courant (cad qu'il contient bien que des données bruts)
then
cd ~/bin
tar -xzf $NOM_FICHIER #ici le -xzf extrait les fichiers, les décompresses et nous permet de rentrer un nom fichier.
cd $( ls -d */ | head -n 1 ) #cette commande va lister tous les répertoires et ne garder que la 1ère.
./configure #Script qui est à l'intérieur de chaque package d'installation qui va aider à installer le fichier.
make #make va d'abord compiler le fichier et sudo make install va l'installer.
sudo make install
CONTINUE=false
else
echo "ERROR - Attention, fichier non courant installé."
fi
;;
3)
CONTINUE=false
;;
*)
echo "ERROR - mauvais choix. Veuillez réessayer."
esac
}

function supprimer_logiciel(){
echo "Pour supprimer un logiciel, vous devez avoir les droits admin pour le faire."
read -p "Veuillez préciser le chemin relatif du logiciel à désinstaller : " LOGICIEL
read -p "Êtes-vous sur de vouloir désinstaller ce logiciel ? Yes or No " REPONSE
if [[ $REPONSE=="Yes" && -e ~/bin/$LOGICIEL ]]
then 
sudo apt-get remove $LOGICIEL
fi
}

#Voici le menu d'interaction avec le menu principal
#read VAR
#if [ "$VAR" -eq 2 ]  Utilitaire qui va servir à définir quelle interface on va lancer

echo "2. Gestion des logiciels : "
RETURN=true
while true
do
interface_utilisateur_logiciel
read VAR
case $VAR in
1) 
lister_logiciel
RETURN=false
;;
2)
installer_logiciel
RETURN=false
;;
3)
supprimer_logiciel
RETURN=false
;;
4)
RETURN=false
*)
echo "ERROR- Veuillez sélectionner un menu valide"



