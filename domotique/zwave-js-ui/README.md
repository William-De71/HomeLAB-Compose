# Z-Wave JS UI (+ Mosquitto)

```bash
cp .env.example .env   # renseigner ZWAVE_DEVICE et SESSION_SECRET
docker compose up -d
```

- Interface : `http://<ip-hôte>:8091`
- Dans **Réglages → Z-Wave** : port série `/dev/zwave`.
- Dans **Réglages → MQTT** : hôte `mosquitto`, port `1883` (le broker de la stack).
- Pour Home Assistant : intégration Z-Wave JS sur `ws://<ip-hôte>:3000`.
- Données : `./store`.

Le broker MQTT est inclus. Si un autre broker tourne déjà sur l'hôte, supprimer le
service `mosquitto` d'ici et renseigner l'autre broker, sinon le port 1883 sera en conflit.
