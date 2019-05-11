workflow "Test" {
  on = "watch"
  resolves = [
    "Dl official",
    "Crop to France",
  ]
}

action "Dl mirror" {
  uses = "byrnedo/docker-alpine-curl@master"
  runs = "curl https://ftp5.gwdg.de/pub/misc/openstreetmap/planet.openstreetmap.org/pbf/planet-latest.osm.pbf --output planet-latest-mirror.osm.pbf"
}

action "Dl official" {
  uses = "byrnedo/docker-alpine-curl@master"
  runs = "curl https://planet.osm.org/pbf/planet-latest.osm.pbf"
}

action "Crop to France" {
  needs = [
    "Dl mirror",
    "Dl official",
  ]
  uses = "pfisterer/openstreetmap-osmosis-docker@master"
  args = "--read-pbf planet-latest-official.osm.pbf --bounding-box top=51.15 left=-5.2 bottom=42.3 right=8.32 --write-pbf planet-france.osm.pbf"
}
