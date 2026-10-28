# Frigate

Enregistreur vidéo (NVR) avec détection d'objets (personnes, voitures,
animaux…) en local.

```bash
cp .env.example .env   # FRIGATE_MEDIA vers un disque de grande capacité
docker compose up -d
docker compose logs frigate | grep -i password   # mot de passe admin initial
```

- Interface : `https://<ip-hôte>:8971` (certificat auto-signé), compte `admin`
  avec le mot de passe affiché dans les logs au premier lancement.
- Au premier lancement, Frigate crée `./config/config.yml` sans caméra. Ajouter
  les caméras depuis l'éditeur de configuration de l'interface ou dans ce fichier
  ([doc](https://docs.frigate.video/configuration/)).
- Sans accélérateur, la détection tourne sur le CPU et devient vite lourde :
  un Coral (USB/PCIe) ou un GPU Intel est fortement conseillé. Décommenter la
  ligne `devices` correspondante dans le compose.
- Home Assistant : intégration Frigate (via HACS) + broker MQTT renseigné dans
  la section `mqtt:` de `config.yml`.
- Données : `./config` (configuration, base) et `FRIGATE_MEDIA` (enregistrements).
