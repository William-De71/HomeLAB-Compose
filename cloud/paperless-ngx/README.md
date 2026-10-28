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
