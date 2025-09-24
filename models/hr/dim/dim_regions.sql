{{
    config(
        materialized='incremental',
        unique_key='region_id',
	    incremental_strategy = 'delete+insert',
	tags = ['dim']
    )
}}
select
	region_id ,
	region_name ,
	current_timestamp as load_time 
from {{ref('stg_regions')}}

{% if is_incremental() %}

{{ inc() }}

{% endif %}