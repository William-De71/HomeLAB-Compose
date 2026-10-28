# HTTPS en local avec mkcert

Certains services exigent HTTPS, même sur le réseau local : **Vaultwarden** et
**Actual Budget**. Sans nom de domaine, on crée sa propre autorité de
certification (CA) avec [mkcert](https://github.com/FiloSottile/mkcert), on
l'installe une fois sur chaque appareil, et elle signe les certificats des
services. Rien n'est exposé sur Internet ; depuis l'extérieur, on passe par
le VPN (`infra/wg-easy`).

## 1. Créer la CA (une seule fois, sur le PC d'admin)

```bash
sudo dnf install mkcert nss-tools   # Fedora ; Debian/Ubuntu : sudo apt install mkcert libnss3-tools
mkcert -install                     # crée la CA et l'installe sur ce PC (système, Firefox, Chrome)
mkcert -CAROOT                      # dossier contenant rootCA.pem et rootCA-key.pem
```

> **`rootCA-key.pem` ne doit jamais quitter ce PC** ni être versionné : avec
> lui, n'importe qui peut fabriquer un certificat accepté par tous tes appareils.
> Seul `rootCA.pem` (la partie publique) se distribue.

## 2. Générer le certificat d'un hôte

Un certificat par machine du homelab, valable pour toutes ses adresses :

```bash
mkcert -cert-file cert.pem -key-file key.pem \
  192.168.1.10 homelab.internal "*.homelab.internal" localhost 127.0.0.1
```

Remplacer `192.168.1.10` par l'IP de l'hôte (fixée dans le DHCP de la box).
`*.homelab.internal` couvre tous les noms locaux définis dans AdGuard Home
(`vault.homelab.internal`…, voir
[infra/adguard-home](../infra/adguard-home/README.md#noms-locaux)). `localhost` sert aux vérifications
de santé internes des conteneurs (Vaultwarden).

Puis, dans le dossier de chaque service qui en a besoin :

```bash
mkdir -p ssl
cp cert.pem key.pem ssl/
chmod 644 ssl/*.pem   # lisibles par l'utilisateur du conteneur
```

Le dossier `ssl/` est ignoré par git. Le certificat est valable un peu plus de
2 ans : le régénérer de la même façon avant l'échéance
(`openssl x509 -enddate -noout -in ssl/cert.pem`), puis
`docker compose restart`.

## 3. Installer la CA sur les appareils

Copier `rootCA.pem` sur l'appareil (renommé en `rootCA.crt` pour Android et
Windows), puis :

| Appareil | Installation |
|---|---|
| **Linux** | `mkcert -install` si mkcert est présent ; sinon `sudo cp rootCA.pem /etc/pki/ca-trust/source/anchors/homelab.pem && sudo update-ca-trust` (Fedora) ou `/usr/local/share/ca-certificates/homelab.crt` + `sudo update-ca-certificates` (Debian) |
| **Windows** | Double-clic sur `rootCA.crt` → Installer → Ordinateur local → *Autorités de certification racines de confiance* |
| **macOS** | Double-clic → Trousseau *Système* → ouvrir le certificat → Se fier : *Toujours approuver* |
| **Android** | Paramètres → Sécurité → Chiffrement et identifiants → Installer un certificat → **Certificat CA** |
| **iOS / iPadOS** | Ouvrir le fichier (AirDrop, mail) → Réglages → Profil téléchargé → Installer, **puis** Réglages → Général → Informations → Réglages des certificats → activer la confiance totale |
| **Firefox** | Utilise sa propre liste : Paramètres → Vie privée et sécurité → Certificats → Afficher → Autorités → Importer (cocher « sites web ») |

Vérification : ouvrir `https://192.168.1.10:8222` ; le cadenas doit apparaître
sans avertissement.

## Services concernés

- [`infra/vaultwarden`](../infra/vaultwarden) — `https://<ip-hôte>:8222`
- [`apps/actual-budget`](../apps/actual-budget) — `https://<ip-hôte>:5006`
