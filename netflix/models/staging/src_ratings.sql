{{ config(materialized = 'table')}}

WITH raw_ratings as (
    select * from {{source('netflix','r_ratings')}}
)

SELECT 
    userId as user_id,
    movieId as movie_id,
    rating,
    TO_TIMESTAMP_LTZ(timestamp) as rating_timestamp
    FROM raw_ratings