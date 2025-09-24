{{
    config(
        materialized='incremental',
        unique_key='employee_id',
	    incremental_strategy = 'delete+insert',
	    tags = ['fct']
    )
}}
{% set max_load_time = "(select coalesce(max(LOAD_TIME),'1900-01-01') from "~this~")" %}
select 
	emp.EMPLOYEE_ID ,
	emp.job_id ,
	emp.department_id ,
	dept.location_id,
	loc.country_id ,
	con.region_id ,
	sal.date as salary_date,
	emp.salary as basic_salary,
	sal.HRA ,
	sal.ALLOWANCES ,
	sal.PF ,
	(emp.salary+sal.HRA+sal.ALLOWANCES+sal.PF) as gross_salary,
	(emp.salary+sal.HRA+sal.ALLOWANCES) as net_salary,
	current_timestamp LOAD_TIME 
from {{ref('stg_salary')}} as sal
join {{ref('dim_employees')}} as emp
on sal.employee_id = emp.employee_id
join {{ref('dim_departments')}} as dept
on dept.department_id = emp.department_id
join  {{ref('dim_jobs')}} as job
on emp.job_id = job.job_id
join  {{ref('dim_locations')}} as loc
on dept.location_id = loc.location_id
join  {{ref('dim_countries')}} as con
on loc.country_id = con.country_id
join  {{ref('dim_regions')}} as reg
on con.region_id = reg.region_id

{% if is_incremental() %}

where sal.load_time > {{max_load_time}}
or emp.load_time > {{max_load_time}}
or dept.load_time > {{max_load_time}}
or job.load_time > {{max_load_time}}
or con.load_time > {{max_load_time}}
or reg.load_time > {{max_load_time}}

{% endif %}
