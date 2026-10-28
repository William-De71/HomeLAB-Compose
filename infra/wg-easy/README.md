# wg-easy

VPN WireGuard avec interface web : accès au homelab depuis l'extérieur sans
exposer les services sur Internet.

```bash
cp .env.example .env
docker compose up -d
```

- Interface : `http://<ip-hôte>:51821`. L'assistant du premier accès crée le
  compte admin et demande l'**hôte** : l'IP publique de la box ou, mieux, un nom
  DNS dynamique (DuckDNS, DynDNS de la box…), ainsi que le port `51820`.
- Sur la box : rediriger **UDP 51820** vers l'IP de l'hôte. Ne pas rediriger le
  port 51821.
- Un client = un appareil : le créer dans l'interface, puis scanner le QR code
  avec l'appli WireGuard (Android, iOS) ou importer le fichier `.conf`.
- Pour utiliser AdGuard Home à travers le VPN : Admin → Interface → DNS = IP LAN
  de l'hôte.
- Données (clés, clients, configuration) : `./data` — **à sauvegarder**.
