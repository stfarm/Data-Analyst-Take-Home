# Data-Analyst-Take-Home
assesment
https://fetch-hiring.s3.amazonaws.com/data-analyst/da_take_home/da_takehome_instructions.html

I recently conducted an in-depth review of our user, transaction, and product tables. Below is a quick summary of my findings, an interesting insight, and outstanding questions that would help refine our analyses.
1. Key Data Quality Issues

    Missing User Info
        ~3,675 users have no valid birth date, 4,812 have no recorded state, 30,508 have missing language, and 5,892 are missing gender.
        This impairs accurate segmentation, personalization, and demographic insights.

    Transactions with Unclear Sales Values
        ~12,500 rows have non-numeric or blank FINAL_SALE. This can skew revenue reporting and hamper sales-based analyses.

    High Duplicate or Shared IDs
        Some RECEIPT_IDs appear multiple times (up to 12 duplicates). We need clarity on whether these are genuine partial scans or data-entry anomalies.

    Products with Missing Category Details
        226k products lack brand or manufacturer data, and 605k lack mid-level categories (CATEGORY_3). This hinders category-level insights and product-level analytics.

2. One Interesting Trend

Health & Wellness Sales by Generation

    Gen X stands out with ~40% of their purchases in Health & Wellness, leading all other generations.
    Boomer+ follows at 36%, Millennials at 31%.
    This suggests older cohorts (particularly Gen X) are over-indexing on Health & Wellness products, hinting at potential opportunities in targeted marketing or brand partnerships for that category.

3. Request for Action

To finalize and enhance the analysis, we need:

    Clarification on FINAL_SALE
        Are string values like “zero” or empty fields intentional, or should we standardize them to 0.00?

    Duplicate RECEIPT_IDs
        Confirm if multiple scans per receipt are valid or if they’re data-entry mistakes that need cleanup.

    Missing User Fields
        Should we backfill birth dates/states/languages from another system or exclude incomplete entries from certain calculations?

Any additional context on how these fields are captured (and whether missing/duplicate data is expected) will help us refine our approach and deliver more accurate, actionable insights.

Thank you for your time and support!
Best regards,

Steve
----------------------------------------

Repository Overview

Below is a quick guide to the files in this repository and how they map to each part of the assessment:


    data_quality_issues.sql / data_quality_issues.md
        Purpose: Addresses Part 1 (data exploration).
        Contents: SQL queries that identify missing values, duplicates, 
        and invalid fields across the three tables. 
        The .md file contains the query results.

    Closed-ended_questions.sql / Closed-ended_questions.md
        Purpose: Addresses Part 2 (closed-ended questions).
        Contents: Single-query solutions for:
            Top 5 brands by receipts scanned (users 21+)
            Top 5 brands by sales (accounts ≥ 6 months)
            Percentage of sales in Health & Wellness by generation
        The .md file shows the results.

    Open-ended_questions.sql / open_ended_results.md
        Purpose: Also Part 2 (open-ended questions).
        Contents: Single-query examples for:
            Identifying “power users” (top 5% by receipts)
            Leading brand in a “Dips & Salsa” category (or an alternate)
            Year-over-year growth calculation (based on user signups or receipts)
        The .md file shows the query outputs.

    createMDs.py
        Purpose: Automates the execution of the SQL files and writes the resulting output into Markdown. 
        Useful if you want to re-run all queries in one go.
