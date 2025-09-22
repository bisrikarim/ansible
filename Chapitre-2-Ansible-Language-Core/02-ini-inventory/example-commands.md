# Commandes d'exemple pour INI Inventory avancé

## 🚀 Prérequis

```bash
# 1. Démarrer l'environnement (si pas déjà fait)
cd Lab
./setup-lab.sh

# 2. Accéder au conteneur maître
docker exec -it ansible-master bash

# 3. Naviguer vers les exemples
cd /ansible-workspace/Chapitre-2-Ansible-Language-Core/02-ini-inventory
```

## 📋 1. Commandes pour les plages d'hôtes

### Analyser l'inventory avec plages
```bash
# Voir la structure graphique
ansible-inventory -i ranges-inventory --graph

# Lister tous les hôtes générés par les plages
ansible all -i ranges-inventory --list-hosts

# Lister les hôtes d'un groupe spécifique
ansible all-nodes -i ranges-inventory --list-hosts
ansible webservers-range -i ranges-inventory --list-hosts

# Voir l'inventory complet en JSON
ansible-inventory -i ranges-inventory --list
```

### Tester la connectivité avec les plages
```bash
# Test de ping sur tous les hôtes des plages
ansible all-nodes -i ranges-inventory -m ping

# Test sur un groupe spécifique
ansible webservers-range -i ranges-inventory -m ping

# Exécuter une commande sur les hôtes des plages
ansible all-nodes -i ranges-inventory -a "hostname"
```

## 📋 2. Commandes pour les variables par hôte

### Analyser les variables d'hôtes
```bash
# Voir toutes les variables d'un hôte spécifique
ansible-inventory -i host-variables-inventory --host node1
ansible-inventory -i host-variables-inventory --host node2
ansible-inventory -i host-variables-inventory --host node3

# Voir la structure avec les variables
ansible-inventory -i host-variables-inventory --graph --vars
```

### Utiliser les variables dans les tâches
```bash
# Afficher une variable spécifique pour tous les webservers
ansible webservers -i host-variables-inventory -m debug -a "var=http_port"

# Afficher plusieurs variables
ansible webservers -i host-variables-inventory -m debug -a "var=hostvars[inventory_hostname]"

# Utiliser les variables dans une commande
ansible webservers -i host-variables-inventory -a "echo 'Server {{ server_name }} runs on port {{ http_port }}'"
```

### Filtrer par variables
```bash
# Lister les hôtes avec une variable spécifique
ansible all -i host-variables-inventory -m debug -a "var=http_port" | grep -A 2 "80"

# Afficher les informations de configuration
ansible app-servers -i host-variables-inventory -m debug -a "msg='{{ inventory_hostname }} runs app version {{ app_version }} with Java {{ java_version }}'"
```

## 📋 3. Commandes pour les groupes multiples

### Analyser les groupes multiples
```bash
# Voir la structure complète des groupes
ansible-inventory -i multiple-groups-inventory --graph

# Voir les hôtes d'un groupe spécifique
ansible webservers -i multiple-groups-inventory --list-hosts
ansible databases -i multiple-groups-inventory --list-hosts
ansible cache-servers -i multiple-groups-inventory --list-hosts

# Voir tous les groupes auxquels appartient un hôte
ansible-inventory -i multiple-groups-inventory --host node2
```

### Travailler avec les groupes multiples
```bash
# Test de ping par groupe
ansible webservers -i multiple-groups-inventory -m ping
ansible databases -i multiple-groups-inventory -m ping
ansible cache-servers -i multiple-groups-inventory -m ping

# Afficher le rôle de chaque serveur
ansible all -i multiple-groups-inventory -m debug -a "var=service_category"

# Travailler avec les groupes par environnement
ansible production -i multiple-groups-inventory -m debug -a "var=log_level"
ansible staging -i multiple-groups-inventory -m debug -a "var=log_level"
```

### Tester les groupes de groupes (children)
```bash
# Lister les hôtes des groupes parents
ansible application-tier -i multiple-groups-inventory --list-hosts
ansible data-tier -i multiple-groups-inventory --list-hosts
ansible all-production -i multiple-groups-inventory --list-hosts

# Afficher les variables héritées
ansible application-tier -i multiple-groups-inventory -m debug -a "var=tier_type"
ansible data-tier -i multiple-groups-inventory -m debug -a "var=tier_type"

# Test de connectivité sur les groupes parents
ansible application-tier -i multiple-groups-inventory -m ping
ansible data-tier -i multiple-groups-inventory -m ping
```

## 📋 4. Commandes d'analyse comparative

### Comparer les inventaires
```bash
# Compter les hôtes dans chaque inventory
echo "Ranges inventory:"
ansible all -i ranges-inventory --list-hosts | wc -l

echo "Host variables inventory:"
ansible all -i host-variables-inventory --list-hosts | wc -l

echo "Multiple groups inventory:"
ansible all -i multiple-groups-inventory --list-hosts | wc -l
```

### Analyser les différences
```bash
# Voir les groupes de chaque inventory
echo "=== Ranges inventory groups ==="
ansible-inventory -i ranges-inventory --graph

echo "=== Host variables inventory groups ==="
ansible-inventory -i host-variables-inventory --graph

echo "=== Multiple groups inventory groups ==="
ansible-inventory -i multiple-groups-inventory --graph
```

## 📋 5. Commandes de validation

### Vérifier la syntaxe des inventaires
```bash
# Tester que les inventaires sont valides
ansible-inventory -i ranges-inventory --list > /dev/null && echo "✅ ranges-inventory OK" || echo "❌ ranges-inventory ERROR"
ansible-inventory -i host-variables-inventory --list > /dev/null && echo "✅ host-variables-inventory OK" || echo "❌ host-variables-inventory ERROR"
ansible-inventory -i multiple-groups-inventory --list > /dev/null && echo "✅ multiple-groups-inventory OK" || echo "❌ multiple-groups-inventory ERROR"
```

### Tests de connectivité rapides
```bash
# Test de ping rapide sur tous les inventaires
echo "Testing ranges-inventory:"
ansible all -i ranges-inventory -m ping --one-line

echo "Testing host-variables-inventory:"
ansible all -i host-variables-inventory -m ping --one-line

echo "Testing multiple-groups-inventory:"
ansible all -i multiple-groups-inventory -m ping --one-line
```

## 🧪 Script de test automatisé

```bash
# Exécuter tous les tests d'un coup
chmod +x test-ini-inventory.sh
./test-ini-inventory.sh
```

## 💡 Conseils d'utilisation

1. **Commencez simple** : Testez d'abord les plages d'hôtes
2. **Analysez avant d'exécuter** : Utilisez `--list-hosts` pour vérifier
3. **Utilisez les variables** : Exploitez `ansible-inventory --host` pour déboguer
4. **Testez la connectivité** : Toujours faire un `ping` avant les vraies tâches

## 🔍 Dépannage

```bash
# Si un inventory ne fonctionne pas
ansible-inventory -i problematic-inventory --list

# Pour voir les erreurs détaillées
ansible all -i problematic-inventory -m ping -vvv

# Pour vérifier qu'un hôte est dans un groupe
ansible group-name -i inventory-file --list-hosts | grep hostname
```
