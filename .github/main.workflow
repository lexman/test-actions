workflow "Test" {
  on = "watch"
  resolves = [
    "docker://debian:jessie-2",
    "pfisterer/openstreetmap-osmosis-docker/Dockerfile@master",
    "docker://byrnedo/docker-alpine-curl-2",
  ]
}

action "pfisterer/openstreetmap-osmosis-docker/Dockerfile@master" {
  uses = "pfisterer/openstreetmap-osmosis-docker@master"
}

action "docker://byrnedo/docker-alpine-curl" {
  uses = "docker://debian:jessie"
  runs = "curl https://ftp5.gwdg.de/pub/misc/openstreetmap/planet.openstreetmap.org/pbf/planet-latest.osm.pbf --output planet-latest-mirror.osm.pbf"
}

action "docker://byrnedo/docker-alpine-curl-2" {
  uses = "docker://byrnedo/docker-alpine-curl"
  runs = "curl https://planet.osm.org/pbf/planet-latest.osm.pbf --output planet-latest-official.osm.pbf"
}

action "docker://debian:jessie-2" {
  uses = "docker://debian:jessie"
  needs = [
    "pfisterer/openstreetmap-osmosis-docker/Dockerfile@master",
    "docker://byrnedo/docker-alpine-curl",
    "docker://byrnedo/docker-alpine-curl-2",
  ]
  runs = "echo The End"
}
