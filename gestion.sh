#!/bin/bash

# Variables
VERSION="1.0"
compteur=0
log_file="log.txt"

# Arguments
if [ "$1" = "-v" ] || [ "$1" = "--version" ]; then
    echo "Version: $VERSION"
    exit 0
fi

if [ "$1" = "-h" ] || [ "$1" = "--help" ]; then
    echo "Script de gestion de fichiers - v$VERSION"
    echo "Utilisation: $0 [OPTIONS]"
    echo ""
    echo "Options:"
    echo "  -h, --help      Affiche ce message d'aide"
    echo "  -v, --version   Affiche la version du script"
    echo ""
    echo "Ce script permet de gérer des fichiers avec les fonctionnalités suivantes:"
    echo "  1. Lister tous les fichiers du dossier courant"
    echo "  2. Créer un nouveau fichier"
    echo "  3. Supprimer un fichier"
    echo "  4. Afficher le contenu d'un fichier"
    echo "  5. Quitter le script"
    exit 0
fi

# Actions
ecrire_log() {
    echo "[$(date)] $1" >> $log_file
}

# Début script
echo "Bienvenue dans le script de gestion de fichiers"
ecrire_log "Démarrage du script"

# Boucle principale
while true; do
    # Menu
    echo ""
    echo "===== MENU ====="
    echo "1. Lister les fichiers"
    echo "2. Créer un fichier"
    echo "3. Supprimer un fichier"
    echo "4. Afficher un fichier"
    echo "5. Quitter"
    echo "Actions effectuées: $compteur"
    echo "================"
    
    # Demande choix
    echo "Votre choix (1-5):"
    read choix
    
    # Traitement choix
    case $choix in
        1)
            echo "Liste des fichiers:"
            ls -l
            compteur=$((compteur+1))
            ecrire_log "Listage des fichiers"
            ;;
        2)
            echo "Nom du fichier à créer:"
            read nom_fichier
            touch $nom_fichier
            echo "Fichier $nom_fichier créé"
            compteur=$((compteur+1))
            ecrire_log "Création fichier $nom_fichier"
            ;;
        3)
            echo "Nom du fichier à supprimer:"
            read nom_fichier
            if test -e $nom_fichier; then
                rm $nom_fichier
                echo "Fichier $nom_fichier supprimé"
                compteur=$((compteur+1))
                ecrire_log "Suppression fichier $nom_fichier"
            else
                echo "Le fichier $nom_fichier n'existe pas!"
                ecrire_log "Erreur: fichier $nom_fichier inexistant"
            fi
            ;;
        4)
            echo "Nom du fichier à afficher:"
            read nom_fichier
            if test -f $nom_fichier; then
                echo "Contenu de $nom_fichier:"
                echo "-----------------------"
                cat $nom_fichier
                echo "-----------------------"
                compteur=$((compteur+1))
                ecrire_log "Affichage fichier $nom_fichier"
            else
                echo "Le fichier $nom_fichier n'existe pas ou n'est pas un fichier!"
                ecrire_log "Erreur: impossible d'afficher $nom_fichier"
            fi
            ;;
        5)
            echo "Au revoir!"
            ecrire_log "Fin du script - $compteur actions effectuées"
            exit 0
            ;;
        *)
            echo "Choix incorrect!"
            ;;
    esac
    
    echo "Appuyez sur Entrée pour continuer..."
    read pause
done
