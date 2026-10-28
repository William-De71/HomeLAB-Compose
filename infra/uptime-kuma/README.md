# Uptime Kuma

Surveillance des services (HTTP, ping, port TCP, DNS…) avec alertes.

```bash
cp .env.example .env
docker compose up -d
```

- Interface : `http://<ip-hôte>:3004` — le compte administrateur se crée au
  premier accès.
- Alertes : Paramètres → Notifications (Telegram, ntfy, e-mail, Discord…).
- Données : `./data`.
