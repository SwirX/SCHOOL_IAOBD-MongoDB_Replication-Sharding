#!/usr/bin/env bash
# Affiche chaque seconde le rôle vu par mongo2 et mongo3.
# À lancer dans un SECOND terminal avant d'arrêter le primaire.
JS='const h=db.hello(); print(h.isWritablePrimary ? "PRIMARY" : (h.secondary ? "SECONDARY" : "AUTRE"))'
while true; do
  printf "%s  " "$(date +%H:%M:%S)"
  for n in mongo1 mongo2 mongo3; do
    r=$(docker exec "$n" mongosh --quiet --eval "$JS" 2>/dev/null)
    printf "%s=%s   " "$n" "${r:-injoignable}"
  done
  echo
  sleep 1
done
