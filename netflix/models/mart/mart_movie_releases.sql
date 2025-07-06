{{config(materialized = 'table')}}

with fct_ratings AS (
    SELECT * FROM {{ref('fct_ratings')}}
),
seed_dates AS (
    SELECT * FROM {{ref('seed_movie_release_dates')}}
)

SELECT
    f.*,
    case
        when d.release_date IS NULL THEN 'unknown'
        else 'known'
        end as release_info_available
FROM fct_ratings f
left join seed_dates d
on f.movie_id = d.movie_id