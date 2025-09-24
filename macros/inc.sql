{% macro inc() %}
   where load_time > (
    SELECT coalesce(max(load_time),'1990-01-01 00:00:00') from {{this}}
   ) 
{% endmacro %}