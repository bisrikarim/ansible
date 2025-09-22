# 📚 Chapitre 2 : Ansible Language Core

Concepts fondamentaux du langage Ansible avec des exemples pratiques et un environnement de test Docker.

## 🎯 Concepts couverts

### ✅ Terminés
- **[01-inventory](./01-inventory/)** : Concepts de base de l'inventory Ansible

### 🔄 À venir
- **02-ini-inventory** : Format INI avancé, plages d'hôtes, variables
- **03-yaml-inventory** : Format YAML moderne
- **04-ansible-inventory-tool** : Outil d'analyse d'inventory
- **05-playbooks** : Premier playbook, syntaxe YAML
- **06-variables** : Types de variables, portée, facts
- **07-conditionals** : Logique conditionnelle avec `when`
- **08-loops** : Boucles et itérations

## 🚀 Prérequis

### 1. Environnement Lab
Assurez-vous que l'environnement Docker est démarré :

```bash
# Depuis la racine du projet
cd Lab
./setup-lab.sh
```

### 2. Accès au conteneur maître
```bash
# Accéder au conteneur maître Ansible
docker exec -it ansible-master bash

# Le workspace est disponible dans
cd /ansible-workspace
```

## 📚 Méthode d'apprentissage

### Pour chaque concept :

1. **📖 Lire la théorie** : `README.md` de chaque dossier
2. **🔍 Examiner les exemples** : Fichiers de configuration
3. **🧪 Exécuter les tests** : Scripts `test-*.sh`
4. **🎯 Expérimenter** : Modifier et tester vos propres configurations

### Exemple avec le concept Inventory :
```bash
# Dans le conteneur ansible-master
cd /ansible-workspace/Chapitre-2-Ansible-Language-Core/01-inventory

# Lire la documentation
cat README.md

# Examiner les exemples
ls -la
cat hosts
cat hosts-with-groups

# Exécuter les tests
./test-inventory.sh

# Tester manuellement
ansible all -i hosts -m ping
ansible-inventory -i hosts-with-groups --graph
```

## 📁 Structure des concepts

Chaque sous-dossier contient :

```
01-inventory/
├── README.md              # 📖 Théorie et explications
├── hosts                  # 🧪 Exemple simple
├── hosts-with-groups      # 🧪 Exemple avec groupes
├── test-inventory.sh      # 🚀 Tests automatisés
└── example-commands.md    # 📝 Guide des commandes
```

## 🎓 Progression recommandée

1. **Inventory** → Comprendre les hôtes et groupes
2. **INI Inventory** → Maîtriser le format INI avancé
3. **YAML Inventory** → Découvrir le format moderne
4. **Ansible Inventory Tool** → Analyser et déboguer
5. **Playbooks** → Premiers scripts d'automatisation
6. **Variables** → Gérer la configuration dynamique
7. **Conditionals** → Logique de contrôle
8. **Loops** → Automatisation répétitive

## 🛠️ Commandes utiles

```bash
# Depuis le conteneur ansible-master

# Tester la connectivité générale
ansible all -m ping

# Lister tous les hôtes
ansible all --list-hosts

# Voir la configuration Ansible
ansible-config view

# Afficher les facts d'un hôte
ansible node1 -m setup

# Exécuter une commande sur tous les hôtes
ansible all -a "uptime"
```

## 🔍 Dépannage

### Problème : "No hosts matched"
```bash
# Vérifier l'inventory par défaut
ansible-config dump | grep DEFAULT_HOST_LIST

# Utiliser un inventory spécifique
ansible all -i /ansible-workspace/Chapitre-2-Ansible-Language-Core/01-inventory/hosts -m ping
```

### Problème : SSH ne fonctionne pas
```bash
# Tester la connectivité réseau
ping node1

# Tester SSH manuellement
ssh root@node1

# Redémarrer l'environnement lab
exit  # Sortir du conteneur
cd ../Lab
./setup-lab.sh
```

### Problème : Permissions sur les scripts
```bash
# Rendre tous les scripts exécutables
find /ansible-workspace -name "*.sh" -exec chmod +x {} \;
```

## 📖 Référence

Ce chapitre est basé sur le **Chapitre 2 - Ansible Language Core** du handbook Ansible et couvre :

- Structure et syntaxe Ansible
- Inventory (inventaires)
- Playbooks et syntaxe YAML
- Variables et facts
- Conditionnels et boucles
- Magic variables

---

**🎯 Objectif** : Maîtriser les concepts fondamentaux d'Ansible avec des exemples concrets et un environnement de test réaliste.
