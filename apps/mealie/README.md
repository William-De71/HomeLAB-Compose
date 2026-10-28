# Mealie

Recettes (import depuis une URL de site de cuisine), planning des repas et
listes de courses partagées.

```bash
cp .env.example .env
docker compose up -d
```

- Interface : `http://<ip-hôte>:9925` — compte initial `changeme@example.com` /
  `MyPassword`, **à changer** au premier accès.
- Inviter le reste du foyer : Paramètres → Utilisateurs → lien d'invitation.
- Home Assistant : intégration Mealie (plan de repas, listes de courses).
- Données (base SQLite, images) : `./data`.
