Select * 
From layoffs;

Create Table layoffs2
Like layoffs;

Insert Into layoffs2
Select *
From layoffs;


-- Removing of Duplicate Values by Using Row Number

Select *,
ROW_NUMBER() OVER(
PARTITION BY company, location, industry, total_laid_off, percentage_laid_off, `date`, stage, country, funds_raised_millions) row_num
From layoffs2;

With duplicates as
(
Select *,
ROW_NUMBER() OVER(
PARTITION BY company, location, industry, total_laid_off, percentage_laid_off, `date`, stage, country, funds_raised_millions) row_num
From layoffs2
)
Select*
From duplicates
Where row_num > 1

CREATE TABLE `layoffs3` (
  `company` text,
  `location` text,
  `industry` text,
  `total_laid_off` int DEFAULT NULL,
  `percentage_laid_off` text,
  `date` text,
  `stage` text,
  `country` text,
  `funds_raised_millions` int DEFAULT NULL,
  `row_num` INT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


Insert into layoffs3
Select *
ROW_NUMBER() OVER(
PARTITION BY company, location, industry, total_laid_off, percentage_laid_off, `date`, stage, country, funds_raised_millions) row_num
From layoffs2;

Delete 
From layoffs 
Where row_num > 1

Select * 
From layoffs3


-- Standardizing the Data

Select company, TRIM(company)
From layoffs3;

UPDATE layoffs3
SET company = TRIM(company);

Select * 
From layoffs3;

Select DISTINCT industry
from layoffs3
Order By 1;

Select *
from layoffs3
where industry Like '%Crypto%';

Update layoffs3
Set industry = 'Crypto'
Where industry Like '%Crypto%';

-- Removing a . from the end of the country could be done in two ways
-- 1st
Update layoffs3
Set country = 'United States'
Where country Like '%United States%';

-- 2nd
Update layoffs3
Set country = TRIM(Trailing '.' From country)
Where country = 'United States%';


-- Changing text to date format

Select *
From layoffs3;

Select `date`, str_to_date(`date`, '%m/%d/%Y')
From layoffs3;

Update layoffs3 
Set `date` = str_to_date(`date`, '%m/%d/%Y')

-- Changing data type of the column from text to date

ALTER TABLE layoffs3
MODIFY COLUMN `date` DATE;


-- Removing Null and Blank Values

Select *
From layoffs3
Where total_laid_off is NULL
AND percentage_laid_off is NULL;

Update layoffs3
Set industry = NULL
Where industry = '';

Select *
From layoffs3
Where industry is NULL 
Or industry = '';

Select *
From layoffs3
Where company Like '%Airbnb%'

Select t1.industry, t2.industry
From layoffs3 t1
Join layoffs3 t2
	On t1.company = t2.company
Where (t1.industry is NULL or t1.industry = '');
And t2.industry is not NULL;

Update layoffs3 t1
Join layoffs t2
	On t1.company = t2.company
Set t1.industry = t2.industry
Where t1.industry is NULL
AND t2.industry is not NULL;

Select *
from layoffs3
Where percentage_laid_off is NULL
AND total_laid_off is NULL;

DELETE
from layoffs3
Where percentage_laid_off is NULL
AND total_laid_off is NULL;


-- Removing Columns

Select *
from layoffs3

Alter Table layoffs3
Drop Column row_num;

Select *
from layoffs3


























