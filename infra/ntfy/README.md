# ntfy

Notifications push vers le téléphone et le navigateur, par simple requête HTTP.

```bash
cp .env.example .env   # NTFY_BASE_URL
docker compose up -d
docker compose exec ntfy ntfy user add --role=admin <nom>
```

- Interface : `http://<ip-hôte>:8097`, connexion avec le compte créé ci-dessus.
- Applis : ntfy (Android, iOS) → ajouter le serveur `NTFY_BASE_URL` avec le
  compte, puis s'abonner à un sujet (ex. `homelab`).
- Pour les services qui publient : créer un jeton
  `docker compose exec ntfy ntfy token add <nom>` et l'utiliser en
  `Authorization: Bearer <jeton>`.
- Test :
  `curl -H "Authorization: Bearer <jeton>" -d "Bonjour" http://<ip-hôte>:8097/homelab`
- Compatible avec Uptime Kuma, Home Assistant, n8n, Kopia (Notifications)…
- Hors du réseau local : via le VPN wg-easy.
- Données : `./data/lib` (comptes) et `./data/cache` (messages en attente).
