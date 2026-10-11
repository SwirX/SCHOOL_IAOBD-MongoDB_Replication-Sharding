# Projet — Réplication et partitionnement MongoDB (M201)

Projet pratique sur la haute disponibilité et le passage à l'échelle avec MongoDB réalisé dans le cadre du module M201 (*Comprendre les bases de données NoSQL*).

---

## 👥 Membres du trinôme

- **Ali Bouyakhsass**
- **Fatima Zahra Bayouni**
- **Khalid El Hamraoui**

**Formateur :** M. Abderrahman SALHI

---

## 🔗 Support de présentation

- **Lien de la présentation orale :** [Présentation du projet]()

---

## 🎯 Objectifs

1. **Étude conceptuelle :**
   - Comprendre le fonctionnement d'un Replica Set (élections Raft, quorum, oplog, failover).
   - Comprendre l'architecture de partitionnement (Sharding : `mongos`, Config Servers, Shards).

2. **Simulation technique pratique :**
   - Déploiement d'un cluster Replica Set 3 nœuds (`rs0` avec `mongo1`, `mongo2`, `mongo3`) via Docker Compose.
   - Initialisation et configuration du replica set.
   - Test de réplication des écritures vers les secondaires.
   - Simulation de panne du primaire (`docker stop mongo1`) et observation de l'élection automatique en temps réel.
   - Réintégration de l'ancien primaire et vérification de son statut de secondaire.

3. **Livrables :**
   - Sujet officiel du projet (`M201_Projet_Replication_Sharding-1.pdf`).
   - Compte rendu détaillé avec captures d'écran et schémas d'architecture (`Compte rendu — Réplication et partitionnement MongoDB-5.pdf`).

---

## 📁 Structure du projet

```text
.
├── assets/
│   ├── Diagrams/
│   │   ├── Schema.png             # Schéma d'architecture de réplication
│   │   └── Schema.svg
│   └── Screenshots/
│       ├── C1.png à C15p2.png      # Preuves d'exécution et de basculement (failover)
├── docker-compose.yml             # Définition des 3 conteneurs MongoDB (mongo1, mongo2, mongo3)
├── watch.sh                       # Script bash de monitoring de l'état des nœuds
├── watch.ps1                      # Version PowerShell pour Windows
├── Compte rendu — Réplication et partitionnement MongoDB-5.pdf # Rapport final
├── M201_Projet_Replication_Sharding-1.pdf                     # Énoncé du projet
└── README.md
```

---

## 🚀 Démarrage rapide

### 1. Démarrer les conteneurs

```bash
docker compose up -d
```

### 2. Initialiser le Replica Set

Connectez-vous à `mongo1` :
```bash
docker exec -it mongo1 mongosh
```

Puis initialisez le replica set :
```javascript
rs.initiate({
  _id: "rs0",
  members: [
    { _id: 0, host: "mongo1:27017" },
    { _id: 1, host: "mongo2:27017" },
    { _id: 2, host: "mongo3:27017" }
  ]
})
```

### 3. Surveiller l'état en direct

Dans un second terminal, lancez le script de surveillance :
```bash
# Sous Linux / macOS
chmod +x watch.sh
./watch.sh

# Sous Windows PowerShell
.\watch.ps1
```

### 4. Simuler le basculement (Failover)

Arrêtez le primaire :
```bash
docker stop mongo1
```
Observez dans le terminal de monitoring l'élection immédiate d'un nouveau primaire parmi `mongo2` et `mongo3`.

Rallumez ensuite `mongo1` :
```bash
docker start mongo1
```
Il rejoint automatiquement le cluster en tant que membre secondaire.
