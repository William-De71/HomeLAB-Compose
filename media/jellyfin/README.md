# Jellyfin

Serveur multimédia : films, séries, musique, en streaming vers navigateur,
TV, téléphone.

```bash
cp .env.example .env   # MEDIA_DIR
docker compose up -d
```

- Interface : `http://<ip-hôte>:8096` — l'assistant crée le compte admin. Ajouter
  les bibliothèques depuis `/media/...`.
- Ranger les fichiers par type (`films/`, `series/`, `musique/`) et nommer
  comme `Titre (Année)` aide beaucoup la reconnaissance.
- Transcodage matériel : décommenter `devices` / `group_add` dans le compose,
  puis Tableau de bord → Lecture → Transcodage → VA-API ou QSV (Intel).
- La découverte automatique sur le réseau (applis TV, DLNA) ne marche pas en
  réseau bridge : saisir l'adresse à la main, ou passer en `network_mode: host`.
- Données : `./config` (bibliothèque, comptes) et `./data/cache`.
