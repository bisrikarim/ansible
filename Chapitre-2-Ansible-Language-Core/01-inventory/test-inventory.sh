#!/bin/bash

# Script de test pour les concepts d'Inventory Ansible
# Ce script démontre les différentes façons d'utiliser l'inventory

echo "🧪 Tests des concepts d'Inventory Ansible"
echo "========================================"

# Vérifier qu'on est dans le conteneur maître
if [ ! -f /etc/ansible/ansible.cfg ]; then
    echo "❌ Ce script doit être exécuté dans le conteneur ansible-master"
    echo "   Utilisez: docker exec -it ansible-master bash"
    exit 1
fi

echo ""
echo "📋 1. Test de l'inventory simple"
echo "--------------------------------"
echo "Commande: ansible all -i hosts --list-hosts"
ansible all -i hosts --list-hosts

echo ""
echo "📋 2. Test de connectivité avec l'inventory simple"
echo "------------------------------------------------"
echo "Commande: ansible all -i hosts -m ping"
ansible all -i hosts -m ping

echo ""
echo "📋 3. Affichage de l'inventory avec groupes"
echo "-------------------------------------------"
echo "Commande: ansible-inventory -i hosts-with-groups --list"
ansible-inventory -i hosts-with-groups --list

echo ""
echo "📋 4. Vue graphique de l'inventory avec groupes"
echo "----------------------------------------------"
echo "Commande: ansible-inventory -i hosts-with-groups --graph"
ansible-inventory -i hosts-with-groups --graph

echo ""
echo "📋 5. Liste des hôtes par groupe"
echo "--------------------------------"
echo "Webservers:"
ansible webservers -i hosts-with-groups --list-hosts

echo ""
echo "Database servers:"
ansible database -i hosts-with-groups --list-hosts

echo ""
echo "📋 6. Test de connectivité par groupe"
echo "------------------------------------"
echo "Test des webservers:"
ansible webservers -i hosts-with-groups -m ping

echo ""
echo "Test des serveurs de base de données:"
ansible database -i hosts-with-groups -m ping

echo ""
echo "📋 7. Affichage des variables d'inventory"
echo "----------------------------------------"
echo "Variables pour node1:"
ansible node1 -i hosts-with-groups -m debug -a "var=hostvars[inventory_hostname]"

echo ""
echo "✅ Tests terminés!"
echo ""
echo "💡 Points clés à retenir:"
echo "   - L'inventory définit les hôtes cibles"
echo "   - On peut organiser les hôtes en groupes"
echo "   - Les variables peuvent être définies par groupe ou globalement"
echo "   - La commande 'ansible-inventory' permet d'analyser l'inventory"
echo "   - La commande 'ansible ... -m ping' teste la connectivité"
