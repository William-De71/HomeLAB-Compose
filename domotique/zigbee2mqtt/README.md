# Zigbee2MQTT (+ Mosquitto)

```bash
cp .env.example .env   # renseigner ZIGBEE_DEVICE
docker compose up -d
```

- Interface : `http://<ip-hôte>:8080` — au premier lancement, une page d'accueil
  propose de choisir le type d'adaptateur (zstack, ember…).
- Broker : `mqtt://<ip-hôte>:1883`, à donner à Gladys / Home Assistant.
- Configuration et base des appareils : `./data`.

Le broker MQTT est inclus. Si un autre broker tourne déjà sur l'hôte (stack
`mosquitto` ou `zwave-js-ui`), supprimer le service `mosquitto` d'ici et pointer
`ZIGBEE2MQTT_CONFIG_MQTT_SERVER` vers lui, sinon le port 1883 sera en conflit.
