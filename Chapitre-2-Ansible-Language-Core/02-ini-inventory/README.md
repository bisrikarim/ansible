# 📋 INI Inventory - Fonctionnalités avancées

## 📚 Qu'est-ce que l'INI Inventory avancé ?

Après avoir maîtrisé les bases de l'inventory, nous explorons maintenant les fonctionnalités avancées du format INI qui permettent de :
- Définir des **plages d'hôtes** automatiquement
- Assigner des **variables spécifiques** à chaque hôte
- Placer des **hôtes dans plusieurs groupes**
- Créer des **hiérarchies de groupes**

## 🎯 Objectifs d'apprentissage

- ✅ Comprendre les plages d'hôtes (`web[1:3].domain.com`)
- ✅ Maîtriser les variables par hôte
- ✅ Organiser les hôtes dans plusieurs groupes
- ✅ Utiliser l'outil `ansible-inventory` pour analyser

## 📋 Fonctionnalités avancées

### 1. 🔢 Plages d'hôtes (Host Ranges)
```ini
# Au lieu de lister chaque hôte individuellement :
web1.example.com
web2.example.com
web3.example.com

# On peut utiliser une plage :
web[1:3].example.com
```

### 2. 🏷️ Variables par hôte
```ini
[webservers]
web1.example.com http_port=80 max_clients=100
web2.example.com http_port=8080 max_clients=200
web3.example.com http_port=80 max_clients=150
```

### 3. 👥 Hôtes dans plusieurs groupes
```ini
[webservers]
node1
node2

[databases]
node2
node3

# node2 est à la fois webserver ET database
```

### 4. 🏗️ Groupes de groupes (Children)
```ini
[production:children]
webservers
databases

[staging:children]
test-servers
```

## 🧪 Exemples pratiques

Nous allons tester ces concepts avec notre environnement Docker en simulant différents scénarios réalistes.

## 🚀 Comment tester

1. **Démarrer l'environnement** (si pas déjà fait) :
   ```bash
   cd Lab
   ./setup-lab.sh
   ```

2. **Accéder au conteneur maître** :
   ```bash
   docker exec -it ansible-master bash
   ```

3. **Naviguer vers les exemples** :
   ```bash
   cd /ansible-workspace/Chapitre-2-Ansible-Language-Core/02-ini-inventory
   ```

4. **Exécuter les tests** :
   ```bash
   ./test-ini-inventory.sh
   ```

## 📊 Commandes utiles pour l'analyse

```bash
# Analyser la structure de l'inventory
ansible-inventory -i inventory-file --graph

# Voir les variables d'un hôte spécifique
ansible-inventory -i inventory-file --host node1

# Lister tous les hôtes d'un groupe
ansible group-name -i inventory-file --list-hosts

# Voir l'inventory complet en JSON
ansible-inventory -i inventory-file --list
```

## 💡 Cas d'usage réels

- **Plages d'hôtes** : Parfait pour des infrastructures avec des noms standardisés
- **Variables par hôte** : Configuration spécifique par serveur (ports, limites, etc.)
- **Groupes multiples** : Serveurs avec plusieurs rôles (web + cache, db + backup, etc.)
- **Hiérarchies** : Organisation par environnement (prod, staging, dev)

---

**🎯 Ce concept vous permettra de gérer des inventaires plus complexes et plus proches de la réalité !**
