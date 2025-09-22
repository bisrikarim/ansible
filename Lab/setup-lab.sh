#!/bin/bash

# Script de configuration de l'environnement Ansible Lab
# Ce script configure les connexions SSH entre le maître et les workers

echo "🚀 Configuration de l'environnement Ansible Lab..."

# Vérifier que Docker est disponible
if ! command -v docker &> /dev/null; then
    echo "❌ Docker n'est pas installé ou n'est pas dans le PATH"
    echo "   Assurez-vous que Docker Desktop est démarré et que WSL2 est configuré"
    exit 1
fi

# Nettoyer les conteneurs existants
echo "🧹 Nettoyage de l'environnement existant..."
docker compose down 2>/dev/null || true
docker network prune -f 2>/dev/null || true

# Construire et démarrer les conteneurs
echo "📦 Construction et démarrage des conteneurs..."
docker compose up -d --build

# Vérifier que les conteneurs sont démarrés
echo "⏳ Vérification du démarrage des conteneurs..."
sleep 15

# Vérifier l'état des conteneurs
echo "📊 État des conteneurs:"
docker ps --format "table {{.Names}}\t{{.Status}}\t{{.Ports}}"

# Obtenir les adresses IP des conteneurs
echo ""
echo "🌐 Adresses IP des conteneurs:"
for container in ansible-master node1 node2 node3; do
    if docker ps --format '{{.Names}}' | grep -q "^${container}$"; then
        ip=$(docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' $container 2>/dev/null)
        if [ -n "$ip" ]; then
            echo "   $container: $ip"
        else
            echo "   $container: ❌ Pas d'IP trouvée"
        fi
    else
        echo "   $container: ❌ Conteneur non démarré"
    fi
done

# Copier la clé publique vers les workers (avec retry)
echo ""
echo "🔑 Configuration des clés SSH..."

# Attendre que SSH soit prêt dans tous les conteneurs
echo "   Attente du démarrage des services SSH..."
sleep 10

# Obtenir la clé publique du maître
if docker ps --format '{{.Names}}' | grep -q "^ansible-master$"; then
    PUBLIC_KEY=$(docker exec ansible-master cat /root/.ssh/id_rsa.pub 2>/dev/null)
    
    if [ -z "$PUBLIC_KEY" ]; then
        echo "   ❌ Impossible de récupérer la clé publique du maître"
        exit 1
    fi
    
    # Configurer l'accès SSH pour chaque worker
    for node in node1 node2 node3; do
        if docker ps --format '{{.Names}}' | grep -q "^${node}$"; then
            echo "   Configuration SSH pour $node..."
            
            # Retry logic pour la configuration SSH
            retry_count=0
            max_retries=3
            
            while [ $retry_count -lt $max_retries ]; do
                if docker exec $node mkdir -p /root/.ssh 2>/dev/null && \
                   docker exec $node sh -c "echo '$PUBLIC_KEY' > /root/.ssh/authorized_keys" 2>/dev/null && \
                   docker exec $node chmod 700 /root/.ssh 2>/dev/null && \
                   docker exec $node chmod 600 /root/.ssh/authorized_keys 2>/dev/null; then
                    echo "   ✅ SSH configuré pour $node"
                    break
                else
                    retry_count=$((retry_count + 1))
                    echo "   ⏳ Tentative $retry_count/$max_retries pour $node..."
                    sleep 5
                fi
            done
            
            if [ $retry_count -eq $max_retries ]; then
                echo "   ❌ Échec de la configuration SSH pour $node"
            fi
        else
            echo "   ❌ Conteneur $node non trouvé"
        fi
    done
else
    echo "   ❌ Conteneur ansible-master non trouvé"
    exit 1
fi

# Test de connectivité réseau
echo ""
echo "🔍 Test de connectivité réseau..."
for node in node1 node2 node3; do
    echo "   Test de ping vers $node..."
    if docker exec ansible-master ping -c 2 $node > /dev/null 2>&1; then
        echo "   ✅ $node est joignable"
    else
        echo "   ❌ $node n'est pas joignable"
    fi
done

# Test SSH avec retry
echo ""
echo "🔐 Test des connexions SSH..."
for node in node1 node2 node3; do
    echo "   Test SSH vers $node..."
    
    retry_count=0
    max_retries=3
    
    while [ $retry_count -lt $max_retries ]; do
        if docker exec ansible-master ssh -o StrictHostKeyChecking=no -o ConnectTimeout=5 root@$node "echo 'SSH OK'" > /dev/null 2>&1; then
            echo "   ✅ SSH vers $node fonctionne"
            break
        else
            retry_count=$((retry_count + 1))
            if [ $retry_count -lt $max_retries ]; then
                echo "   ⏳ Tentative SSH $retry_count/$max_retries pour $node..."
                sleep 3
            fi
        fi
    done
    
    if [ $retry_count -eq $max_retries ]; then
        echo "   ❌ SSH vers $node a échoué"
    fi
done

# Test Ansible final
echo ""
echo "🧪 Test final avec Ansible..."
if docker exec ansible-master test -f /ansible-workspace/Chapitre-2-Ansible-Language-Core/01-inventory/hosts; then
    echo "   Test du ping Ansible:"
    docker exec ansible-master bash -c "cd /ansible-workspace/Chapitre-2-Ansible-Language-Core/01-inventory && ansible all -i hosts -m ping" 2>/dev/null || echo "   ⚠️  Test Ansible échoué - vérifiez la configuration"
else
    echo "   ⚠️  Fichier d'inventory non trouvé"
fi

echo ""
echo "🎉 Configuration terminée!"
echo ""
echo "📋 Commandes utiles:"
echo "   # Accéder au conteneur maître:"
echo "   docker exec -it ansible-master bash"
echo ""
echo "   # Tester Ansible:"
echo "   docker exec ansible-master bash -c 'cd /ansible-workspace/Chapitre-2-Ansible-Language-Core/01-inventory && ansible all -i hosts -m ping'"
echo ""
echo "   # Voir les logs des conteneurs:"
echo "   docker compose logs"
echo ""
echo "   # Arrêter l'environnement:"
echo "   docker compose down"
echo ""
