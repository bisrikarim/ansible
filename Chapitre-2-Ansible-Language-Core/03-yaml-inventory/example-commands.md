# Commandes d'exemple pour YAML Inventory

## 🚀 Prérequis

```bash
# 1. Accéder au conteneur maître (lab déjà démarré)
docker exec -it ansible-master bash

# 2. Naviguer vers les exemples YAML
cd /ansible-workspace/Chapitre-2-Ansible-Language-Core/03-yaml-inventory
```

## 📋 1. Commandes de base pour YAML

### Analyser la structure YAML
```bash
# Voir la structure graphique de l'inventory YAML
ansible-inventory -i basic-inventory.yml --graph

# Afficher l'inventory complet en JSON
ansible-inventory -i basic-inventory.yml --list

# Voir les variables d'un hôte spécifique
ansible-inventory -i basic-inventory.yml --host node1
ansible-inventory -i basic-inventory.yml --host node2
ansible-inventory -i basic-inventory.yml --host node3
```

### Valider la syntaxe YAML
```bash
# Vérifier que le YAML est valide
ansible-inventory -i basic-inventory.yml --list > /dev/null && echo "✅ YAML valide" || echo "❌ Erreur YAML"

# Valider tous les fichiers YAML du dossier
for file in *.yml; do
    echo -n "Validation de $file: "
    ansible-inventory -i "$file" --list > /dev/null 2>&1 && echo "✅ OK" || echo "❌ ERREUR"
done
```

### Tester la connectivité
```bash
# Test de ping avec inventory YAML
ansible all -i basic-inventory.yml -m ping

# Test par groupe
ansible webservers -i basic-inventory.yml -m ping
ansible databases -i basic-inventory.yml -m ping
ansible cache-servers -i basic-inventory.yml -m ping
```

## 📋 2. Commandes pour les structures avancées

### Analyser les variables complexes
```bash
# Voir les variables de configuration serveur
ansible node1 -i advanced-inventory.yml -m debug -a "var=server_config"

# Afficher seulement les ports configurés
ansible node1 -i advanced-inventory.yml -m debug -a "var=server_config.ports"

# Voir les ressources allouées
ansible webservers -i advanced-inventory.yml -m debug -a "var=server_config.resources"

# Afficher la configuration de base de données
ansible node3 -i advanced-inventory.yml -m debug -a "var=database_config"
```

### Travailler avec les listes et dictionnaires
```bash
# Afficher les alertes de monitoring (liste)
ansible all -i advanced-inventory.yml -m debug -a "var=monitoring.alerts"

# Voir la configuration réseau (dictionnaire)
ansible all -i advanced-inventory.yml -m debug -a "var=network_config"

# Afficher les serveurs DNS
ansible all -i advanced-inventory.yml -m debug -a "var=network_config.dns_servers"

# Lister les services installés
ansible webservers -i advanced-inventory.yml -m debug -a "var=server_config.services"
```

### Groupes hiérarchiques
```bash
# Lister les hôtes des groupes parents
ansible application-tier -i advanced-inventory.yml --list-hosts
ansible data-tier -i advanced-inventory.yml --list-hosts

# Voir les variables héritées
ansible application-tier -i advanced-inventory.yml -m debug -a "var=tier_type"
ansible data-tier -i advanced-inventory.yml -m debug -a "var=tier_type"

# Test par datacenter
ansible datacenter-east -i advanced-inventory.yml --list-hosts
ansible datacenter-west -i advanced-inventory.yml --list-hosts
```

## 📋 3. Comparaison YAML vs INI

### Analyser les différences structurelles
```bash
# Comparer les structures graphiques
echo "=== Structure INI ==="
ansible-inventory -i comparison-ini.ini --graph

echo "=== Structure YAML ==="
ansible-inventory -i comparison-yaml.yml --graph
```

### Comparer les variables
```bash
# Variables node1 en INI
echo "Variables node1 (INI):"
ansible-inventory -i comparison-ini.ini --host node1

# Variables node1 en YAML
echo "Variables node1 (YAML):"
ansible-inventory -i comparison-yaml.yml --host node1

# Comparer les variables de groupe
echo "Variables webservers (INI):"
ansible webservers -i comparison-ini.ini -m debug -a "var=hostvars[groups['webservers'][0]]"

echo "Variables webservers (YAML):"
ansible webservers -i comparison-yaml.yml -m debug -a "var=hostvars[groups['webservers'][0]]"
```

