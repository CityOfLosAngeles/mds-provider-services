# ingest

Pull data from `provider` API endpoints and load to a Postgres database.

## Running

First, copy and edit the sample configuration file:

```bash
$ cp .config.sample .config
```

Next, ensure the image is up to date locally:

```bash
$ docker-compose build --no-cache ingest
```

Then run the data ingester:

```bash
$ docker-compose run --rm ingest [OPTIONS]
```

### [OPTIONS]

Note: you must provide a range of time to query using some combination of `start_time`, `end_time`, and `duration`. Providing both `start_time` and `end_time` takes precedence over either of them with `duration`.

Options include:

#### `--bbox BBOX`

The bounding-box with which to restrict the results of this request.

The order is (separated by commas):
  - southwest longitude,
  - southwest latitude,
  - northeast longitude,
  - northeast latitude

For example:

```console
--bbox -122.4183,37.7758,-122.4120,37.7858
```

#### `--config CONFIG`

Path to a provider configuration file to use. The default is `.config`.

#### `--device_id DEVICE_ID`

The device_id to obtain results for. Only applies to `--trips`.

#### `--duration DURATION`

Number of seconds; with `--start_time` or `--end_time` defines a time query range.

#### `--end_time END_TIME`

The end of the time query range for this request. Should be either int Unix seconds or ISO-8061 datetime format.

#### `--no_load`

Do not attempt to load any returned data into a database.

#### `--no_paging`

Flag indicating paging through the response should *not* occur. Return only the first page of data.

#### `--no_validate`

Do not perform JSON Schema validation against the returned data.

#### `--output OUTPUT`

Base path to write data files into.

#### `--providers PROVIDER [PROVIDER ...]`

One or more providers to query, identified either by `provider_name` or `provider_id`.

The default is to query all configured providers.

#### `--ref REF`

Git branch name, commit hash, or tag at which to reference MDS. The default is `master`.

#### `--start_time START_TIME`

The beginning of the time query range for this request. Should be either int Unix seconds or ISO-8061 datetime format.

#### `--status_changes`

Flag indicating Status Changes should be requested.

#### `--trips`

Flag indicating Trips should be requested.

#### `--vehicle_id VEHICLE_ID`

The `vehicle_id` to obtain results for. Only applies to `--trips`.

### Helper Scripts

A number of scripts are available in [`bin/`](bin/) to help ease the process of running repeated
ingestion jobs.

`[OPTIONS]` below is the same list of options for the ingestion script listed above.

#### [`hourly.sh`](bin/hourly.sh)

Ingest data for the previous hour.

E.g. if running at `12:45pm`, ingest data for `11:00am` to `12:00pm`.

```console
$ bin/hourly.sh [--providers [PROVIDER]] [--status_changes] [--trips] [OPTIONS]
```

#### [`validate.sh`](bin/validate.sh)

Validate a data feed, without loading the data into the database.

```console
$ bin/validate.sh [--providers [PROVIDER]] [--status_changes] [--trips] [OPTIONS]
```