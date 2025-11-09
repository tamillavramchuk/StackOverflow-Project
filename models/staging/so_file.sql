with source as (
    select * from `stackoverflow-project-477512.stackoverflow_us.topics`
)
select
    tag as tag_name,
    total_questions,
    unanswered_questions,
    unanswered_ratio,
    avg_answers,
    no_accepted_answer,
    no_accepted_ratio
from source
