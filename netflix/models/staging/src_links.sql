WITH raw_links as (
    select * from {{source('netflix','r_links')}}
)

SELECT 
    movieId as movie_id,
    imdbId as imdb_id,
    tmdbId as tmdb_id
    FROM raw_links