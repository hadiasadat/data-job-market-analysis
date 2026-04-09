-- =========================================
-- DATA JOB MARKET ANALYSIS (SQLITE)
-- =========================================

-- 1. DATA CLEANING
-- Remove rows with missing salary values

CREATE TABLE jobs_clean AS
SELECT *
FROM data_jobs_salary
WHERE salary_year_avg IS NOT NULL;


-- =========================================
-- 2. GENERAL OVERVIEW
-- =========================================

-- Total number of jobs
SELECT COUNT(*) AS total_jobs
FROM jobs_clean;

-- Jobs by country
SELECT 
    job_country,
    COUNT(*) AS total_jobs
FROM jobs_clean
GROUP BY job_country
ORDER BY total_jobs DESC;


-- =========================================
-- 3. TOP PAYING JOB ROLES
-- =========================================

SELECT 
    job_title_short,
    ROUND(AVG(salary_year_avg), 2) AS avg_salary
FROM jobs_clean
GROUP BY job_title_short
ORDER BY avg_salary DESC;


-- =========================================
-- 4. MOST IN-DEMAND JOBS
-- =========================================

SELECT 
    job_title_short,
    COUNT(*) AS total_jobs
FROM jobs_clean
GROUP BY job_title_short
ORDER BY total_jobs DESC;


-- =========================================
-- 5. FOCUS: UNITED STATES 🇺🇸
-- =========================================

-- Jobs in the US only
SELECT COUNT(*) AS us_jobs
FROM jobs_clean
WHERE job_country = 'United States';


-- Top roles in the US
SELECT 
    job_title_short,
    COUNT(*) AS total_jobs
FROM jobs_clean
WHERE job_country = 'United States'
GROUP BY job_title_short
ORDER BY total_jobs DESC;


-- Average salary in the US by role
SELECT 
    job_title_short,
    ROUND(AVG(salary_year_avg), 2) AS avg_salary
FROM jobs_clean
WHERE job_country = 'United States'
GROUP BY job_title_short
ORDER BY avg_salary DESC;


-- =========================================
-- 6. SKILLS ANALYSIS
-- =========================================

-- Python vs No Python (global)
SELECT 
    CASE 
        WHEN job_skills LIKE '%python%' THEN 'Python'
        ELSE 'No Python'
    END AS skill_group,
    ROUND(AVG(salary_year_avg), 2) AS avg_salary
FROM jobs_clean
GROUP BY skill_group;


-- Python vs No Python (US only)
SELECT 
    CASE 
        WHEN job_skills LIKE '%python%' THEN 'Python'
        ELSE 'No Python'
    END AS skill_group,
    ROUND(AVG(salary_year_avg), 2) AS avg_salary
FROM jobs_clean
WHERE job_country = 'United States'
GROUP BY skill_group;


-- =========================================
-- 7. HIGH-PAYING JOBS (OVER 150K)
-- =========================================

SELECT 
    job_title_short,
    job_country,
    salary_year_avg
FROM jobs_clean
WHERE salary_year_avg > 150000
ORDER BY salary_year_avg DESC;


-- =========================================
-- 8. LOCATION ANALYSIS
-- =========================================

-- Top locations by job count
SELECT 
    job_location,
    COUNT(*) AS total_jobs
FROM jobs_clean
GROUP BY job_location
ORDER BY total_jobs DESC
LIMIT 10;


-- =========================================
-- 9. REMOTE WORK ANALYSIS
-- =========================================

SELECT 
    job_work_from_home,
    COUNT(*) AS total_jobs,
    ROUND(AVG(salary_year_avg), 2) AS avg_salary
FROM jobs_clean
GROUP BY job_work_from_home;


-- =========================================
-- END OF ANALYSIS
-- =========================================
