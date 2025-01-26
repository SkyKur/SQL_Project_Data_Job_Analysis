/* Identify the top 5 most in demand skills for Data Analyst*/
SELECT sd.skills,
    COUNT (job_postings_fact.job_id) AS job_count
FROM job_postings_fact
LEFT JOIN skills_job_dim AS sjd
    ON job_postings_fact.job_id = sjd.job_id
LEFT JOIN skills_dim AS sd
    ON sjd.skill_id = sd.skill_id
WHERE job_title_short = 'Data Analyst'
GROUP BY sd.skills
ORDER BY job_count DESC
LIMIT 5;