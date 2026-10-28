# HomeLAB-Compose

Mes fichiers Docker Compose, prêts à copier. Un dossier = un service autonome :
`compose.yaml` + `.env.example` + `README.md`.

## Utilisation

```bash
# Récupérer un seul service, sans cloner le dépôt
npx degit William-De71/HomeLAB-Compose/domotique/n8n n8n
# ou : git clone puis cp -r du dossier voulu

cd n8n
cp .env.example .env    # adapter
docker compose up -d
```

Les données sont stockées dans le dossier du service (`./data`, `./config`…) ou
dans un volume Docker nommé : voir le README de chaque service.

## Services

| Service | Dossier | Accès | Réseau |
|---|---|---|---|
| Gladys Assistant | [`domotique/gladys`](domotique/gladys) | `:80` | host |
| Home Assistant | [`domotique/home-assistant`](domotique/home-assistant) | `:8123` | host |
| Mosquitto (seul) | [`domotique/mosquitto`](domotique/mosquitto) | `:1883` | bridge |
| Zigbee2MQTT + Mosquitto | [`domotique/zigbee2mqtt`](domotique/zigbee2mqtt) | `:8080`, MQTT `:1883` | bridge |
| Z-Wave JS UI + Mosquitto | [`domotique/zwave-js-ui`](domotique/zwave-js-ui) | `:8091`, WS `:3000`, MQTT `:1883` | bridge |
| Matterbridge | [`domotique/matterbridge`](domotique/matterbridge) | `:8283` | host |
| Node-RED | [`domotique/node-red`](domotique/node-red) | `:1880` | bridge |
| n8n | [`domotique/n8n`](domotique/n8n) | `:5678` | bridge |
| OpenThread Border Router | [`matter-thread/otbr`](matter-thread/otbr) | REST `:8081` | host |
| Matter Server | [`matter-thread/matter-server`](matter-thread/matter-server) | WS `:5580` | host |
| Nextcloud | [`cloud/nextcloud`](cloud/nextcloud) | `:8090` | bridge |
| Kalendra | [`perso/kalendra`](perso/kalendra) | `:5232` | bridge |
| Projectory | [`perso/projectory`](perso/projectory) | `:3001` | bridge |
| JewelBox Music Library | [`perso/jewelbox`](perso/jewelbox) | `:3002` | bridge |

Les ports par défaut ne se chevauchent pas, **sauf le 1883** : `mosquitto`,
`zigbee2mqtt` et `zwave-js-ui` ont chacun leur broker. Sur un même hôte, n'en
garder qu'un (voir les README de Zigbee2MQTT et Z-Wave JS UI).

## Ajouter un service

1. Copier un dossier proche, le renommer.
2. Mettre dans `.env.example` tout ce qui change d'une machine à l'autre, et
   l'utiliser dans le compose avec `${VARIABLE:-défaut}` ou `${VARIABLE:?message}`
   (obligatoire).
3. Ajouter une ligne au tableau ci-dessus.

## Historique

Remplace l'ancien dépôt [HomeLAB](https://github.com/William-De71/HomeLAB)
(scripts d'installation qui généraient les compose), archivé.
