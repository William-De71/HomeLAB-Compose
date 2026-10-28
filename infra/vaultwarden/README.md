# Vaultwarden

Serveur de mots de passe compatible avec les applis et extensions **Bitwarden**.

HTTPS est obligatoire (le coffre web et les clients refusent le HTTP simple) :
Vaultwarden le sert lui-même avec un certificat mkcert, sans reverse proxy.

```bash
cp .env.example .env   # DOMAIN
# Certificat : voir docs/https-local.md, puis
mkdir -p ssl && cp /chemin/vers/cert.pem /chemin/vers/key.pem ssl/
docker compose up -d
```

- Interface : `https://<ip-hôte>:8222` (= `DOMAIN`). Un avertissement de
  certificat = la CA mkcert n'est pas installée sur cet appareil.
- Créer son compte, puis repasser `SIGNUPS_ALLOWED=false` et
  `docker compose up -d`.
- Applis Bitwarden (mobile, bureau, extension) : à la connexion, choisir
  **auto-hébergé** et donner l'URL `DOMAIN`. Installer d'abord la CA sur
  l'appareil ([docs/https-local.md](../../docs/https-local.md)). Hors du réseau
  local : via le VPN wg-easy.
- Le certificat doit être **RSA** (le défaut de mkcert ; pas d'option `-ecdsa`),
  Vaultwarden ne lit pas les clés ECDSA.
- Données : `./data` — **à sauvegarder** (base chiffrée, pièces jointes, clés).
