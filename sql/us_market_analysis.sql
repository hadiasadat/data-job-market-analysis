-- =========================================
-- US MARKET ANALYSIS
-- =========================================

-- Most in-demand roles in the US
SELECT 
    job_title_short,
    COUNT(*) AS total_jobs
FROM jobs_clean
WHERE job_country = 'United States'
GROUP BY job_title_short
ORDER BY total_jobs DESC;

-- Highest paying roles in the US
SELECT 
    job_title_short,
    ROUND(AVG(salary_year_avg), 2) AS avg_salary
FROM jobs_clean
WHERE job_country = 'United States'
GROUP BY job_title_short
ORDER BY avg_salary DESC;

-- Top locations in the US
SELECT 
    job_location,
    COUNT(*) AS total_jobs
FROM jobs_clean
WHERE job_country = 'United States'
GROUP BY job_location
ORDER BY total_jobs DESC;

-- Remote vs non-remote in the US
SELECT 
    job_work_from_home,
    COUNT(*) AS total_jobs,
    ROUND(AVG(salary_year_avg), 2) AS avg_salary
FROM jobs_clean
WHERE job_country = 'United States'
GROUP BY job_work_from_home;
