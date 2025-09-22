# Commandes d'exemple pour l'Inventory Ansible

## 🚀 Démarrage de l'environnement

```bash
# 1. Construire et démarrer les conteneurs
./setup-lab.sh

# 2. Accéder au conteneur maître
docker exec -it ansible-master bash

# 3. Naviguer vers le dossier des exemples
cd /ansible-workspace/01-Inventory
```

## 📋 Commandes de base pour l'Inventory

### Lister les hôtes

```bash
# Lister tous les hôtes de l'inventory simple
ansible all -i hosts --list-hosts

# Lister les hôtes avec l'inventory groupé
ansible all -i hosts-with-groups --list-hosts

# Lister seulement les webservers
ansible webservers -i hosts-with-groups --list-hosts

# Lister seulement les serveurs de base de données
ansible database -i hosts-with-groups --list-hosts
```

### Analyser l'inventory

```bash
# Afficher l'inventory en format JSON
ansible-inventory -i hosts-with-groups --list

# Afficher l'inventory sous forme de graphique
ansible-inventory -i hosts-with-groups --graph

# Afficher seulement un hôte spécifique
ansible-inventory -i hosts-with-groups --host node1
```

### Tester la connectivité

```bash
# Tester tous les hôtes
ansible all -i hosts -m ping

# Tester seulement les webservers
ansible webservers -i hosts-with-groups -m ping

# Tester un hôte spécifique
ansible node1 -i hosts -m ping
```

### Afficher les variables

```bash
# Afficher toutes les variables pour un hôte
ansible node1 -i hosts-with-groups -m debug -a "var=hostvars[inventory_hostname]"

# Afficher une variable spécifique
ansible webservers -i hosts-with-groups -m debug -a "var=http_port"

# Afficher les facts (informations système)
ansible all -i hosts -m setup
```

## 🧪 Script de test automatisé

```bash
# Exécuter tous les tests d'un coup
chmod +x test-inventory.sh
./test-inventory.sh
```

## 📊 Résultats attendus

Après avoir exécuté les commandes, vous devriez voir :

1. **Liste des hôtes** : node1, node2, node3
2. **Ping réussi** : Chaque hôte répond "pong"
3. **Structure des groupes** : webservers contient node1 et node2, database contient node3
4. **Variables** : Chaque groupe a ses variables spécifiques

## 🔍 Dépannage

Si les commandes échouent :

1. **Vérifier les conteneurs** :
   ```bash
   docker ps
   ```

2. **Vérifier la connectivité réseau** :
   ```bash
   docker exec ansible-master ping node1
   ```

3. **Vérifier SSH** :
   ```bash
   docker exec ansible-master ssh root@node1 "echo test"
   ```

4. **Redémarrer l'environnement** :
   ```bash
   docker-compose down
   ./setup-lab.sh
   ```
