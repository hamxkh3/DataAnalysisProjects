-- Exploratory Data Analysis

SELECT *
FROM layoffs3;


SELECT MAX(total_laid_off), MAX(percentage_laid_off)
FROM layoffs3

SELECT *
FROM layoffs3
WHERE percentage_laid_off = 1
ORDER BY total_laid_off DESC;

SELECT *
FROM layoffs3
WHERE percentage_laid_off = 1
ORDER BY funds_raised_millions DESC;


SELECT company, SUM(total_laid_off)
FROM layoffs
GROUP BY company
ORDER BY 2 DESC;


SELECT MIN(`date`), MAX(`date`)
FROM layoffs3;


SELECT country, SUM(total_laid_off)
FROM layoffs3
GROUP BY country
ORDER BY 2 DESC;


SELECT YEAR(`date`), SUM(total_laid_off)
FROM layoffs3
GROUP BY YEAR(`date`)
ORDER BY 1 DESC;


SELECT stage, SUM(total_laid_off)
FROM layoffs3
GROUP BY stage
ORDER BY 2 DESC;


--  ROLLING TOTAL OF TOTAL EMPLOYEES LAID OFF BY MONTH OF EACH YEAR

With Rolling_total AS
(
SELECT SUBSTRING(`date`, 1, 7) AS `Month`, SUM(total_laid_off) AS total_off
FROM layoffs3
WHERE SUBSTRING(`date`, 1, 7) is NOT NULL
GROUP BY SUBSTRING(`date`, 1, 7)
ORDER BY 1
)
SELECT `Month`, total_off, SUM(total_off) OVER(ORDER BY `Month`) AS rolling_total
FROM Rolling_total;

SELECT company, YEAR(`date`), SUM(total_laid_off)
FROM layoffs3
GROUP BY company, YEAR(`date`)
ORDER BY 3 DESC;

WITH company_year (company, years, total_laid_off) AS
(
SELECT company, YEAR(`date`), SUM(total_laid_off)
FROM layoffs3
GROUP BY company, YEAR(`date`)
), company_year_rank AS
(
SELECT *, DENSE_RANK() OVER(PARTITION BY years ORDER BY total_laid_off DESC) AS `rank`
FROM company_year
WHERE years is NOT NULL
)
SELECT * 
FROM company_year_rank
WHERE `rank` <= 5















