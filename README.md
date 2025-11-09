# StackOverflow-Project

## BigQuery
- BigQuery script StackOverFlow.sql - checking the Stackoverflow dataset, getting familiar with a structure of the data, splitting the column of tags, preparing dataset

Dataset: `stackoverflow-project-477512.stackoverflow_us`

Contains:
- `topics` – aggregated metrics for StackOverflow tags (topics)

Due to Google Cloud IAM restrictions, the dataset cannot be shared publicly.
Screenshots below show structure and sample data.

<img width="870" height="449" alt="image" src="https://github.com/user-attachments/assets/a2563ecb-4b44-47d4-86fd-e2c5102852e5" />
<img width="802" height="448" alt="image" src="https://github.com/user-attachments/assets/76283285-f3f8-4fc0-bd4f-8ff5db52e514" />

## dbt 

The dbt project contains:
- `staging/so_file.sql` — staging model pulling the data from BigQuery (`topics` table)
- `marts/fact_file.sql` — fact table aggregating metrics for unanswered topics
- `marts/dimensions_tag.sql` — dimension table with unique tags
- `schema.yml` — tests and documentation for dbt models

Documentation generated with `dbt docs generate`.
Below is the lineage diagram generated from dbt documentation, showing model dependencies:
<img width="1402" height="730" alt="image" src="https://github.com/user-attachments/assets/61ecfe48-8662-4a6c-8b10-e322132215ad" />

