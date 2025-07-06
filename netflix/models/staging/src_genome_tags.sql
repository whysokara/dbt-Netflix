WITH raw_genome_tags as (
    select * from {{source('netflix','r_genome_tags')}}
)

SELECT 
    tagId as tag_id,
    tag
FROM raw_genome_tags 