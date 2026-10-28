# Kalendra

Source et documentation : <https://github.com/William-De71/Kalendra>

```bash
cp .env.example .env   # changer KALENDRA_ADMIN_PASSWORD
docker compose up -d
```

- Serveur : `http://<ip-hôte>:5232`
- Données : volume Docker `kalendra-data`.
- Version identique au compose du dépôt Kalendra, mais avec l'image publiée sur
  ghcr.io au lieu d'un `build: .`.
