workflow "New workflow" {
  on = "watch"
  resolves = ["docker://debian:jessie"]
}

action "docker://debian:jessie" {
  uses = "docker://debian:jessie"
  runs = "curl https://ftp5.gwdg.de/pub/misc/openstreetmap/planet.openstreetmap.org/pbf/planet-latest.osm.pbf --output planet-latest-mirror.osm.pbf"
}
