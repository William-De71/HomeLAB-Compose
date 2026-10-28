# Node-RED

```bash
cp .env.example .env
docker compose up -d
```

- Interface : `http://<ip-hôte>:1880`
- Flows et nœuds installés : volume Docker `node-red-data`.
- Sans mot de passe par défaut : à protéger via `adminAuth` dans `settings.js`
  si l'accès dépasse le réseau local.
