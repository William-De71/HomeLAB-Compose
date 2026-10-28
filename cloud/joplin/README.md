# Joplin Server

Serveur de synchronisation pour les applis [Joplin](https://joplinapp.org/)
(PC, Android, iOS) + PostgreSQL.

```bash
cp .env.example .env   # APP_BASE_URL et DB_PASSWORD
docker compose up -d
```

- Interface d'administration : `http://<ip-hôte>:22300` — compte initial
  `admin@localhost` / `admin`, **à changer tout de suite**. Créer ensuite un
  utilisateur par personne.
- Dans l'appli Joplin : Synchronisation → cible **Joplin Server**, URL =
  `APP_BASE_URL`, puis l'e-mail et le mot de passe de l'utilisateur.
- Activer le chiffrement de bout en bout dans l'appli (Options → Chiffrement)
  pour que le serveur ne stocke que des notes chiffrées.
- Données : `./data/db` (notes, pièces jointes, comptes).
