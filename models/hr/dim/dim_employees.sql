{{
    config(
        materialized='incremental',
        unique_key='EMPLOYEE_ID',
	incremental_strategy = 'delete+insert',
	tags = ['dim']
    )
}}
select EMPLOYEE_ID,
FIRST_NAME,
LAST_NAME,
EMAIL,
PHONE_NUMBER,
HIRE_DATE,
JOB_ID,
SALARY,
COMMISSION_PCT,
MANAGER_ID,
DEPARTMENT_ID,
LOAD_TIME
from {{ref('stg_employees')}}

{% if is_incremental() %}

{{ inc() }}

{% endif %}