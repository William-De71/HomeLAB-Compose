# Actual Budget

Budget personnel par enveloppes, synchronisé entre appareils.

```bash
cp .env.example .env
docker compose up -d
```

- **HTTPS obligatoire** hors `localhost` : le navigateur refuse sinon de lancer
  l'appli. Passer par un reverse proxy avec certificat qui pointe vers
  `<ip-hôte>:5006`.
- Premier accès : définir le mot de passe du serveur, puis créer un budget.
- Import des relevés bancaires : fichiers OFX, QIF ou CSV.
- Option : chiffrement de bout en bout du budget (Paramètres → Chiffrement).
- Données : `./data` — **à sauvegarder**.
