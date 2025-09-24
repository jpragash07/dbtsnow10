{{
    config(
        materialized='view',
        tags =['stg'],
        schema = 'stg'
    )
}}
select
	region_id ,
	region_name ,
	current_timestamp as load_time 
from {{source('hr','src_regions')}}
where region_id is not null