with source as (
    select
        q.id as question_id,
        q.answer_count,
        q.accepted_answer_id,
        trim(tag) as tag
    from {{ ref('posts_questions') }} q
    cross join unnest(split(q.tags, '|')) tag
)
select
    tag,
    count(*) as total_questions,
    sum(case when answer_count = 0 then 1 else 0 end) as unanswered_questions,
    round(safe_divide(sum(case when answer_count = 0 then 1 else 0 end), count(*)), 4) as unanswered_ratio,
    round(avg(answer_count), 4) as avg_answers,
    sum(case when accepted_answer_id is null then 1 else 0 end) as no_accepted_answer,
    round(safe_divide(sum(case when accepted_answer_id is null then 1 else 0 end), count(*)), 4) as no_accepted_ratio
from source
group by tag
having count(*) > 100
order by unanswered_ratio desc, total_questions desc
