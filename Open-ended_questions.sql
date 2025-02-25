--Who Are Fetch’s Power Users?

/*
 user_receipt_counts: Summarizes how many distinct receipts each user has scanned.
threshold: Calculates the 95th percentile (top 5%).
The final SELECT returns only the users above or equal to that threshold—our “power users.”
 */

WITH user_receipt_counts AS (
    SELECT
        t."USER_ID",
        COUNT(DISTINCT t."RECEIPT_ID") AS total_receipts
    FROM public.transaction_takehome t
    GROUP BY t."USER_ID"
),
threshold AS (
    /* Use the percentile_cont window function to get the 95th percentile. */
    SELECT
        PERCENTILE_CONT(0.95) 
        WITHIN GROUP (ORDER BY user_receipt_counts.total_receipts) 
        AS threshold_95
    FROM user_receipt_counts
)
SELECT 
    urc."USER_ID",
    urc.total_receipts AS scanned_receipts
FROM user_receipt_counts urc
JOIN threshold th ON urc.total_receipts >= th.threshold_95
ORDER BY scanned_receipts DESC;

--Which Is the Leading Brand in the Dips & Salsa Category?
/*
 Filter products_takehome on "CATEGORY_2" = 'Dips & Salsa'.
Join to transaction_takehome to get actual sales from "FINAL_SALE".
Sum sales per brand, then pick the top brand.
 */

SELECT 
    p."BRAND",
    SUM(CAST(t."FINAL_SALE" AS numeric)) AS total_sales
FROM public.transaction_takehome t
JOIN public.products_takehome p
    ON t."BARCODE" = p."BARCODE"
WHERE 
    p."CATEGORY_2" = 'Dips & Salsa'
    -- Also optionally ensure FINAL_SALE is numeric:
    AND t."FINAL_SALE" ~ '^[0-9]+(\.[0-9]+)?$'
GROUP BY p."BRAND"
ORDER BY total_sales DESC
LIMIT 1;  -- The single top brand is TOSTITOS





--At What Percent Has Fetch Grown Year Over Year?
/*
 Parse CREATED_DATE from user_takehome to get each user’s signup year.
Count distinct users per year.
Compare each year’s user count to the previous year to get a year-over-year (YoY) percentage.
 */

WITH yearly_signup AS (
    SELECT 
        EXTRACT(YEAR FROM to_date(u."CREATED_DATE", 'YYYY-MM-DD'))::int AS signup_year,
        COUNT(DISTINCT u."ID") AS users_created
    FROM public.user_takehome u
    GROUP BY EXTRACT(YEAR FROM to_date(u."CREATED_DATE", 'YYYY-MM-DD'))
),
yearly_with_growth AS (
    SELECT
        signup_year,
        users_created,
        LAG(users_created) OVER (ORDER BY signup_year) AS prev_year_users
    FROM yearly_signup
)
SELECT
    signup_year,
    users_created,
    CASE 
       WHEN prev_year_users IS NULL OR prev_year_users = 0 THEN NULL
       ELSE ROUND(
           ((users_created - prev_year_users)::numeric / prev_year_users) * 100, 
           2
       )
    END AS yoy_growth_percent
FROM yearly_with_growth
ORDER BY signup_year;

