#!/usr/bin/env bash
# Vérifie tous les services du dépôt :
#   1. chaque dossier a compose.yaml, .env.example et README.md ;
#   2. chaque compose est valide avec son .env.example (variables vides
#      remplies par une valeur factice, pour passer les ${VAR:?}) ;
#   3. deux services n'utilisent pas le même port hôte par défaut, sauf les
#      exceptions documentées dans le README (broker MQTT 1883).
# Usage : scripts/check-compose.sh   (depuis n'importe où ; nécessite docker et jq)
set -euo pipefail

cd "$(dirname "$0")/.."
ALLOWED_DUPLICATES=" 1883/tcp "

errors=0
ports_file=$(mktemp)
trap 'rm -f "$ports_file"' EXIT

for compose in */*/compose.yaml; do
  dir=$(dirname "$compose")

  for f in .env.example README.md; do
    if [[ ! -f "$dir/$f" ]]; then
      echo "✗ $dir : $f manquant"
      errors=$((errors + 1))
    fi
  done

  env_file=$(mktemp)
  sed 's/=$/=ci/' "$dir/.env.example" > "$env_file"
  # Les services avec « env_file: .env » (Immich…) exigent ce fichier : le
  # créer s'il n'existe pas, sans jamais toucher à un vrai .env.
  created_env=false
  if [[ ! -e "$dir/.env" ]]; then
    cp "$env_file" "$dir/.env"
    created_env=true
  fi

  if ! config=$(docker compose --project-directory "$dir" --env-file "$env_file" \
        -f "$compose" config --format json 2>&1); then
    echo "✗ $dir : compose invalide"
    echo "$config" | sed 's/^/    /'
    errors=$((errors + 1))
  else
    echo "$config" | jq -r --arg dir "$dir" '
      .services[] | (.ports // [])[] | select(.published != null)
      | "\(.published)/\(.protocol // "tcp") \($dir)"' >> "$ports_file"
    echo "✓ $dir"
  fi
  rm -f "$env_file"
  $created_env && rm -f "$dir/.env"
done

while read -r port; do
  [[ "$ALLOWED_DUPLICATES" == *" $port "* ]] && continue
  echo "✗ port $port utilisé par : $(grep "^$port " "$ports_file" | cut -d' ' -f2 | sort -u | tr '\n' ' ')"
  errors=$((errors + 1))
done < <(sort -u "$ports_file" | cut -d' ' -f1 | sort | uniq -d)

if (( errors > 0 )); then
  echo "$errors erreur(s)"
  exit 1
fi
echo "Tout est bon."
