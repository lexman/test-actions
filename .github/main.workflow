workflow "Test" {
  on = "watch"
  resolves = [
    "docker://debian:jessie-2",
    "pfisterer/openstreetmap-osmosis-docker/Dockerfile@master",
    "Dl official",
  ]
}

action "pfisterer/openstreetmap-osmosis-docker/Dockerfile@master" {
  uses = "pfisterer/openstreetmap-osmosis-docker@master"
}

action "Dl mirror" {
  uses = "byrnedo/docker-alpine-curl@master"
  runs = "curl https://ftp5.gwdg.de/pub/misc/openstreetmap/planet.openstreetmap.org/pbf/planet-latest.osm.pbf --output planet-latest-mirror.osm.pbf"
}

action "Dl official" {
  uses = "byrnedo/docker-alpine-curl@master"
  runs = "curl https://planet.osm.org/pbf/planet-latest.osm.pbf --output planet-latest-official.osm.pbf"
}

action "docker://debian:jessie-2" {
  uses = "docker://debian:jessie"
  needs = [
    "pfisterer/openstreetmap-osmosis-docker/Dockerfile@master",
    "Dl mirror",
    "Dl official",
  ]
  runs = "echo The End"
}
