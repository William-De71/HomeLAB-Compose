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
quand l'hôte est éteint, au prix de quelques publicités qui passent.
