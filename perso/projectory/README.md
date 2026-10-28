# Projectory

Source et documentation : <https://github.com/William-De71/Projectory>

```bash
cp .env.example .env   # tokens des forges, APP_PASSWORD…
docker compose up -d
```

- Interface : `http://<ip-hôte>:3001`
- Données : `./data`.
- Bouton « Mettre à jour maintenant » : décommenter `COMPOSE_PROFILES=updater` et
  `WATCHTOWER_TOKEN` dans `.env`.
