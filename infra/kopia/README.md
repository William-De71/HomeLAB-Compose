# Kopia

Sauvegardes chiffrées, dédupliquées et incrémentales, avec interface web.

```bash
cp .env.example .env   # BACKUP_SOURCE, KOPIA_PASSWORD, KOPIA_UI_PASSWORD
docker compose up -d
```

- Interface : `http://<ip-hôte>:51515`, compte `KOPIA_UI_USER`.
- Premier accès : créer le dépôt. **Local** → chemin `/repository`, ou un dépôt
  distant (Backblaze B2, S3, SFTP, WebDAV…). Le mot de passe demandé est
  `KOPIA_PASSWORD`.
- Puis **New Snapshot** → `/data/...` et définir une planification (Policies).
- **Conserver `KOPIA_PASSWORD` hors du homelab** (gestionnaire de mots de
  passe) : sans lui, les sauvegardes sont illisibles.
- Une sauvegarde sur le même disque ne protège pas d'une panne : viser au moins
  une copie sur un autre disque ou à distance.
- Bases de données : les fichiers d'une base en cours d'écriture peuvent donner
  une copie incohérente. Ce sont donc les **dumps** qui font foi :
  - Nextcloud, Sync-in, Joplin, Paperless : `<service>/data/dumps` (conteneur
    `db-dump`, un dump par jour) ;
  - Immich : `UPLOAD_LOCATION/backups` (dump intégré à Immich).

  Il suffit que `BACKUP_SOURCE` contienne ces dossiers. Pour alléger les
  snapshots, on peut exclure les dossiers bruts de base (`data/db`) dans la
  politique Kopia.
- Bases SQLite (Vaultwarden, Mealie, Uptime Kuma, Actual…) : en général
  restaurables telles quelles ; pour une copie parfaite, arrêter le service le
  temps du snapshot.
- Données propres à Kopia : `./data/config`, `./data/cache`, `./data/logs`.
