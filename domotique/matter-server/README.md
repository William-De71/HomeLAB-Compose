# Matter Server

```bash
cp .env.example .env
docker compose up -d
```

- WebSocket : `ws://<ip-hôte>:5580/ws` (intégration Matter de Home Assistant).
- Fabric Matter et appareils appairés : `./data` — **à sauvegarder**.
- Pour des appareils Matter over Thread, lancer aussi `../otbr`.
