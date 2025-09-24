{{
    config(
        materialized='view',
        tags =['stg']
    )
}}
select 
COUNTRY_ID,
COUNTRY_NAME,
REGION_ID,
current_timestamp as load_time
from {{source('hr','src_countries')}}
where COUNTRY_ID is not null