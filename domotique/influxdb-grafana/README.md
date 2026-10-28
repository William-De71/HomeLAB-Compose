# InfluxDB + Grafana

Historique long terme des capteurs (InfluxDB 2) et tableaux de bord (Grafana).

```bash
cp .env.example .env   # mots de passe et INFLUXDB_TOKEN
docker compose up -d
```

- InfluxDB : `http://<ip-hôte>:8086` — organisation, bucket et token créés au
  premier lancement à partir de `.env` (les modifier ensuite n'a plus d'effet).
- Grafana : `http://<ip-hôte>:3003` — la source InfluxDB (langage Flux) est déjà
  configurée.
- Données : `./data/influxdb` et volume Docker `grafana-data`.

Home Assistant, dans `configuration.yaml` :

```yaml
influxdb:
  api_version: 2
  ssl: false
  host: <ip-hôte>
  port: 8086
  token: <INFLUXDB_TOKEN>
  organization: homelab
  bucket: home_assistant
```

Pour limiter le volume, ajouter un bloc `include:` (entités ou domaines) sous
`influxdb:`.
