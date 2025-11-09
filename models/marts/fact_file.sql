select
    tag_name,
    total_questions,
    unanswered_questions,
    unanswered_ratio,
    avg_answers,
    no_accepted_answer,
    no_accepted_ratio
from {{ ref('so_file') }}
order by unanswered_ratio desc, total_questions desc
