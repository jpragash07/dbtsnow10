{{
    config(
        materialized='incremental',
        unique_key='id'
    )
}}
select * from JP_DBT.DBT_JP_SC.TEMP_SAM_DATA