# AdGuard Home

DNS du réseau local avec blocage des publicités et traqueurs.

```bash
cp .env.example .env
docker compose up -d
```

- Assistant d'installation : `http://<ip-hôte>:3005`. À l'étape « Interface web
  d'administration », **garder le port 3000** (port interne au conteneur) et le
  port DNS 53. L'interface reste ensuite sur `http://<ip-hôte>:3005`.
- Pour l'utiliser : mettre l'IP de l'hôte comme serveur DNS dans le DHCP de la
  box/du routeur (ou appareil par appareil).
- Données : `./data/conf` (configuration) et `./data/work` (statistiques, journaux).

**Port 53 déjà utilisé** (`address already in use`) : c'est en général le
résolveur local de systemd-resolved. Au choix :

- mettre l'IP LAN de l'hôte dans `ADGUARD_DNS_BIND` ;
- ou désactiver le résolveur local :

  ```bash
  sudo mkdir -p /etc/systemd/resolved.conf.d
  printf '[Resolve]\nDNSStubListener=no\n' | sudo tee /etc/systemd/resolved.conf.d/adguard.conf
  sudo systemctl restart systemd-resolved
  ```

Mettre un second DNS (celui de la box) en secours évite de couper Internet
quand l'hôte est éteint, au prix de quelques publicités qui passent. Les
appareils interrogent parfois ce second DNS même quand AdGuard répond : les
noms locaux ci-dessous peuvent alors échouer de temps en temps.

## Noms locaux

Pour ouvrir les services par un nom plutôt que par l'IP : Filtres →
**Réécritures DNS** → Ajouter :

| Domaine | Réponse |
|---|---|
| `homelab.internal` | `192.168.1.10` |
| `*.homelab.internal` | `192.168.1.10` |

Tout nom en `.homelab.internal` pointe alors vers l'hôte, sans rien ajouter par
service : `http://nextcloud.homelab.internal:8090`,
`https://vault.homelab.internal:8222`…

- `.internal` est réservé aux réseaux privés (ICANN, 2024) : aucun risque de
  collision avec un vrai domaine. Éviter `.local`, utilisé par mDNS.
- Le port reste dans l'adresse : le nom remplace l'IP, pas le port.
- Certains services n'acceptent que les adresses déclarées : ajouter le nom à
  `NEXTCLOUD_TRUSTED_DOMAINS` (Nextcloud), `HOMEPAGE_ALLOWED_HOSTS` (Homepage),
  `DOMAIN` (Vaultwarden)…
- Les noms marchent aussi depuis l'extérieur via wg-easy, si son DNS est l'IP
  de l'hôte (voir `infra/wg-easy`).
- Pour les services en HTTPS, ajouter ces noms au certificat mkcert
  ([docs/https-local.md](../../docs/https-local.md)).
