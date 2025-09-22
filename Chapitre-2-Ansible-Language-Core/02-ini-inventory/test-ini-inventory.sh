#!/bin/bash

# Script de test pour les concepts avancés d'INI Inventory
# Ce script démontre les fonctionnalités avancées du format INI

echo "🧪 Tests des concepts avancés d'INI Inventory"
echo "============================================="

# Vérifier qu'on est dans le conteneur maître
if [ ! -f /etc/ansible/ansible.cfg ]; then
    echo "❌ Ce script doit être exécuté dans le conteneur ansible-master"
    echo "   Utilisez: docker exec -it ansible-master bash"
    echo "   Puis: cd /ansible-workspace/Chapitre-2-Ansible-Language-Core/02-ini-inventory"
    exit 1
fi

echo ""
echo "📋 1. Test des plages d'hôtes (Host Ranges)"
echo "-------------------------------------------"
echo "Fichier: ranges-inventory"
echo ""
echo "🔍 Structure de l'inventory avec plages:"
ansible-inventory -i ranges-inventory --graph

echo ""
echo "🔍 Liste des hôtes du groupe 'all-nodes':"
ansible all-nodes -i ranges-inventory --list-hosts

echo ""
echo "🔍 Test de connectivité avec les plages:"
ansible all-nodes -i ranges-inventory -m ping

echo ""
echo "📋 2. Test des variables par hôte"
echo "--------------------------------"
echo "Fichier: host-variables-inventory"
echo ""
echo "🔍 Variables pour node1:"
ansible-inventory -i host-variables-inventory --host node1

echo ""
echo "🔍 Variables pour node2:"
ansible-inventory -i host-variables-inventory --host node2

echo ""
echo "🔍 Variables pour node3:"
ansible-inventory -i host-variables-inventory --host node3

echo ""
echo "🔍 Test des variables dans les tâches:"
echo "Variables http_port pour les webservers:"
ansible webservers -i host-variables-inventory -m debug -a "var=http_port"

echo ""
echo "Variables db_port pour les databases:"
ansible databases -i host-variables-inventory -m debug -a "var=db_port"

echo ""
echo "📋 3. Test des hôtes dans plusieurs groupes"
echo "------------------------------------------"
echo "Fichier: multiple-groups-inventory"
echo ""
echo "🔍 Structure complète avec groupes multiples:"
ansible-inventory -i multiple-groups-inventory --graph

echo ""
echo "🔍 Hôtes du groupe 'webservers':"
ansible webservers -i multiple-groups-inventory --list-hosts

echo ""
echo "🔍 Hôtes du groupe 'databases':"
ansible databases -i multiple-groups-inventory --list-hosts

echo ""
echo "🔍 Hôtes du groupe 'cache-servers':"
ansible cache-servers -i multiple-groups-inventory --list-hosts

echo ""
echo "🔍 Vérification que node2 est dans plusieurs groupes:"
echo "Node2 dans webservers:"
ansible webservers -i multiple-groups-inventory --list-hosts | grep node2 && echo "✅ Oui" || echo "❌ Non"
echo "Node2 dans databases:"
ansible databases -i multiple-groups-inventory --list-hosts | grep node2 && echo "✅ Oui" || echo "❌ Non"

echo ""
echo "📋 4. Test des groupes de groupes (children)"
echo "-------------------------------------------"
echo ""
echo "🔍 Hôtes du groupe parent 'application-tier':"
ansible application-tier -i multiple-groups-inventory --list-hosts

echo ""
echo "🔍 Hôtes du groupe parent 'data-tier':"
ansible data-tier -i multiple-groups-inventory --list-hosts

echo ""
echo "🔍 Variables héritées du groupe 'application-tier':"
ansible application-tier -i multiple-groups-inventory -m debug -a "var=tier_type"

echo ""
echo "📋 5. Test de connectivité sur tous les inventaires"
echo "-------------------------------------------------"
echo ""
echo "🔍 Test avec ranges-inventory:"
ansible all -i ranges-inventory -m ping --one-line

echo ""
echo "🔍 Test avec host-variables-inventory:"
ansible all -i host-variables-inventory -m ping --one-line

echo ""
echo "🔍 Test avec multiple-groups-inventory:"
ansible all -i multiple-groups-inventory -m ping --one-line

echo ""
echo "📋 6. Comparaison des inventaires"
echo "--------------------------------"
echo ""
echo "🔍 Nombre d'hôtes par inventory:"
echo "ranges-inventory: $(ansible all -i ranges-inventory --list-hosts | wc -l) hôtes"
echo "host-variables-inventory: $(ansible all -i host-variables-inventory --list-hosts | wc -l) hôtes"
echo "multiple-groups-inventory: $(ansible all -i multiple-groups-inventory --list-hosts | wc -l) hôtes"

echo ""
echo "🔍 Nombre de groupes par inventory:"
echo "ranges-inventory:"
ansible-inventory -i ranges-inventory --graph | grep -E '^\s*@' | wc -l | xargs echo "  Groupes:"
echo "host-variables-inventory:"
ansible-inventory -i host-variables-inventory --graph | grep -E '^\s*@' | wc -l | xargs echo "  Groupes:"
echo "multiple-groups-inventory:"
ansible-inventory -i multiple-groups-inventory --graph | grep -E '^\s*@' | wc -l | xargs echo "  Groupes:"

echo ""
echo "✅ Tests terminés!"
echo ""
echo "💡 Points clés à retenir:"
echo "   - Les plages d'hôtes [1:3] génèrent automatiquement des listes"
echo "   - Chaque hôte peut avoir ses propres variables"
echo "   - Un hôte peut appartenir à plusieurs groupes"
echo "   - Les groupes de groupes [:children] créent des hiérarchies"
echo "   - L'outil ansible-inventory aide à analyser la structure"
echo ""
echo "🎯 Prochaine étape: Expérimentez en modifiant les fichiers d'inventory!"
