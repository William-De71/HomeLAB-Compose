# Actual Budget

Budget personnel par enveloppes, synchronisé entre appareils.

HTTPS est obligatoire hors `localhost` (le navigateur refuse sinon de lancer
l'appli) : Actual le sert lui-même avec un certificat mkcert, sans reverse
proxy. `config.json` indique où sont les certificats.

```bash
cp .env.example .env
# Certificat : voir docs/https-local.md, puis
mkdir -p ssl && cp /chemin/vers/cert.pem /chemin/vers/key.pem ssl/
docker compose up -d
```

- Interface : `https://<ip-hôte>:5006`. Un avertissement de certificat = la CA
  mkcert n'est pas installée sur cet appareil
  ([docs/https-local.md](../../docs/https-local.md)).
- Premier accès : définir le mot de passe du serveur, puis créer un budget.
- Appli de bureau : pour un certificat mkcert, lui indiquer `rootCA.pem`
  (et non `cert.pem`) quand elle le demande.
- Import des relevés bancaires : fichiers OFX, QIF ou CSV.
- Option : chiffrement de bout en bout du budget (Paramètres → Chiffrement).
- Données : `./data` — **à sauvegarder**.
