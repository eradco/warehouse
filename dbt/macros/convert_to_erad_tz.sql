{% macro convert_to_erad_tz(date_column, source_timezone_name) %}
    {%- set erad_tz = 'Asia/Dubai' -%}
    {{- "CONVERT_TIMEZONE({}, '{}', {})".format(source_timezone_name, erad_tz, date_column) -}}
{% endmacro%}