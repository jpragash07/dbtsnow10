{{
    config(
        materialized='incremental',
        unique_key='location_id',
	incremental_strategy = 'delete+insert',
	tags = ['dim']
    )
}}
select 
	LOCATION_ID ,
	STREET_ADDRESS ,
	POSTAL_CODE ,
	CITY ,
	STATE_PROVINCE ,
	COUNTRY_ID ,
	LOAD_TIME 
from {{ref('stg_locations')}}

{% if is_incremental() %}

{{ inc() }}

{% endif %}