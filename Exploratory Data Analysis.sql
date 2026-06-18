-- Exploratory Data Analysis 

SELECT *
FROM layoffs_staging2 ;

SELECT  MAX(total_laid_off),MAX(percentage_laid_off)
FROM layoffs_staging2 ;

SELECT *
FROM layoffs_staging2
WHERE percentage_laid_off = 1 
order by funds_raised_millions DESC ;

SELECT company , sum(total_laid_off)
FROM layoffs_staging2 
GROUP BY company
ORDER BY 2 desc ;

select min(`date`) , max(`date`)
FROM layoffs_staging2 ;

select `date` ,sum(total_laid_off)
from layoffs_staging2 
where `date` = (select min(`date`) from layoffs_staging2)
or `date` = (select max(`date`) from layoffs_staging2)  
group by `date`;

select sum(total_laid_off), sum(funds_raised_millions)
from layoffs_staging2 ;

select industry , sum(total_laid_off) as sumoff
from layoffs_staging2 
GROUP BY industry 
order by sumoff desc ;

select country , sum(total_laid_off) as sumoff
from layoffs_staging2 
GROUP BY country 
order by sumoff desc ;

select `date` , sum(total_laid_off) as sumoff
from layoffs_staging2 
GROUP BY `date` 
order by `date` desc ;

select YEAR(`date`) , sum(total_laid_off) as sumoff
from layoffs_staging2 
GROUP BY YEAR(`date`) 
order by 1 desc ;

select month(`date`) , sum(total_laid_off) as sumoff
from layoffs_staging2 
GROUP BY month(`date`) 
order by 1 desc ;

select day(`date`) , sum(total_laid_off) as sumoff
from layoffs_staging2
where  day(`date`) IS NOT NULL
GROUP BY day(`date`) 
order by 1 asc ;

select substring(`date` , 1,7) as month , sum(total_laid_off)
from layoffs_staging2
where substring(`date` , 1,7) is not null
group by `month` 
order by 1 asc ;

WITH Rolling_Total as 
(
select substring(`date` , 1,7) as month , sum(total_laid_off) as total_off
from layoffs_staging2
where substring(`date` , 1,7) is not null
group by `month` 
order by 1 asc 
)
SELECT `MONTH` ,total_off ,
sum(total_off) over(order by `MONTH`) as rolling_total
FROM Rolling_Total ;

WITH company_year( company , years , total_layoff)  as 
(
SELECT company , year(`date`), sum(total_laid_off) as total_layoffs
FROM layoffs_staging2
GROUP BY company , year(`date`)
), Company_YEAR_Rank AS
(SELECT *, DENSE_RANK() OVER(PARTITION BY years ORDER BY total_layoff DESC) AS Ranking
FROM company_year 
WHERE years IS NOT NULL
)
SELECT *
FROM Company_YEAR_Rank
where Ranking <= 5  ;

