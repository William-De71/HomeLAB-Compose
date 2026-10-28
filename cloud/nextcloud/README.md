# Nextcloud

Nextcloud (Apache) + MariaDB + Redis + conteneur cron.

```bash
cp .env.example .env   # mots de passe et NEXTCLOUD_TRUSTED_DOMAINS
docker compose up -d
```

- Interface : `http://<ip-hôte>:8090`
- Données : `./data/html` (application + fichiers) et `./data/db` (base).
- Après l'installation : Paramètres → Paramètres de base → Tâches de fond → **Cron**.
- Mise à jour : changer de version majeure **une à la fois** (ex. 30 → 31 → 32),
  avec `NEXTCLOUD_TAG=31-apache`, etc.
