/*
Question: Find the specific skills for the 
top 10 highest-paying data analyst roles.
*/
-- Create CTEs
WITH remote_jobs AS (
    SELECT 
        job_id,
        job_location,
        salary_year_avg,
        job_title,
        company_id
    FROM job_postings_fact
    WHERE salary_year_avg IS NOT NULL
      AND job_location = 'Anywhere'
      AND job_title_short = 'Data Analyst'
),
top_jobs AS (
    -- Select the top 10 highest-paying jobs
    SELECT 
        rj.job_id, -- Include job_id for joining with skills
        rj.job_title,
        cd.name AS company_name,
        rj.salary_year_avg
    FROM remote_jobs AS rj
    LEFT JOIN company_dim AS cd 
        ON rj.company_id = cd.company_id
    ORDER BY rj.salary_year_avg DESC
    LIMIT 10
)
SELECT tj.job_title,
    tj.company_name,
    tj.salary_year_avg,
    sd.skills
FROM top_jobs AS tj
INNER JOIN skills_job_dim as sjd ON tj.job_id = sjd.job_id
INNER JOIN skills_dim as sd ON sjd.skill_id = sd.skill_id
ORDER BY salary_year_avg DESC