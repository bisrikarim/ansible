# Ansible Inventory - Concept de base

## 📚 Qu'est-ce qu'un Inventory ?

L'**Inventory** (inventaire) est un fichier qui définit les hôtes (serveurs/machines) sur lesquels Ansible va exécuter des tâches. C'est la base de toute opération Ansible - sans inventaire, Ansible ne sait pas sur quelles machines travailler.

## 🎯 Objectifs d'apprentissage

- Comprendre le rôle de l'inventory dans Ansible
- Apprendre à créer un inventory de base
- Savoir lister et vérifier les hôtes
- Tester la connectivité avec les hôtes

## 📋 Structure de base

Un inventory peut être :
- Un fichier simple listant les hôtes
- Un fichier structuré avec des groupes
- Un script dynamique
- Un répertoire contenant plusieurs fichiers d'inventaire

## 🔧 Exemples pratiques

### Exemple 1 : Inventory simple (fichier hosts)
```ini
# Liste simple d'hôtes
node1
node2
node3
```

### Exemple 2 : Inventory avec groupes
```ini
# Groupes de serveurs
[webservers]
node1
node2

[databases]
node3

[all:vars]
ansible_user=root
ansible_ssh_pass=ansible123
```

## 🚀 Comment tester

1. Démarrer l'environnement Docker :
   ```bash
   ./setup-lab.sh
   ```

2. Accéder au conteneur maître :
   ```bash
   docker exec -it ansible-master bash
   ```

3. Tester l'inventory :
   ```bash
   cd /ansible-workspace/01-Inventory
   ansible all -i hosts -m ping
   ```

## 📊 Commandes utiles

- `ansible-inventory --list` : Afficher l'inventory en format JSON
- `ansible-inventory --graph` : Afficher l'inventory sous forme de graphique
- `ansible all --list-hosts` : Lister tous les hôtes
- `ansible webservers --list-hosts` : Lister les hôtes du groupe webservers
