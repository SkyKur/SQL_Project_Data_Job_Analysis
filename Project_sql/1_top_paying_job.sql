/*
Question: What are the top-paying data analyst jobs?
-Identify the top 10 highest-paying Data Analyst roles that are available remotely.
-Focuses on job postings with specified salaries (remove nulls).
-Why?  Highlight the top-paying opportunities for Data Analysts 
*/
--Create a CTE for remote jobs
WITH remote_jobs AS (
    SELECT job_id,
        job_location,
        salary_year_avg,
        job_title,
        company_id
    FROM job_postings_fact
    WHERE salary_year_avg IS NOT NULL
    AND job_location = 'Anywhere'
    AND job_title_short = 'Data Analyst'
)
--Select the top 10 highest paying roles
SELECT rj.job_title,
    cd.name AS company_name,
    rj.salary_year_avg
FROM remote_jobs AS rj
LEFT JOIN company_dim AS cd -- Join remote_jobs with company_dim
    ON rj.company_id = cd.company_id -- Match company IDs
ORDER BY salary_year_avg DESC
LIMIT 10;