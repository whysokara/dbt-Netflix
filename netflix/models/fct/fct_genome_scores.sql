WITH src_scores AS (
    SELECT * FROM {{ref('src_genome_scores')}}
)

SELECT 
    movie_id,
    tag_id,
    ROUND(relevance, 4) as relevance_score

    FROM src_scores
    where relevance > 0