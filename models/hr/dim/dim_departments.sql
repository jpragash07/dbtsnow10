{{
    config(
        materialized='incremental',
        unique_key='department_id',
	incremental_strategy = 'delete+insert',
	tags = ['dim']
    )
}}
select 
DEPARTMENT_ID,
DEPARTMENT_NAME,
MANAGER_ID,
LOCATION_ID,
LOAD_TIME
from {{ref('stg_departments')}}

{% if is_incremental() %}

{{ inc() }}

{% endif %}