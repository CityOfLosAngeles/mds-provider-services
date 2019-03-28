DROP VIEW IF EXISTS devices_7_days CASCADE;

CREATE VIEW devices_7_days AS

select
    concat(provider_name, '_', vehicle_type) as provider,
    cast(event_day as date) as day,
    distinct_devices as devices
from
    deployments_daily
where
    event_day in (
        select distinct event_day
        from deployments_daily
        order by event_day desc limit 7
    )
order by
    provider, day;