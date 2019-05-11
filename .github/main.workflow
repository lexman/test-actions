workflow "Test" {
  on = "watch"
  resolves = [
    "pfisterer/openstreetmap-osmosis-docker@master",
    "docker://debian:jessie-1",
    "docker://debian:jessie-2",
  ]
}

action "pfisterer/openstreetmap-osmosis-docker@master" {
  uses = "pfisterer/openstreetmap-osmosis-docker/Dockerfile@master"
}

action "docker://debian:jessie" {
  uses = "docker://debian:jessie"
  runs = "curl https://ftp5.gwdg.de/pub/misc/openstreetmap/planet.openstreetmap.org/pbf/planet-latest.osm.pbf --output planet-latest-mirror.osm.pbf"
}

action "docker://debian:jessie-1" {
  uses = "docker://debian:jessie"
  runs = "curl https://planet.osm.org/pbf/planet-latest.osm.pbf --output planet-latest-official.osm.pbf"
}

action "docker://debian:jessie-2" {
  uses = "docker://debian:jessie"
  needs = ["docker://debian:jessie", "docker://debian:jessie-1", "pfisterer/openstreetmap-osmosis-docker@master"]
  runs = "echo The End"
}