{% macro drop_ci_schemas(database=target.database, dryrun=True) %}

    {% set all_schemas_to_drop = [] %}

    {% set drop_schema_sql %}

    {% set find_schemas_sql %}
        SELECT SCHEMA_NAME
        FROM {{ database }}.INFORMATION_SCHEMA.SCHEMATA
        WHERE SCHEMA_NAME LIKE 'dev';
    {% endset %}

    {% set schemas_to_drop = run_query(find_schemas_sql) %}

    {% for row in schemas_to_drop %}
        {% do adapter.drop_schema(api.Relation.create(database=target.database, schema="dev")) %}
        {% do all_schemas_to_drop.append('{}.{}'.format(database, row[0])) %}
    {% endfor %}

    {% endset %}

    {% if all_schemas_to_drop %}
        {% if dryrun %}
            {% do log('*NOT* dropping {}'.format(all_schemas_to_drop), info=True) %}
        {% else %}
            {% do log('Dropping: {} ...'.format(all_schemas_to_drop), info=True) %}
            {% do log('Done.', info=True) %}
        {% endif %}
    {% else %}
        {% do log('No schemas to drop!', info=True) %}
    {% endif %}

{% endmacro %}
