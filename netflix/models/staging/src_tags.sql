{{ config(materialized = 'table')}}
WITH raw_tags as (
    select * from {{source('netflix','r_tags')}}
)

SELECT 
    userId as user_id,
    movieId as movie_id,
    tag,
    TO_TIMESTAMP_LTZ(timestamp) as tag_timestamp
    FROM raw_tags