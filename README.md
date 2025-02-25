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
