WITH src_movies as (
    SELECT * FROM {{ ref('src_movies') }}
)

SELECT
    movie_id,
    INITCAP(TRIM(title)) as movie_title,
    SPLIT(genres, '|') as genere_array
FROM src_movies

