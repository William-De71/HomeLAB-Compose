# Home Assistant

```bash
cp .env.example .env
docker compose up -d
```

- Interface : `http://<ip-hôte>:8123` (réseau `host`).
- Configuration : `./config`.
- Intégrations utiles des autres dossiers : MQTT (`mosquitto`), Z-Wave JS
  (`ws://<ip>:3000`), Matter (`ws://<ip>:5580/ws`), Thread / OTBR (`http://<ip>:8081`).
