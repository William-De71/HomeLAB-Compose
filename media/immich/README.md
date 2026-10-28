# Immich

Sauvegarde et galerie de photos/vidéos (équivalent de Google Photos) :
sauvegarde auto depuis le téléphone, reconnaissance des visages, recherche
par contenu (« plage », « chien »…).

```bash
cp .env.example .env   # UPLOAD_LOCATION, DB_PASSWORD
docker compose up -d
```

- Interface : `http://<ip-hôte>:2283` — le premier compte créé est administrateur.
- Appli Immich (Android, iOS) : URL du serveur `http://<ip-hôte>:2283`, puis
  activer la sauvegarde. Hors du réseau local : via wg-easy.
- Données : `UPLOAD_LOCATION` (photos) et `DB_DATA_LOCATION` (base) — **à
  sauvegarder toutes les deux** ; la base contient albums, visages, métadonnées.
- Immich fait lui-même un dump quotidien de sa base dans
  `UPLOAD_LOCATION/backups` (14 conservés, réglable dans Administration →
  Paramètres) : il est sauvegardé avec les photos.
- La base est ici une image spéciale d'Immich (extensions vectorielles) : ne pas
  la remplacer par un PostgreSQL standard.
- Mises à jour : lire les [notes de version](https://github.com/immich-app/immich/releases)
  avant de changer `IMMICH_VERSION` ; une version majeure peut demander de
  reprendre le compose officiel.
- Accélération de la reconnaissance (GPU Intel, Nvidia…) :
  [doc](https://docs.immich.app/features/ml-hardware-acceleration).
