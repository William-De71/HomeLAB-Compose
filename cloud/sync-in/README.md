# Sync-in

Stockage, partage et synchronisation de fichiers ([sync-in.com](https://sync-in.com/))
+ MariaDB. Clients de synchronisation pour Windows, macOS et Linux.

```bash
cp .env.example .env                       # mots de passe
cp environment.yaml.example environment.yaml
# environment.yaml : mot de passe de la base (= DB_PASSWORD) et secrets
#                    (openssl rand -hex 32 pour chacun)

# Premier lancement : crée le compte admin
INIT_ADMIN=true INIT_ADMIN_LOGIN=admin INIT_ADMIN_PASSWORD='motdepasse' docker compose up -d
```

- Interface : `http://<ip-hôte>:8095`
- Sans `INIT_ADMIN_LOGIN` / `INIT_ADMIN_PASSWORD`, le compte créé est
  `sync-in` / `sync-in` : **à changer**.
- Les lancements suivants : `docker compose up -d`, sans `INIT_ADMIN`.
- Données : `./data/files` (fichiers) et `./data/db` (base). `environment.yaml`
  contient des secrets : il n'est pas versionné.

Recouvre en grande partie Nextcloud (fichiers, partage, synchro) : inutile
d'avoir les deux, sauf pour les comparer.

Sauvegarde de la base : le conteneur `db-dump` en écrit une copie cohérente
chaque jour dans `./data/dumps` (conservée `DUMP_KEEP_DAYS` jours), que Kopia
sauvegarde avec le reste. Restauration :

```bash
gunzip -c data/dumps/sync_in-AAAA-MM-JJ.sql.gz | docker compose exec -T db-dump mariadb -h db -u sync_in sync_in
```
