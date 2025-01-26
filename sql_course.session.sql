SELECT job_id,
    salary_year_avg
FROM january_jobs
WHERE salary_year_avg >70000
UNION
SELECT job_id,
    salary_year_avg
FROM february_jobs
WHERE salary_year_avg >70000
UNION
SELECT job_id,
    salary_year_avg
FROM march_jobs
WHERE salary_year_avg >70000