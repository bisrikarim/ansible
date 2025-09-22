# 📚 Ansible Learning Lab

Environnement d'apprentissage Ansible complet avec Docker et exemples pratiques pour maîtriser l'automatisation.

## 🎯 Objectif

Apprendre Ansible de manière progressive et pratique avec :
- 🧪 **Environnement Docker isolé** (1 maître + 3 workers)
- 📖 **Concepts théoriques détaillés**
- 🚀 **Exemples pratiques testables**
- 🔧 **Scripts d'automatisation**

## 📁 Structure du projet

```
ansible/
├── Lab/                                    # 🧪 Environnement Docker
│   ├── docker-compose.yml                 # Configuration des conteneurs
│   ├── setup-lab.sh                       # Script de setup automatique
│   ├── ansible.cfg                        # Configuration Ansible
│   ├── Dockerfile.master                  # Image maître Ansible
│   ├── Dockerfile.worker                  # Images workers
│   └── README.md                          # Documentation du lab
│
└── Chapitre-2-Ansible-Language-Core/      # 📚 Concepts fondamentaux
    ├── 01-inventory/                       # Inventaires Ansible
    ├── 02-ini-inventory/                   # Format INI avancé (à venir)
    ├── 03-yaml-inventory/                  # Format YAML (à venir)
    ├── 04-playbooks/                       # Premiers playbooks (à venir)
    ├── 05-variables/                       # Variables et facts (à venir)
    ├── 06-conditionals/                    # Logique conditionnelle (à venir)
    ├── 07-loops/                           # Boucles et itérations (à venir)
    └── README.md                           # Documentation du chapitre
```

## 🚀 Démarrage rapide

### 1. Prérequis
- **Docker Desktop** avec WSL2 activé
- **Terminal WSL** (Ubuntu/Debian recommandé)
- **Git** pour cloner le projet

### 2. Cloner le projet
```bash
git clone https://github.com/bisrikarim/ansible.git
cd ansible
```

### 3. Démarrer l'environnement
```bash
# Lancer le lab Docker
cd Lab
chmod +x setup-lab.sh
./setup-lab.sh
```

### 4. Commencer l'apprentissage
```bash
# Accéder au conteneur maître
docker exec -it ansible-master bash

# Naviguer vers le premier concept
cd /ansible-workspace/Chapitre-2-Ansible-Language-Core/01-inventory

# Exécuter les tests
./test-inventory.sh
```

## 🎓 Progression d'apprentissage

### ✅ **Concepts terminés**

#### 📋 [01-inventory](./Chapitre-2-Ansible-Language-Core/01-inventory/)
- Concepts de base des inventaires
- Groupes d'hôtes
- Variables par groupe et globales
- Commandes `ansible-inventory`

### 🔄 **Concepts à venir**

- **02-ini-inventory** : Format INI avancé, plages d'hôtes
- **03-yaml-inventory** : Format YAML moderne
- **04-playbooks** : Premiers scripts d'automatisation
- **05-variables** : Variables, facts, et portée
- **06-conditionals** : Logique avec `when`
- **07-loops** : Automatisation répétitive

## 🏗️ Architecture du Lab

```
┌─────────────────┐    SSH    ┌──────────┐
│  ansible-master │ ────────► │   node1  │
│   Ubuntu 22.04  │           │Ubuntu 22.04│
│  (172.25.0.5)   │           │(172.25.0.3)│
└─────────────────┘           └──────────┘
         │                           
         │ SSH            ┌──────────┐
         └──────────────► │   node2  │
         │                │Ubuntu 22.04│
         │                │(172.25.0.2)│
         │                └──────────┘
         │ SSH            
         └──────────────► ┌──────────┐
                          │   node3  │
                          │Ubuntu 22.04│
                          │(172.25.0.4)│
                          └──────────┘
```

## 🛠️ Commandes utiles

### Gestion de l'environnement
```bash
# Démarrer le lab
cd Lab && ./setup-lab.sh

# Voir l'état des conteneurs
docker ps

# Accéder au maître
docker exec -it ansible-master bash

# Arrêter l'environnement
docker compose down

# Nettoyer complètement
docker system prune -f
```

### Tests Ansible
```bash
# Dans le conteneur ansible-master

# Test de connectivité général
ansible all -m ping

# Lister tous les hôtes
ansible all --list-hosts

# Exécuter une commande sur tous les nœuds
ansible all -a "uptime"

# Voir les informations système
ansible all -m setup
```

## 📖 Méthode d'apprentissage

Pour chaque concept :

1. **📚 Lire** la documentation théorique (`README.md`)
2. **🔍 Examiner** les exemples de configuration
3. **🧪 Exécuter** les scripts de test automatisés
4. **🎯 Expérimenter** avec vos propres modifications
5. **✅ Valider** votre compréhension avec les exercices

## 🔧 Dépannage

### Problème : Docker ne démarre pas
```bash
# Vérifier Docker Desktop
docker --version
docker ps

# Redémarrer Docker Desktop si nécessaire
```

### Problème : Conteneurs ne communiquent pas
```bash
cd Lab
docker compose down
./setup-lab.sh
```

### Problème : SSH ne fonctionne pas
```bash
# Dans le conteneur maître
ping node1  # Test réseau
ssh root@node1  # Test SSH direct

# Si échec, reconfigurer
exit && cd Lab && ./setup-lab.sh
```

## 🤝 Contribution

Ce projet est conçu pour l'apprentissage. N'hésitez pas à :
- 🐛 Signaler des bugs
- 💡 Proposer des améliorations
- 📚 Ajouter des exemples
- 🔧 Optimiser les configurations

## 📚 Références

- **Handbook** : Basé sur "Practical Ansible Automation Handbook"
- **Documentation officielle** : [docs.ansible.com](https://docs.ansible.com)
- **Docker** : [docs.docker.com](https://docs.docker.com)

---

**🎯 Objectif** : Devenir autonome avec Ansible grâce à un apprentissage pratique et progressif dans un environnement sécurisé.