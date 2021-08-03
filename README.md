# OpenStreetMap Lake Labels


<img align="right" alt="Lake center lines for labels" width="250" src="lakelines.png" />

An "updated version" of Lukas Martinelli's osm-lakelines using newer base images, Imposm3 0.11.1, Python 3.8, NetworkX 2+ and ungarj's updated label_centerlines repsitory. There are two main reasons for this version, one being OpenMapTiles repository is still pulling from Luka's version 0.9 of global lake lines. The second being the problems I had with foreign character sets (UTF-8) in Python 2 while running Luka's code.

Database parameters are now parsed from .env and .env-postgres so to integrate with OpenMapTiles. The parameter -segmentize_maxlen is increased from 0.5 to 100 in order to tackle a ["Polygon has too few points" error](https://github.com/RanadeepPolavarapu/docker-nginx-http3/issues/7).

Otherwise everything remains **relatively** identical.

Calculate nice centered linestrings for labelling lake polygons.
This repository provides downloadable Shapefiles containing center lines for lake polygons
that you can use to label OSM lake polygons. You can match the OSM ID of the linestrings to your
data source to merge the data.

It is using [ungarj/label_centerlines](https://github.com/ungarj/label_centerlines) from Joachim Ungar to calculate the center lines. This doesn't always result the optimal result and has issues with more complicated lake structures but is sufficient enough for most use cases. Linestrings are not calculated for all lake polygons. Very small polygons, multi polygons and lakes without names are excluded.

## Run Workflow

The entire project is structured components using Docker containers
to work together. Ensure you meet the prerequisites.

- Install [Docker](https://docs.docker.com/engine/installation/)
- Install [Docker Compose](https://docs.docker.com/compose/install/)

Start up the PostgreSQL database with the PostGIS extension.

```bash
docker-compose up -d postgres
```

Now download a OSM PBF extract and store it in the `./data` dir.

```bash
wget -P ./data https://download.geofabrik.de/europe/andorra-latest.osm.pbf
```

Import the OSM PBF.

```bash
docker-compose run import-osm
```

Export a Shapefile containing simplified lake polygons.

```bash
docker-compose run export-shapefile
```

Calculate lake center lines from the previously exported Shapefile.

```bash
docker-compose run calculate-centerlines
```
