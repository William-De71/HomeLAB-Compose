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
| InfluxDB + Grafana | [`domotique/influxdb-grafana`](domotique/influxdb-grafana) | `:8086`, Grafana `:3003` | bridge |
| Frigate | [`domotique/frigate`](domotique/frigate) | `:8971`, RTSP `:8554`, WebRTC `:8555` | bridge |
| OpenThread Border Router | [`domotique/otbr`](domotique/otbr) | REST `:8081` | host |
| Matter Server | [`domotique/matter-server`](domotique/matter-server) | WS `:5580` | host |
| Nextcloud | [`cloud/nextcloud`](cloud/nextcloud) | `:8090` | bridge |
| Sync-in | [`cloud/sync-in`](cloud/sync-in) | `:8095` | bridge |
| Joplin Server | [`cloud/joplin`](cloud/joplin) | `:22300` | bridge |
| Paperless-ngx | [`cloud/paperless-ngx`](cloud/paperless-ngx) | `:8000` | bridge |
| Kopia (sauvegardes) | [`infra/kopia`](infra/kopia) | `:51515` | bridge |
| Uptime Kuma | [`infra/uptime-kuma`](infra/uptime-kuma) | `:3004` | bridge |
| Vaultwarden | [`infra/vaultwarden`](infra/vaultwarden) | `:8222` (HTTPS requis) | bridge |
| AdGuard Home | [`infra/adguard-home`](infra/adguard-home) | DNS `:53`, `:3005` | bridge |
| Homepage | [`infra/homepage`](infra/homepage) | `:3006` | bridge |
| wg-easy (VPN WireGuard) | [`infra/wg-easy`](infra/wg-easy) | VPN UDP `:51820`, `:51821` | bridge |
| ntfy | [`infra/ntfy`](infra/ntfy) | `:8097` | bridge |
| Immich | [`media/immich`](media/immich) | `:2283` | bridge |
| Jellyfin | [`media/jellyfin`](media/jellyfin) | `:8096` | bridge |
| Mealie | [`apps/mealie`](apps/mealie) | `:9925` | bridge |
| Actual Budget | [`apps/actual-budget`](apps/actual-budget) | `:5006` (HTTPS requis) | bridge |
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
