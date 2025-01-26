-- Step 1: Find the most demanded skills and the highest-paying skills for Data Analysts
WITH most_demanded AS (
    SELECT 
        sd.skills,
        sd.skill_id,
        COUNT(jpf.job_id) AS job_count
    FROM job_postings_fact AS jpf
    LEFT JOIN skills_job_dim AS sjd
        ON jpf.job_id = sjd.job_id
    LEFT JOIN skills_dim AS sd
        ON sjd.skill_id = sd.skill_id
    WHERE jpf.job_title_short = 'Data Analyst'
    GROUP BY sd.skill_id
    ORDER BY job_count DESC
),
highest_paying AS (
    SELECT 
        sd.skills,
        ROUND(AVG(jpf.salary_year_avg), 1) AS avg_salary
    FROM job_postings_fact AS jpf
    INNER JOIN skills_job_dim AS sjd
        ON jpf.job_id = sjd.job_id
    INNER JOIN skills_dim AS sd
        ON sjd.skill_id = sd.skill_id
    WHERE jpf.job_title_short = 'Data Analyst' 
      AND jpf.salary_year_avg IS NOT NULL
    GROUP BY sd.skill_id
    ORDER BY avg_salary DESC
)

SELECT
    md.skill_id,
    md.skills,
    md.job_count,
    hp.avg_salary
FROM most_demanded AS md
INNER JOIN highest_paying AS hp
    ON md.skills = hp.skills
ORDER BY md.job_count DESC, hp.avg_salary DESC;
