# OpenThread Border Router

Image officielle `openthread/border-router`, réseau `host`.

Prérequis sur l'hôte : le forwarding IP doit être activé (désactivé par défaut sous Linux) :

```bash
sudo tee /etc/sysctl.d/60-otbr.conf <<'CONF'
net.ipv4.ip_forward = 1
net.ipv6.conf.all.forwarding = 1
CONF
sudo sysctl --system
```

```bash
cp .env.example .env   # renseigner OTBR_DEVICE et OTBR_INFRA_IF
docker compose up -d
```

- API REST : `http://<ip-hôte>:8081` (intégration OTBR de Home Assistant).
- Données du réseau Thread : `./data` — **à sauvegarder**, elles contiennent les
  identifiants du réseau.
- Avec Gladys Assistant, voir `domotique/matter-server` pour le contrôleur Matter.
