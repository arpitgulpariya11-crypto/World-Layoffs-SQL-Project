#  World Layoffs - SQL Data & Exploratory Data Analysis (EDA)

## Project Overview
This project involves a comprehensive data pipeline executed in MYSQL to clean and analyze a chaotic , real world dataset of global company layoffs. the project is split into two distinct phases; standardizing a raw dump into a reliable testing format, and running advanced analytical queries to uncover global economic trends.


##  Phase 1 -  Data Cleaning & Standardizing 
In the first phase ( 01_Data_Cleaning.sql ), I built a robust staging environment to protect the raw data and resolved major quality issues using the following workflow -

1. "Duplicate Removal" - Utilized 'ROW_NUMBER()' over partition windows to locate and safely expunge identical rows.
2. " Data Standardization " - Used string manipulation function ( TRIM ) to clean whitespace typos and standardized irregular text entries (e.g. - grouping variations of 'crypto' ) .
3. " Temporal Formatting " - Converted messy text-formatted strings into true database " date " types using ' str_to_date()" to allow for proper chronological sorting.
4.  " NULL & Blank remediation - Executed self-join on matching company fields to intelligently populate missing industry records.

---

## Phase 2 - Exploratory Data Analysis (EDA)
In the second phase (" Exploratory_DATA_Analysis.sql") , I acted as a data analyst to uncover macro trends using advances SQL features like Common Table Expression (CTEs) and Window Function -
1. "Top Layoffs by volume" - Analyzed which companies and industries experienced the most massive single-day downsizings.
2. " Chronological Progressions " - Built rolling totals of the layoffs by month and year using window function to visualize how the economic downturn progressed over time .
3. "Company Rankings " Created a dynamic leaderboard ranking the top 5 companies per year for layoffs using a nested CTE pattern.

## Tech Stack Used 
* " Database Engine" - MYSQL Server
* " SQL Editor/client " - MYSQL Workbench
* " key SQL Skills " - Common Table Expressions, Window Function ( ROW_NUMBER() , DENSE_RANK() ) , Self-joins, Constraints , Data Type Conversion ('ALTER TABLE' , ('MODTFY','ADD','DROP')


