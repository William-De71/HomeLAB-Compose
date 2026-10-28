# Mosquitto

Broker MQTT seul, pour Gladys, Home Assistant, Node-RED…

```bash
cp .env.example .env
docker compose up -d
```

Broker : `mqtt://<ip-hôte>:1883`, accès anonyme par défaut (`config/mosquitto.conf`).

## Activer l'authentification

```bash
docker compose exec mosquitto mosquitto_passwd -c /mosquitto/config/passwd <utilisateur>
```

Puis, dans `config/mosquitto.conf`, remplacer `allow_anonymous true` par les deux
lignes commentées, et `docker compose restart`.
