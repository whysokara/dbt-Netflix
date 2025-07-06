# dbt-Netflix

# 🎬 Netflix Analytics with dbt

This is a **dbt (data build tool)** project that models and analyzes movie ratings and tag data to simulate Netflix-style analytics. The project demonstrates a modern data stack workflow — from ingestion to transformation to analysis.

---

## 🛠 Project Overview

This project simulates a real-world analytics pipeline for Netflix-style movie data by:

- 📥 Ingesting public data from a **mock API**
- 🪣 Uploading the data to an **Amazon S3 bucket**
- ❄️ Using **Snowflake’s external stage and file format** to load data from S3
- 🧱 Transforming raw data into trusted models using **dbt**
- 📊 Building dimensional models, fact tables, and reporting marts

---

## 📂 Project Structure

```bash
models/
├── schema.yml                 # Global tests and docs
├── staging/                   # Source-level cleaning & typing
│   ├── source.yml             # dbt source configs
│   ├── src_genome_scores.sql
│   ├── src_movies.sql
│   ├── src_tags.sql
│   ├── src_ratings.sql
│   └── ...
├── dim/                       # Dimension models (slow-changing, descriptive)
│   ├── dim_users.sql
│   ├── dim_genome_tags.sql
│   └── dim_movies.sql
├── fct/                       # Fact models (event and transaction tables)
│   ├── fct_ratings.sql
│   └── fct_genome_scores.sql
└── mart/                      # Business-facing aggregated outputs
    └── mart_movie_releases.sql

Data Flow

📡 Data Collection: Used mock movie & ratings data from a public API (e.g. Kaggle or open datasets).
📤 Data Upload: Uploaded the raw CSV/JSON files into an S3 bucket.
❄️ Snowflake Load: Used Snowflake external stage, file format, and COPY INTO to load data from S3 into Snowflake raw tables.
⚙️ dbt Transformation:
Created staging models to clean and format raw data
Created dim and fct models to build a star schema
Added mart models to support business insights

🧠 Key Features

🔧 dbt-based data transformation from raw S3 → Snowflake → Trusted models
🧱 Star schema with dimension and fact models
🧪 Robust testing: not_null, unique, relationships
🔍 Surrogate key generation using dbt_utils.generate_surrogate_key
📊 Aggregated movie ratings and tag relevance scores
📄 Descriptions + schema documentation for all models and columns

 How to Run

📦 Requirements
Python + Virtualenv or Conda
dbt v1.10+ (dbt-snowflake)
Access to Snowflake & S3
🔧 Setup Instructions
# 1. Clone the repo
git clone https://github.com/<your-username>/netflix-dbt.git
cd netflix-dbt

# 2. Set up virtual environment
python -m venv venv
source venv/bin/activate

# 3. Install dbt for Snowflake
pip install dbt-snowflake

# 4. Install packages
dbt deps

# 5. Configure your Snowflake profile (~/.dbt/profiles.yml)
🚀 Run dbt Commands
# Check connection
dbt debug

# Run transformations
dbt run

# Run tests
dbt test

# Generate and view documentation
dbt docs generate
dbt docs serve
📊 Sample SQL Output: Top 20 Rated Movies

WITH ratings_summary AS (
    SELECT
        movie_id,
        AVG(rating) AS average_rating,
        COUNT(*) AS total_ratings
    FROM {{ ref('fct_ratings') }}
    GROUP BY movie_id
    HAVING COUNT(*) > 100
)

SELECT
    m.movie_title,
    rs.average_rating,
    rs.total_ratings
FROM ratings_summary rs
JOIN {{ ref('dim_movies') }} m ON rs.movie_id = m.movie_id
ORDER BY rs.average_rating DESC
LIMIT 20;
📦 Packages Used

dbt-utils — for reusable macros like generate_surrogate_key
snowflake adapter — for data warehousing
✅ Tests Included

not_null and unique for primary keys
relationships between fact & dimension tables
Custom macro to check for nulls across columns:
{% macro no_nulls_in_columns(model) %}
  SELECT * FROM {{ model }} WHERE
  {% for col in adapter.dbt_utils.get_filtered_columns_in_relation(model) %}
    {{ col.column }} IS NULL OR
  {% endfor %}
  FALSE
{% endmacro %}
