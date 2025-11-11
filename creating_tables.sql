#Creating table Users
CREATE TABLE `stackoverflow-project-477512.stackoverflow_us.users` AS SELECT *
  FROM
`bigquery-public-data.stackoverflow.users`;

#Creating table post_questions 
CREATE TABLE `stackoverflow-project-477512.stackoverflow_us.posts_questions` AS SELECT *
  FROM
`bigquery-public-data.stackoverflow.posts_questions`;

#Creating table tags
CREATE TABLE `stackoverflow-project-477512.stackoverflow_us.tags` as
   SELECT *
    FROM
  `bigquery-public-data.stackoverflow.tags`;

#Creating table post_answers
CREATE TABLE `stackoverflow-project-477512.stackoverflow_us.posts_answers` AS
  SELECT *
    FROM
  `bigquery-public-data.stackoverflow.posts_answers`;