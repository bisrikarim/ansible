# 📋 YAML Inventory - Format moderne

## 📚 Qu'est-ce que l'inventory YAML ?

Le format **YAML** est le format moderne et recommandé pour les inventaires Ansible. Plus lisible et structuré que le format INI, il permet une organisation hiérarchique claire et une gestion avancée des variables.

## 🎯 Objectifs d'apprentissage

- ✅ Comprendre la syntaxe YAML pour les inventaires
- ✅ Convertir des inventaires INI vers YAML
- ✅ Maîtriser la structure hiérarchique YAML
- ✅ Gérer les variables complexes en YAML
- ✅ Comparer les avantages YAML vs INI

## 📋 Avantages du format YAML

### 🔍 **Lisibilité**
```yaml
# YAML - Structure claire et lisible
webservers:
  hosts:
    node1:
      http_port: 80
    node2:
      http_port: 8080
```

```ini
# INI - Plus compact mais moins lisible
[webservers]
node1 http_port=80
node2 http_port=8080
```

### 🏗️ **Structure hiérarchique**
- Organisation naturelle en arbre
- Imbrication des variables facile
- Groupes et sous-groupes intuitifs

### 📊 **Variables complexes**
- Listes et dictionnaires natifs
- Variables multi-niveaux
- Types de données riches

## 📋 Structure de base YAML

```yaml
# Structure générale d'un inventory YAML
all:                    # Groupe racine
  children:             # Groupes enfants
    webservers:         # Nom du groupe
      hosts:            # Hôtes du groupe
        node1:          # Nom de l'hôte
          var1: value1  # Variables de l'hôte
        node2:
          var2: value2
      vars:             # Variables du groupe
        group_var: value
    databases:
      hosts:
        node3:
  vars:                 # Variables globales
    global_var: value
```

## 🧪 Exemples pratiques

Nous allons explorer :
1. **Inventory YAML de base** - Conversion simple depuis INI
2. **Variables complexes** - Listes, dictionnaires, structures
3. **Hiérarchies avancées** - Groupes de groupes en YAML
4. **Comparaison** - YAML vs INI côte à côte

## 🚀 Comment tester

1. **Accéder au conteneur maître** :
   ```bash
   docker exec -it ansible-master bash
   ```

2. **Naviguer vers les exemples** :
   ```bash
   cd /ansible-workspace/Chapitre-2-Ansible-Language-Core/03-yaml-inventory
   ```

3. **Exécuter les tests** :
   ```bash
   ./test-yaml-inventory.sh
   ```

## 📊 Commandes spécifiques YAML

```bash
# Analyser un inventory YAML
ansible-inventory -i inventory.yml --graph

# Voir les variables en format JSON
ansible-inventory -i inventory.yml --list

# Valider la syntaxe YAML
ansible-inventory -i inventory.yml --list > /dev/null && echo "✅ YAML valide"

# Comparer avec l'équivalent INI
ansible-inventory -i inventory.yml --graph
ansible-inventory -i inventory.ini --graph
```

## 💡 Bonnes pratiques YAML

1. **Indentation** : Toujours 2 espaces (pas de tabs)
2. **Quotes** : Utiliser des guillemets pour les valeurs spéciales
3. **Structure** : Organiser logiquement les groupes
4. **Variables** : Préférer la structure YAML aux variables inline
5. **Validation** : Toujours tester la syntaxe avant utilisation

## 🔄 Migration INI → YAML

Le format YAML est particulièrement utile pour :
- **Projets complexes** avec beaucoup de variables
- **Équipes** qui préfèrent la lisibilité
- **CI/CD** avec génération automatique d'inventaires
- **Documentation** intégrée dans l'inventory

---

**🎯 Le format YAML rend vos inventaires plus maintenables et professionnels !**
