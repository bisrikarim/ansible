#!/bin/bash

# Script de test pour les inventaires YAML
# Démonstration des capacités du format YAML vs INI

echo "🧪 Tests des inventaires YAML - Format moderne"
echo "=============================================="

# Vérifier qu'on est dans le conteneur maître
if [ ! -f /etc/ansible/ansible.cfg ]; then
    echo "❌ Ce script doit être exécuté dans le conteneur ansible-master"
    echo "   Utilisez: docker exec -it ansible-master bash"
    echo "   Puis: cd /ansible-workspace/Chapitre-2-Ansible-Language-Core/03-yaml-inventory"
    exit 1
fi

echo ""
echo "📋 1. Test de l'inventory YAML de base"
echo "-------------------------------------"
echo "Fichier: basic-inventory.yml"
echo ""
echo "🔍 Structure de l'inventory YAML:"
ansible-inventory -i basic-inventory.yml --graph

echo ""
echo "🔍 Test de connectivité avec YAML:"
ansible all -i basic-inventory.yml -m ping --one-line

echo ""
echo "🔍 Variables d'un hôte en YAML:"
ansible-inventory -i basic-inventory.yml --host node1

echo ""
echo "📋 2. Test de l'inventory YAML avancé"
echo "------------------------------------"
echo "Fichier: advanced-inventory.yml"
echo ""
echo "🔍 Structure avancée avec groupes hiérarchiques:"
ansible-inventory -i advanced-inventory.yml --graph

echo ""
echo "🔍 Variables complexes pour node1:"
ansible node1 -i advanced-inventory.yml -m debug -a "var=server_config"

echo ""
echo "🔍 Configuration de base de données pour node3:"
ansible node3 -i advanced-inventory.yml -m debug -a "var=database_config"

echo ""
echo "🔍 Test des groupes hiérarchiques:"
echo "Hôtes du groupe 'application-tier':"
ansible application-tier -i advanced-inventory.yml --list-hosts

echo ""
echo "Hôtes du groupe 'data-tier':"
ansible data-tier -i advanced-inventory.yml --list-hosts

echo ""
echo "📋 3. Comparaison YAML vs INI"
echo "-----------------------------"
echo ""
echo "🔍 Structure de l'inventory INI:"
ansible-inventory -i comparison-ini.ini --graph

echo ""
echo "🔍 Structure de l'inventory YAML équivalent:"
ansible-inventory -i comparison-yaml.yml --graph

echo ""
echo "🔍 Comparaison des variables pour node1:"
echo ""
echo "Variables en INI:"
ansible-inventory -i comparison-ini.ini --host node1

echo ""
echo "Variables en YAML:"
ansible-inventory -i comparison-yaml.yml --host node1

echo ""
echo "🔍 Test de connectivité - INI vs YAML:"
echo ""
echo "Test avec INI:"
ansible all -i comparison-ini.ini -m ping --one-line

echo ""
echo "Test avec YAML:"
ansible all -i comparison-yaml.yml -m ping --one-line

echo ""
echo "📋 4. Validation de la syntaxe YAML"
echo "----------------------------------"
echo ""
echo "🔍 Validation des fichiers YAML:"

for yaml_file in *.yml; do
    if ansible-inventory -i "$yaml_file" --list > /dev/null 2>&1; then
        echo "✅ $yaml_file - Syntaxe YAML valide"
    else
        echo "❌ $yaml_file - Erreur de syntaxe YAML"
    fi
done

echo ""
echo "📋 5. Analyse des capacités avancées YAML"
echo "----------------------------------------"
echo ""
echo "🔍 Variables de type liste (monitoring.alerts):"
ansible all -i advanced-inventory.yml -m debug -a "var=monitoring.alerts"

echo ""
echo "🔍 Variables de type dictionnaire (network_config):"
ansible all -i advanced-inventory.yml -m debug -a "var=network_config"

echo ""
echo "🔍 Variables imbriquées (server_config.resources):"
ansible node1 -i advanced-inventory.yml -m debug -a "var=server_config.resources"

echo ""
echo "📋 6. Performance et lisibilité"
echo "------------------------------"
echo ""
echo "🔍 Taille des fichiers:"
echo "INI: $(wc -c < comparison-ini.ini) bytes"
echo "YAML: $(wc -c < comparison-yaml.yml) bytes"

echo ""
echo "🔍 Nombre de lignes:"
echo "INI: $(wc -l < comparison-ini.ini) lignes"
echo "YAML: $(wc -l < comparison-yaml.yml) lignes"

echo ""
echo "🔍 Lisibilité - Variables complexes:"
echo "En YAML, les structures complexes sont naturelles:"
ansible node1 -i advanced-inventory.yml -m debug -a "var=server_config.ports"

echo ""
echo "✅ Tests terminés!"
echo ""
echo "💡 Avantages du format YAML observés:"
echo "   ✅ Structure hiérarchique claire et lisible"
echo "   ✅ Variables complexes (listes, dictionnaires) natives"
echo "   ✅ Pas de limitations sur les types de données"
echo "   ✅ Commentaires intégrés naturellement"
echo "   ✅ Validation de syntaxe plus stricte"
echo ""
echo "💡 Quand utiliser YAML:"
echo "   - Inventaires complexes avec beaucoup de variables"
echo "   - Projets d'équipe nécessitant une bonne lisibilité"
echo "   - Configuration avec structures de données avancées"
echo "   - Intégration avec des outils de CI/CD modernes"
echo ""
echo "🎯 Le format YAML est recommandé pour les nouveaux projets Ansible!"
