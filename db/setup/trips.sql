DROP TABLE IF EXISTS trips CASCADE;

CREATE TABLE trips (
    provider_id UUID NOT NULL,
    provider_name TEXT NOT NULL,
    device_id UUID NOT NULL,
    vehicle_id TEXT NOT NULL,
    vehicle_type vehicle_types NOT NULL,
    propulsion_type propulsion_types[] NOT NULL,
    trip_id UUID NOT NULL,
    trip_duration INT NOT NULL,
    trip_distance INT NOT NULL,
    route jsonb NOT NULL,
    accuracy INT NOT NULL,
    start_time timestamptz NOT NULL,
    end_time timestamptz NOT NULL,
    parking_verification_url TEXT,
    standard_cost INT,
    actual_cost INT,
    sequence_id bigserial NOT NULL,
);

ALTER TABLE trips
    ADD CONSTRAINT pk_trip
    PRIMARY KEY (provider_id, trip_id);