{{
    config(
        materialized='incremental',
        unique_key='job_id',
	incremental_strategy = 'delete+insert',
	tags = ['dim']
    )
}}
select 
JOB_ID,
JOB_TITLE,
MIN_SALARY,
MAX_SALARY,
LOAD_TIME
from {{ref('stg_jobs')}}

{% if is_incremental() %}

{{ inc() }}

{% endif %}