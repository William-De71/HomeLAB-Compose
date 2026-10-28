# Homepage

Page d'accueil du homelab : liens vers les services, widgets (état, statistiques).

```bash
cp .env.example .env   # HOMEPAGE_ALLOWED_HOSTS
docker compose up -d
```

- Interface : `http://<ip-hôte>:3006`. Une page vide ou une erreur « host
  validation » = l'adresse utilisée n'est pas dans `HOMEPAGE_ALLOWED_HOSTS`.
- Configuration : `./config/services.yaml`, `widgets.yaml`, `settings.yaml`…
  (fichiers d'exemple créés au premier lancement, rechargés à chaud). Voir
  [gethomepage.dev](https://gethomepage.dev/configs/services/).
- Pour l'état des conteneurs, décommenter le montage de `docker.sock` : cela
  donne à Homepage un accès en lecture à Docker.
