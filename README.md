<div align="center">

<img src="https://cdn.jsdelivr.net/gh/homarr-labs/dashboard-icons/svg/docker.svg" width="80" alt="">

# HomeLAB-Compose

**Mes fichiers Docker Compose, prêts à copier.**<br>
Un dossier = un service autonome : `compose.yaml` + `.env.example` + `README.md`.

[![Vérification](https://github.com/William-De71/HomeLAB-Compose/actions/workflows/check-compose.yml/badge.svg)](https://github.com/William-De71/HomeLAB-Compose/actions/workflows/check-compose.yml)
[![Docker Compose](https://img.shields.io/badge/Docker_Compose-v2-2496ED?logo=docker&logoColor=white)](https://docs.docker.com/compose/)
[![Services](https://img.shields.io/badge/services-30-success)](#services)
[![Licence](https://img.shields.io/github/license/William-De71/HomeLAB-Compose)](LICENSE)
[![Dernier commit](https://img.shields.io/github/last-commit/William-De71/HomeLAB-Compose)](https://github.com/William-De71/HomeLAB-Compose/commits/main)
[![Stars](https://img.shields.io/github/stars/William-De71/HomeLAB-Compose?style=flat)](https://github.com/William-De71/HomeLAB-Compose/stargazers)

[Utilisation](#utilisation) ·
[Services](#services) ·
[Ports](#ports) ·
[HTTPS](docs/https-local.md) ·
[Ajouter un service](#ajouter-un-service)

</div>

---

## Utilisation

```bash
# Récupérer un seul service, sans cloner le dépôt
npx degit William-De71/HomeLAB-Compose/domotique/n8n n8n
# ou : git clone puis cp -r du dossier voulu

cd n8n
cp .env.example .env    # adapter
docker compose up -d
```

- **Configuration** : tout ce qui change d'une machine à l'autre (mots de passe,
  chemins, ports) est dans `.env`. Les variables obligatoires bloquent le
  démarrage tant qu'elles ne sont pas renseignées.
- **Données** : dans le dossier du service (`./data`, `./config`…) ou dans un
  volume Docker nommé. Le README de chaque service précise quoi sauvegarder.
- **Mises à jour** : `docker compose pull && docker compose up -d`. Chaque image
  a sa variable `*_TAG` dans `.env` pour figer une version.
- **Sauvegardes** : [Kopia](infra/kopia). Les services avec une base
  PostgreSQL/MariaDB en écrivent un dump quotidien dans `data/dumps`.
- **Noms locaux** : `*.homelab.internal` via les réécritures DNS
  d'[AdGuard Home](infra/adguard-home/README.md#noms-locaux).

## Services

### 🏠 Domotique

| | Service | Rôle | Accès | Réseau |
|:-:|---|---|---|:-:|
| <img src="https://cdn.jsdelivr.net/gh/homarr-labs/dashboard-icons/svg/gladys-assistant.svg" width="24" alt=""> | [Gladys Assistant](domotique/gladys) | Box domotique | `:80` | host |
| <img src="https://cdn.jsdelivr.net/gh/homarr-labs/dashboard-icons/svg/home-assistant.svg" width="24" alt=""> | [Home Assistant](domotique/home-assistant) | Box domotique | `:8123` | host |
| <img src="https://cdn.jsdelivr.net/gh/homarr-labs/dashboard-icons/svg/mosquitto.svg" width="24" alt=""> | [Mosquitto](domotique/mosquitto) | Broker MQTT seul | `:1883` | bridge |
| <img src="https://cdn.jsdelivr.net/gh/homarr-labs/dashboard-icons/svg/zigbee2mqtt.svg" width="24" alt=""> | [Zigbee2MQTT](domotique/zigbee2mqtt) | Passerelle Zigbee (+ Mosquitto) | `:8080`, MQTT `:1883` | bridge |
| <img src="https://cdn.jsdelivr.net/gh/homarr-labs/dashboard-icons/svg/z-wave-js-ui.svg" width="24" alt=""> | [Z-Wave JS UI](domotique/zwave-js-ui) | Passerelle Z-Wave (+ Mosquitto) | `:8091`, WS `:3000`, MQTT `:1883` | bridge |
| <img src="https://cdn.jsdelivr.net/gh/homarr-labs/dashboard-icons/svg/thread.svg" width="24" alt=""> | [OpenThread Border Router](domotique/otbr) | Routeur de bordure Thread | REST `:8081` | host |
| <img src="https://cdn.jsdelivr.net/gh/homarr-labs/dashboard-icons/svg/matter.svg" width="24" alt=""> | [Matter Server](domotique/matter-server) | Contrôleur Matter | WS `:5580` | host |
| <img src="https://cdn.jsdelivr.net/gh/homarr-labs/dashboard-icons/svg/matterbridge.svg" width="24" alt=""> | [Matterbridge](domotique/matterbridge) | Expose des appareils en Matter | `:8283` | host |
| <img src="https://cdn.jsdelivr.net/gh/homarr-labs/dashboard-icons/svg/node-red.svg" width="24" alt=""> | [Node-RED](domotique/node-red) | Automatisations visuelles | `:1880` | bridge |
| <img src="https://cdn.jsdelivr.net/gh/homarr-labs/dashboard-icons/svg/n8n.svg" width="24" alt=""> | [n8n](domotique/n8n) | Workflows et intégrations | `:5678` | bridge |
| <img src="https://cdn.jsdelivr.net/gh/homarr-labs/dashboard-icons/svg/grafana.svg" width="24" alt=""> | [InfluxDB + Grafana](domotique/influxdb-grafana) | Historique long et tableaux de bord | `:8086`, Grafana `:3003` | bridge |
| <img src="https://cdn.jsdelivr.net/gh/homarr-labs/dashboard-icons/svg/frigate.svg" width="24" alt=""> | [Frigate](domotique/frigate) | Caméras avec détection d'objets | `:8971`, RTSP `:8554`, WebRTC `:8555` | bridge |

### ☁️ Cloud et documents

| | Service | Rôle | Accès | Réseau |
|:-:|---|---|---|:-:|
| <img src="https://cdn.jsdelivr.net/gh/homarr-labs/dashboard-icons/svg/nextcloud.svg" width="24" alt=""> | [Nextcloud](cloud/nextcloud) | Fichiers, agenda, contacts | `:8090` | bridge |
| <img src="https://github.com/Sync-in.png?size=48" width="24" alt=""> | [Sync-in](cloud/sync-in) | Fichiers, partage, synchro | `:8095` | bridge |
| <img src="https://cdn.jsdelivr.net/gh/homarr-labs/dashboard-icons/svg/joplin.svg" width="24" alt=""> | [Joplin Server](cloud/joplin) | Synchro des notes Joplin | `:22300` | bridge |
| <img src="https://cdn.jsdelivr.net/gh/homarr-labs/dashboard-icons/svg/paperless-ngx.svg" width="24" alt=""> | [Paperless-ngx](cloud/paperless-ngx) | Documents papier, OCR, classement | `:8000` | bridge |

### 🎬 Médias

| | Service | Rôle | Accès | Réseau |
|:-:|---|---|---|:-:|
| <img src="https://cdn.jsdelivr.net/gh/homarr-labs/dashboard-icons/svg/immich.svg" width="24" alt=""> | [Immich](media/immich) | Sauvegarde et galerie photos | `:2283` | bridge |
| <img src="https://cdn.jsdelivr.net/gh/homarr-labs/dashboard-icons/svg/jellyfin.svg" width="24" alt=""> | [Jellyfin](media/jellyfin) | Films, séries, musique | `:8096` | bridge |

### 🧰 Applis du quotidien

| | Service | Rôle | Accès | Réseau |
|:-:|---|---|---|:-:|
| <img src="https://cdn.jsdelivr.net/gh/homarr-labs/dashboard-icons/svg/mealie.svg" width="24" alt=""> | [Mealie](apps/mealie) | Recettes, menus, courses | `:9925` | bridge |
| <img src="https://cdn.jsdelivr.net/gh/homarr-labs/dashboard-icons/svg/actual-budget.svg" width="24" alt=""> | [Actual Budget](apps/actual-budget) | Budget personnel | `:5006` 🔒 | bridge |

### 🛠️ Infrastructure

| | Service | Rôle | Accès | Réseau |
|:-:|---|---|---|:-:|
| <img src="https://cdn.jsdelivr.net/gh/homarr-labs/dashboard-icons/svg/kopia.svg" width="24" alt=""> | [Kopia](infra/kopia) | Sauvegardes chiffrées | `:51515` | bridge |
| <img src="https://cdn.jsdelivr.net/gh/homarr-labs/dashboard-icons/svg/uptime-kuma.svg" width="24" alt=""> | [Uptime Kuma](infra/uptime-kuma) | Surveillance des services | `:3004` | bridge |
| <img src="https://cdn.jsdelivr.net/gh/homarr-labs/dashboard-icons/svg/ntfy.svg" width="24" alt=""> | [ntfy](infra/ntfy) | Notifications push | `:8097` | bridge |
| <img src="https://cdn.jsdelivr.net/gh/homarr-labs/dashboard-icons/svg/vaultwarden.svg" width="24" alt=""> | [Vaultwarden](infra/vaultwarden) | Mots de passe (Bitwarden) | `:8222` 🔒 | bridge |
| <img src="https://cdn.jsdelivr.net/gh/homarr-labs/dashboard-icons/svg/adguard-home.svg" width="24" alt=""> | [AdGuard Home](infra/adguard-home) | DNS et blocage des pubs | DNS `:53`, `:3005` | bridge |
| <img src="https://cdn.jsdelivr.net/gh/homarr-labs/dashboard-icons/svg/wireguard.svg" width="24" alt=""> | [wg-easy](infra/wg-easy) | VPN WireGuard | VPN UDP `:51820`, `:51821` | bridge |
| <img src="https://cdn.jsdelivr.net/gh/homarr-labs/dashboard-icons/png/homepage.png" width="24" alt=""> | [Homepage](infra/homepage) | Page d'accueil du homelab | `:3006` | bridge |

### 👤 Projets perso

| | Service | Rôle | Accès | Réseau |
|:-:|---|---|---|:-:|
| 📅 | [Kalendra](perso/kalendra) | [Source](https://github.com/William-De71/Kalendra) | `:5232` | bridge |
| 📋 | [Projectory](perso/projectory) | [Source](https://github.com/William-De71/Projectory) | `:3001` | bridge |
| 💿 | [JewelBox Music Library](perso/jewelbox) | [Source](https://github.com/William-De71/Jewelbox-Music-Library) | `:3002` | bridge |

🔒 = HTTPS obligatoire, servi par le service lui-même avec un certificat local :
voir [HTTPS en local avec mkcert](docs/https-local.md).

Tout reste sur le réseau local ; depuis l'extérieur, l'accès passe par le VPN
[wg-easy](infra/wg-easy).

## Ports

Les ports par défaut ne se chevauchent pas, **sauf le 1883** : `mosquitto`,
`zigbee2mqtt` et `zwave-js-ui` ont chacun leur broker. Sur un même hôte, n'en
garder qu'un (voir les README de Zigbee2MQTT et Z-Wave JS UI).

Les services en réseau `host` utilisent directement les ports de la machine,
sans correspondance de ports Docker : pour en changer un, voir le README du
service (`SERVER_PORT` dans `.env` pour Gladys, configuration de l'appli pour
les autres).

## Ajouter un service

1. Copier un dossier proche, le renommer.
2. Mettre dans `.env.example` tout ce qui change d'une machine à l'autre, et
   l'utiliser dans le compose avec `${VARIABLE:-défaut}` ou `${VARIABLE:?message}`
   (obligatoire).
3. Choisir un port libre (voir les tableaux ci-dessus).
4. Ajouter une ligne dans la bonne catégorie et mettre à jour le badge
   « services ». Icônes : [dashboard-icons](https://dashboardicons.com/).
5. Lancer `scripts/check-compose.sh` (docker + jq) : il vérifie les fichiers
   présents, la validité de chaque compose et les conflits de ports. La même
   vérification tourne sur GitHub à chaque push.

## Historique

Remplace l'ancien dépôt [HomeLAB](https://github.com/William-De71/HomeLAB)
(scripts d'installation qui généraient les compose), archivé.

## Licence

[MIT](LICENSE) © William Deren
