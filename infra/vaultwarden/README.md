# Vaultwarden

Serveur de mots de passe compatible avec les applis et extensions **Bitwarden**.

```bash
cp .env.example .env   # DOMAIN
docker compose up -d
```

- **HTTPS obligatoire** : le coffre web et les clients Bitwarden refusent le
  HTTP simple (hors `localhost`). Placer Vaultwarden derrière un reverse proxy
  avec certificat (Caddy, Nginx Proxy Manager, Traefik…) qui pointe vers
  `<ip-hôte>:8222`, et mettre cette adresse dans `DOMAIN`.
- Créer son compte, puis repasser `SIGNUPS_ALLOWED=false` et
  `docker compose up -d`.
- Dans les applis Bitwarden : à la connexion, choisir **auto-hébergé** et donner
  l'URL `DOMAIN`.
- Données : `./data` — **à sauvegarder** (base chiffrée, pièces jointes, clés).
