# Gladys Assistant

```bash
cp .env.example .env
docker compose up -d
```

- Interface : `http://<ip-hôte>` (port 80, réseau `host`).
- Données : `/var/lib/gladysassistant` sur l'hôte (chemin imposé, voir le compose).
- Watchtower met Gladys à jour automatiquement.

Gladys peut installer elle-même Zigbee2MQTT et son broker depuis son interface :
dans ce cas, inutile de lancer `zigbee2mqtt/` en parallèle.
