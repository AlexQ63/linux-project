#!/bin/bash

#crontab -u "$USER" -l  permet de lister les contrab de l'utilisateur USER
#crontab -l permet de lister les crontab de l'utilisateur courant.
#Pour voir si un utilisateur existe : on peut faire soit grep $USER /etc/passwd
#Ou alors la commande "getent passwd > dev/null/2>&1" qui fait la même chose.
#La différence est que la première va être uniquement pour le dépôt local et la deuxième va être ambivalente.


function interface_utilisateur_crontab(){
echo "Veuillez choisir une option parmis : "
echo
echo "1. Listez les crontab de l'utilisateur courant"
echo
echo "2. Listez les crontab d'un utilisateur spécifique"
echo
echo "3. Ajouter / Modifier / Supprimer les crontab d'un utilisateur"
echo
}

function lister_contrab(){
echo
echo "Vous avez choisi l'option pour lister les crontab de l'utilisateur courant."
echo "Merci de patienter."
echo ".."
echo "..."
crontab -l
}

function lister_crontab_for_user(){
CONTINUE=true
while $CONTINUE
do
echo
echo "Vous avez choisi l'option pour lister les crontab d'un utilisateur spécifique."
echo
echo "Au risque de vous blesser, il vous faudra être admin pour pouvoir consulter cela."
echo
read -p "Pour continuer l'opération, merci de rentrer un nom d'utilisateur valide : " USER
echo
echo "Très bien. Recherche en cours..."
echo
echo "Utilisateur ..."
if getent passwd "$USER" > /dev/null 2>&1
then
crontab -u "$USER" -l
echo "... trouvé ! veuillez retrouver les crontab associés."
echo "Opération terminé. Fermeture du programme.."
CONTINUE=false
else
echo "...ERROR ! Veuillez choisir un user valide."
echo
read -p "Si vous souhaitez quitter le programme tout de même, n'hésitez pas à nous le signaler (oui ou non) : " VAR
if [[ $(echo "$VAR" | tr '[:upper:]' '[:lower:]') == "oui" ]]
then
CONTINUE=false
fi
fi
done
}

lister_crontab_for_user