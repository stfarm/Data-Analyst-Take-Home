# Data-Analyst-Take-Home
assesment
https://fetch-hiring.s3.amazonaws.com/data-analyst/da_take_home/da_takehome_instructions.html

Hello,

I hope you’re doing well! I’ve recently completed an in-depth review of our data tables—users, transactions, and products—and wanted to share a quick summary of my findings, an interesting insight, and how we can resolve some questions about the data.
1. Key Data Quality Issues

    Missing User Info:
        3,675 users lack a valid birth date, 4,812 have no recorded state, 30,508 have missing language, and 5,892 are missing gender.
        This means we can’t accurately segment or personalize for a notable percentage of the user base.
    Transactions with Unclear Sales Values:
        12,500 transaction rows have non-numeric or blank “FINAL_SALE,” complicating revenue/sales calculations.
    High Duplicate or Shared IDs:
        Some RECEIPT_IDs repeat multiple times (e.g., up to 12 duplicates). We need clarity on whether that’s valid (e.g., partial item scans) or an actual data glitch.
    Products with Missing Category Details:
        Over 226,000 products have missing brand or manufacturer info, and more than 605,000 are missing mid-level categories (CATEGORY_3). This leaves large gaps in product hierarchies and complicates category analyses.

These issues can lead to inaccurate reporting or segmentation. We’d appreciate any insight on whether these missing values/duplicates are expected or if they reflect real data-entry problems.
2. One Interesting Trend in the Data

From the percentage of sales analysis by Health & Wellness category across user “generations,” we observed:

    Gen X had about 40% of their sales in Health & Wellness—more than any other group.
    Boomer+ follows with 36%, and Millennials at 31%.

This suggests older cohorts are driving a disproportionate share of Health & Wellness purchases. If we want to expand in that category, we may consider marketing and product strategies targeting Gen X consumers first.
3. Request for Action

To finalize our analysis and fix potential data flaws, we need:

    Clarification on Non-Numeric FINAL_SALE: Are strings like "zero" or blanks intentional, or should they be parsed as numeric (0.00)?
    Guidance on Duplicate RECEIPT_IDs: Is a single receipt legitimately scanned multiple times, or might these be accidental duplicates?
    Approach for Missing User Fields: Should we attempt to backfill from other systems (e.g., birth dates, states) or remove incomplete rows from certain analyses?

Any additional info or documentation on how these fields are captured and updated would help us address these questions. With your input, we can refine our reporting and ensure more accurate insights moving forward.

Thanks so much, and please let me know if you have any questions or comments.

Best regards,
Steve

Repository Overview

    data_quality_issues.sql / data_quality_issues.md
        Purpose: Addresses Part 1 of the exercise (data exploration). Contains queries that check for missing values, duplicates, and invalid fields across all three tables.
        .sql file: SQL statements to diagnose data quality.
        .md file: Output/results of running those queries.

    Closed-ended_questions.sql / Closed-ended_questions.md
        Purpose: Addresses Part 2 (closed-ended questions). Includes single-query solutions for:
            Top 5 brands by receipts scanned (users ≥ 21)
            Top 5 brands by sales (accounts ≥ 6 months)
            Percentage of sales in Health & Wellness by generation
        .sql file: The queries themselves.
        .md file: Captured results of those queries.

    Open-ended_questions.sql / open_ended_results.md
        Purpose: Addresses Part 2 (open-ended questions). Demonstrates assumptions and single-query approaches for:
            Power users (top 5% by receipts)
            Leading brand in “Dips & Salsa” (or alternate category)
            Year-over-year growth calculation
        .sql file: The open-ended queries.
        .md file: The query outputs in Markdown format.

    createMDs.py
        Purpose: A Python script that executes the above .sql files, captures the results, and writes them into .md files. Useful for automating the run-and-export process.
