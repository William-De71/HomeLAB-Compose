# Paperless-ngx

Gestion de documents papier : import, OCR, classement automatique, recherche
plein texte. + PostgreSQL + Redis.

```bash
cp .env.example .env   # PAPERLESS_SECRET_KEY, mots de passe
docker compose up -d
```

- Interface : `http://<ip-hôte>:8000`, compte `PAPERLESS_ADMIN_USER` (créé au
  premier lancement).
- Import : déposer des PDF/images dans `CONSUME_DIR` (par défaut
  `./data/consume`), ou glisser-déposer dans l'interface, ou appli mobile.
- Données : `./data/media` (documents), `./data/data` (index, réglages),
  `./data/db` (base). Export complet :
  `docker compose exec paperless document_exporter ../export`.

Sauvegarde de la base : le conteneur `db-dump` en écrit une copie cohérente
chaque jour dans `./data/dumps` (conservée `DUMP_KEEP_DAYS` jours), que Kopia
sauvegarde avec le reste. Restauration :

```bash
docker compose exec -T db-dump pg_restore --clean --if-exists -d paperless < data/dumps/paperless-AAAA-MM-JJ.dump
```
