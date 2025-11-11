# StackOverflow-Project

## BigQuery
- BigQuery script StackOverFlow_analysis.sql - checking the Stackoverflow dataset, getting familiar with a structure of the data, splitting the column of tags, preparing dataset

Dataset: `stackoverflow-project-477512.stackoverflow_us`

Contains:
- `topics` – aggregated metrics for StackOverflow tags (topics)

Due to Google Cloud IAM restrictions, the dataset cannot be shared publicly.
Screenshots below show structure and sample data.

<img width="870" height="449" alt="image" src="https://github.com/user-attachments/assets/a2563ecb-4b44-47d4-86fd-e2c5102852e5" />
<img width="802" height="448" alt="image" src="https://github.com/user-attachments/assets/76283285-f3f8-4fc0-bd4f-8ff5db52e514" />
The `topics` was created in order to check and prepare possible fact file in dbt part of the project. 
## dbt 

The dbt project contains:
- `staging/posts_questions.sql` — staging model pulling the data from BigQuery (`posts_questions` table)
- `marts/fact_file.sql` — fact table aggregating metrics for unanswered topics
- `schema.yml` — tests and documentation for dbt models

Documentation generated with `dbt docs generate`.
Below is the lineage diagram ("star schema") generated from dbt documentation, showing model dependencies:
<img width="650" height="275" alt="Zrzut ekranu 2025-11-11 o 12 24 23" src="https://github.com/user-attachments/assets/6b76035d-63a2-45cf-92db-ee61a8ae21d7" />


