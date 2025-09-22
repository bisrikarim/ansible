# 🧪 Environnement Lab Ansible

Environnement Docker pour l'apprentissage pratique d'Ansible avec 1 conteneur maître et 3 conteneurs workers.

## 🚀 Démarrage rapide

### 1. Prérequis
- Docker Desktop avec WSL2
- Terminal WSL (Ubuntu/Debian)

### 2. Lancer l'environnement
```bash
# Naviguer vers le dossier Lab
cd Lab

# Rendre le script exécutable
chmod +x setup-lab.sh

# Démarrer l'environnement (1 maître + 3 workers)
./setup-lab.sh
```

### 3. Tester l'environnement
```bash
# Accéder au conteneur maître
docker exec -it ansible-master bash

# Le workspace est monté dans /ansible-workspace
cd /ansible-workspace

# Tester la connectivité Ansible
ansible all -m ping
```

## 🏗️ Architecture

```
┌─────────────────┐    SSH    ┌──────────┐
│  ansible-master │ ────────► │   node1  │
│  (172.25.0.5)   │           │(172.25.0.3)│
└─────────────────┘           └──────────┘
         │                           
         │ SSH            ┌──────────┐
         └──────────────► │   node2  │
         │                │(172.25.0.2)│
         │                └──────────┘
         │ SSH            
         └──────────────► ┌──────────┐
                          │   node3  │
                          │(172.25.0.4)│
                          └──────────┘
```

## 📁 Contenu du Lab

```
Lab/
├── docker-compose.yml    # Configuration des 4 conteneurs
├── setup-lab.sh         # Script de configuration automatique
├── ansible.cfg          # Configuration Ansible
├── Dockerfile.master    # Image du conteneur maître Ansible
├── Dockerfile.worker    # Image des conteneurs workers
└── README.md            # Cette documentation
```

## 🛠️ Commandes utiles

```bash
# Démarrer l'environnement
./setup-lab.sh

# Voir l'état des conteneurs
docker ps

# Accéder au conteneur maître
docker exec -it ansible-master bash

# Voir les logs
docker compose logs

# Arrêter l'environnement
docker compose down

# Nettoyer complètement
docker compose down
docker system prune -f
```

## 🔧 Configuration

### Variables d'environnement
- **Réseau** : `172.25.0.0/16`
- **SSH** : Clés automatiquement configurées
- **Utilisateur** : `root` avec mot de passe `ansible123`
- **Workspace** : `/ansible-workspace` (mappé vers le répertoire parent)

### Ports exposés
- **SSH workers** : 22 (interne au réseau Docker)
- **Pas de ports externes** : Tout se fait via `docker exec`

## 🎓 Usage avec les chapitres

Ce lab est conçu pour être utilisé avec les chapitres d'apprentissage :

```bash
# Exemple : Chapitre 2, concept Inventory
cd /ansible-workspace/Chapitre-2-Ansible-Language-Core/01-inventory
ansible all -i hosts -m ping
```

## 🔍 Dépannage

### Problème : Conteneurs ne démarrent pas
```bash
docker compose logs
docker compose down
./setup-lab.sh
```

### Problème : SSH ne fonctionne pas
```bash
# Vérifier la connectivité
docker exec ansible-master ping node1

# Reconfigurer
./setup-lab.sh
```

### Problème : Permissions sur les scripts
```bash
# Rendre exécutables
chmod +x setup-lab.sh
find ../Chapitre-* -name "*.sh" -exec chmod +x {} \;
```

---

**🎯 Ce lab fournit un environnement isolé et reproductible pour apprendre Ansible sans affecter votre système.**
