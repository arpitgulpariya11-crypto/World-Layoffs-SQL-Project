-- cleaning data

select * 
FROM layoffs;

-- 1. Remove Duplicates
-- 2. Standardize the Data
-- 3. Null Values or blank values
-- 4. Remove Any columns

CREATE TABLE layoffs_staging
LIKE layoffs ;

select *
FROM layoffs_staging ;

INSERT INTO layoffs_staging
SELECT *
FROM layoffs ;

SELECT *, 
ROW_NUMBER() over(partition by company,location,
industry,total_laid_off,percentage_laid_off,`date`,
 stage,country,funds_raised_millions ) AS row_num
FROM layoffs_staging ;

CREATE TABLE `layoffs_staging2` (
  `company` text,
  `location` text,
  `industry` text,
  `total_laid_off` int DEFAULT NULL,
  `percentage_laid_off` text,
  `date` text,
  `stage` text,
  `country` text,
  `funds_raised_millions` int DEFAULT NULL,
  `row_num` int
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

select *
from layoffs_staging2 ;

insert into layoffs_staging2 
SELECT *, 
ROW_NUMBER() over(partition by company,location,
industry,total_laid_off,percentage_laid_off,`date`,
 stage,country,funds_raised_millions ) AS row_num 
FROM layoffs_staging ;
-- insert_info_done

DELETE
FROM layoffs_staging2
WHERE row_num > 1 ;

-- standardizing data

SELECT DISTINCT TRIM(company)
FROM layoffs_staging2 ;

UPDATE layoffs_staging2
SET company = TRIM(company) ;

SELECT DISTINCT industry
FROM layoffs_staging2 
ORDER BY industry ;

UPDATE layoffs_staging2
SET industry = 'Crypto'
WHERE industry LIKE 'Crypto%' 
;

SELECT *
FROM layoffs_staging2 
WHERE industry is null or industry = '' ;

SELECT DISTINCT country
FROM layoffs_staging2 
WHERE country like 'united states%' ;

UPDATE layoffs_staging2
SET country = TRIM(TRAILING '.' FROM country)
WHERE country like 'united states%' ;

SELECT `date`,
STR_TO_DATE(`date`, '%m/%d/%Y')
from layoffs_staging2 ;

UPDATE layoffs_staging2
SET `date` = STR_TO_DATE(`date`, '%m/%d/%Y') ;

ALTER TABLE layoffs_staging2 MODIFY `date` DATE ;

SELECT * 
FROM layoffs_staging2
WHERE industry IS NULL
OR industry = '' ;

SELECT *
FROM layoffs_staging2
WHERE company = 'Carvana' ;

UPDATE layoffs_staging2
set industry = NULL
WHERE industry = '' ;

SELECT*
FROM layoffs_staging2 st1
JOIN layoffs_staging2 st2
	ON st1.company = st2.company
WHERE st1.industry  IS NULL 
and st2.industry IS NOT NULL ;

UPDATE layoffs_staging2 st1
JOIN layoffs_staging2 st2
	ON st1.company = st2.company
SET st1.industry = st2.industry
WHERE st1.industry IS NULL
AND st2.industry IS NOT NULL ;

SELECT *
FROM layoffs_staging2 
where total_laid_off is null 
and percentage_laid_off is null ;

DELETE 
FROM layoffs_staging2 
where total_laid_off is null 
and percentage_laid_off is null ;

SELECT *
FROM layoffs_staging2 ;

ALTER TABLE layoffs_staging2 
DROP COLUMN row_num ;
