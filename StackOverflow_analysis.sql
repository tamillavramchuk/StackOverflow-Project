/*The main question we need to get the answer is “which topics have the highest need for answers?”.
Which means we could interpret it as: give me a list of the topics, 
where we have both a lot of questions and lack of the answers
*/
#lets check the list of the tables
SELECT
  table_name
FROM
  `bigquery-public-data.stackoverflow.INFORMATION_SCHEMA.TABLES`;
/* From all these tables to answer the main question 'which topics have the highest need for answers',
we will need tables: 1,6,14

1	posts_answers
2	users
3	posts_orphaned_tag_wiki
4	posts_tag_wiki
5	stackoverflow_posts
6	posts_questions
7	comments
8	posts_tag_wiki_excerpt
9	posts_wiki_placeholder
10	posts_privilege_wiki
11	post_history
12	badges
13	post_links
14	tags
15	votes
16	posts_moderator_nomination */

#lets check one of the tables:posts_questions to get to know the structure of the data
SELECT *
FROM
  `bigquery-public-data.stackoverflow.posts_questions`
  LIMIT 100;

/*Lets have a look on column tags, 
The tags (the topics we are interested in) look like this: python|json|python-3.x
Obviously we need to split the tags, because in 1 question we could get several topics */
SELECT
  q.id AS question_id,
  t AS tag
FROM
  `bigquery-public-data.stackoverflow.posts_questions` q,
  UNNEST(SPLIT(q.tags, '|')) AS t;

/* After spliting the tags into topics we could find the most desirable to know topics */
WITH questions_topic AS (
  SELECT
  q.id AS question_id,
  TRIM(t) AS tag
FROM
  `bigquery-public-data.stackoverflow.posts_questions` q,
  UNNEST(SPLIT(q.tags, '|')) AS t
)
SELECT
  tag,
  COUNT(*) AS topic_questions_cnt
FROM questions_topic
GROUP BY tag
ORDER BY topic_questions_cnt DESC
LIMIT 20;

/*
Using the same splitting table questiongs_topic as in previous query, but adding column answer_count,
now we could: 
1) select rows grouped by tags
2) calculate total of question by tags
3) using 'case when' count all questions with no answer
4) use ratio, where we divide all questions with no answer and all questions in general
ex. if ratio = 0.5, it means 50% of questions are without answer
5) calculate average of answers by topic
Also I added a filter 'having count(*)>100', it means after 'grouping by' we select rows only with total of questions >100. That means I don't take into considerations topics with a small amount of questions. 
Few questions -> topic could be rare, 'unpopular', which means the questions probably have no answers.
If you have doubts, you could always change the code in "<100"
 */
WITH questions_topic AS (
  SELECT
    q.id AS question_id,
    q.answer_count,
    TRIM(t) AS tag
  FROM
    `bigquery-public-data.stackoverflow.posts_questions` q,
    UNNEST(SPLIT(q.tags, '|')) AS t
)
SELECT
  tag,
  COUNT(*) AS total_questions,
  SUM(CASE WHEN answer_count = 0 THEN 1 ELSE 0 END) AS unanswered_questions,
  ROUND(SAFE_DIVIDE(SUM(CASE WHEN answer_count = 0 THEN 1 ELSE 0 END), COUNT(*)),4) AS unanswered_ratio,
  ROUND(AVG(answer_count),4) AS avg_answers
FROM questions_topic
GROUP BY tag
HAVING COUNT(*) > 100  
ORDER BY unanswered_ratio DESC, total_questions DESC
LIMIT 50;

/* The next question we need to find out the aswer is: the total of unaccepted answers by tags.
I used the same trick as before in the previous query. And calculated the ratio of unaccepted answers.
*/
WITH questions_topic AS (
  SELECT
    q.id AS question_id,
    q.accepted_answer_id,
    TRIM(t) AS tag
  FROM
    `bigquery-public-data.stackoverflow.posts_questions` q,
    UNNEST(SPLIT(q.tags, '|')) AS t
)
SELECT
  tag,
  COUNT(*) AS total_questions,
  SUM(CASE WHEN accepted_answer_id IS NULL THEN 1 ELSE 0 END) AS no_accepted_answer,
  ROUND(SAFE_DIVIDE(SUM(CASE WHEN accepted_answer_id IS NULL THEN 1 ELSE 0 END), COUNT(*)), 4) AS no_accepted_ratio
FROM questions_topic
GROUP BY tag
HAVING COUNT(*) > 100
ORDER BY no_accepted_ratio DESC, total_questions DESC
LIMIT 50;

/* Lets create a table using the previous queries. We need this table for next steps of the project*/
CREATE OR REPLACE TABLE `stackoverflow-project-477512.stackoverflow_us.topics` AS
WITH questions_topic AS (
  SELECT
    q.id AS question_id,
    q.answer_count,
    q.accepted_answer_id,
    TRIM(t) AS tag
  FROM
    `bigquery-public-data.stackoverflow.posts_questions` AS q,
    UNNEST(SPLIT(q.tags, '|')) AS t
)
SELECT
  tag,
  COUNT(*) AS total_questions,
  SUM(CASE WHEN answer_count = 0 THEN 1 ELSE 0 END) AS unanswered_questions,
  ROUND(SAFE_DIVIDE(SUM(CASE WHEN answer_count = 0 THEN 1 ELSE 0 END), COUNT(*)), 4) AS unanswered_ratio,
  ROUND(AVG(answer_count),4) AS avg_answers,
  SUM(CASE WHEN accepted_answer_id IS NULL THEN 1 ELSE 0 END) AS no_accepted_answer,
  ROUND(SAFE_DIVIDE(SUM(CASE WHEN accepted_answer_id IS NULL THEN 1 ELSE 0 END), COUNT(*)), 4) AS no_accepted_ratio
FROM questions_topic
GROUP BY tag
HAVING COUNT(*) > 100
ORDER BY unanswered_ratio DESC, total_questions DESC;
