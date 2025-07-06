WITH raw_genome_scores as (
    select * from {{source('netflix','r_genome_scores')}}
)

SELECT 
    movieId as movie_id,
    tagId as tag_id,
    relevance
    FROM raw_genome_scores