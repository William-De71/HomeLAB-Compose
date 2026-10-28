# Nextcloud

Nextcloud (Apache) + MariaDB + Redis + conteneur cron + dump quotidien de la base.

```bash
cp .env.example .env   # mots de passe et NEXTCLOUD_TRUSTED_DOMAINS
docker compose up -d
```

- Interface : `http://<ip-hôte>:8090`
- Données : `./data/html` (application + fichiers) et `./data/db` (base).
- Après l'installation : Paramètres → Paramètres de base → Tâches de fond → **Cron**.
- Mise à jour : changer de version majeure **une à la fois** (ex. 30 → 31 → 32),
  avec `NEXTCLOUD_TAG=31-apache`, etc.

Sauvegarde de la base : le conteneur `db-dump` en écrit une copie cohérente
chaque jour dans `./data/dumps` (conservée `DUMP_KEEP_DAYS` jours), que Kopia
sauvegarde avec le reste. Restauration :

```bash
docker compose exec -u www-data nextcloud php occ maintenance:mode --on
gunzip -c data/dumps/nextcloud-AAAA-MM-JJ.sql.gz | docker compose exec -T db-dump mariadb -h db -u nextcloud nextcloud
docker compose exec -u www-data nextcloud php occ maintenance:mode --off
```
