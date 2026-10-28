# n8n

```bash
cp .env.example .env
docker compose up -d
```

- Interface : `http://<ip-hôte>:5678` — le compte propriétaire se crée au premier accès.
- Données (workflows, identifiants chiffrés) : volume Docker `n8n-data`.