### Tests de performance
```bash
# Mesurer le temps de parsing
echo "Temps de parsing INI:"
time ansible-inventory -i comparison-ini.ini --list > /dev/null

echo "Temps de parsing YAML:"
time ansible-inventory -i comparison-yaml.yml --list > /dev/null

# Comparer la taille des fichiers
echo "Taille INI: $(wc -c < comparison-ini.ini) bytes"
echo "Taille YAML: $(wc -c < comparison-yaml.yml) bytes"
```

## 📋 4. Utilisation avancée des variables YAML

### Variables conditionnelles
```bash
# Utiliser des variables dans des conditions
ansible webservers -i advanced-inventory.yml -m debug -a "msg='Server {{ inventory_hostname }} has {{ server_config.resources.cpu_cores }} CPU cores'"

# Afficher des informations conditionnelles
ansible all -i advanced-inventory.yml -m debug -a "msg='Datacenter: {{ datacenter | default(\"unknown\") }}'"
```

### Manipulation de listes et dictionnaires
```bash
# Accéder aux éléments de liste
ansible all -i advanced-inventory.yml -m debug -a "msg='Primary DNS: {{ network_config.dns_servers.primary }}'"

# Itérer sur une liste (simulation)
ansible all -i advanced-inventory.yml -m debug -a "var=monitoring.alerts[0]"

# Vérifier l'existence de clés
ansible webservers -i advanced-inventory.yml -m debug -a "msg='HTTPS port: {{ server_config.ports.https | default(\"not configured\") }}'"
```

## 📋 5. Debugging et dépannage YAML

### Vérifier la syntaxe YAML
```bash
# Utiliser un validateur YAML externe (si disponible)
python3 -c "import yaml; yaml.safe_load(open('basic-inventory.yml'))" && echo "✅ Syntaxe YAML correcte"

# Voir les erreurs détaillées
ansible-inventory -i basic-inventory.yml --list -vvv
```

### Identifier les problèmes courants
```bash
# Vérifier l'indentation (problème courant en YAML)
ansible-inventory -i basic-inventory.yml --list 2>&1 | grep -i "yaml\|indent\|syntax"

# Tester la résolution des variables
ansible all -i advanced-inventory.yml -m debug -a "var=hostvars[inventory_hostname]" | grep -i "undefined\|error"
```

### Comparer avec l'équivalent INI
```bash
# Si un YAML ne fonctionne pas, tester l'équivalent INI
ansible all -i comparison-ini.ini -m ping
ansible all -i comparison-yaml.yml -m ping
```

## 📋 6. Bonnes pratiques

### Organisation des fichiers
```bash
# Lister tous les inventaires disponibles
ls -la *.yml *.ini

# Vérifier la cohérence entre inventaires
for inv in *.yml *.ini; do
    echo "=== $inv ==="
    ansible all -i "$inv" --list-hosts
done
```

### Validation systématique
```bash
# Script de validation rapide
validate_inventory() {
    local file=$1
    echo -n "Validation de $file: "
    if ansible-inventory -i "$file" --list > /dev/null 2>&1; then
        echo "✅ OK"
        ansible all -i "$file" -m ping --one-line | head -3
    else
        echo "❌ ERREUR"
    fi
    echo ""
}

# Valider tous les inventaires
for inv in *.yml *.ini; do
    validate_inventory "$inv"
done
```

## 🧪 Script de test automatisé

```bash
# Exécuter tous les tests YAML
chmod +x test-yaml-inventory.sh
./test-yaml-inventory.sh
```

## 💡 Conseils d'utilisation YAML

1. **Indentation** : Toujours utiliser 2 espaces, jamais de tabs
2. **Quotes** : Utiliser des guillemets pour les valeurs avec caractères spéciaux
3. **Validation** : Toujours tester la syntaxe avant utilisation
4. **Lisibilité** : Profiter de la structure hiérarchique pour organiser logiquement
5. **Variables complexes** : Utiliser les capacités natives YAML pour les structures de données

## 🔍 Dépannage YAML

```bash
# Erreur d'indentation
ansible-inventory -i inventory.yml --list 2>&1 | grep -A 5 -B 5 "indent"

# Erreur de syntaxe
ansible-inventory -i inventory.yml --list 2>&1 | grep -A 5 -B 5 "syntax"

# Variables non définies
ansible all -i inventory.yml -m debug -a "var=undefined_var" 2>&1 | grep -i "undefined"
```
