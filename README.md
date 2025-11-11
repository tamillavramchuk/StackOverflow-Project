# StackOverflow-Project

## BigQuery
Dataset: `stackoverflow-project-477512.stackoverflow_us`

- BigQuery script `StackOverFlow_analysis.sql` - checking the Stackoverflow dataset, getting familiar with a structure of the data, splitting the column of tags, preparing dataset
- BigQuery script `creating_tables.sql` - creating tables using stackoverflow_us dataset

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

## Looker 
Here is the link to `Looker report`
[https://lookerstudio.google.com/reporting/3661e0ff-6ce6-4efd-81db-5057f6ff4b81](https://lookerstudio.google.com/reporting/3661e0ff-6ce6-4efd-81db-5057f6ff4b81)
The first 2 slides basically have the answer to the question `“which topics have the highest need for answers?”`. The first slide contains the bar chart sorted by ratio of unanswered questions. The high ratio (>0.5) means that more than 50% of questions are without the answer. So to summarise, the higher ratio = the higher need.   
The third slide named `Number of questions/number of unanswered questions per tag` shows us the top topics with the highest number of questions and the top topics with the highest number of unanswered questions, which we also should take into consideration answering the main question.
The last chart - `scatter plot` - was created in order to identify topics with a high number of questions and a high percentage of missing answers. These "hot spots" can be particularly valuable for analysis.

