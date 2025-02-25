## Query
```sql
/*
  - We join transaction_takehome -> user_takehome on USER_ID = ID,
    to access each user's BIRTH_DATE.
  - We join transaction_takehome -> products_takehome on BARCODE,
    to get the BRAND.
  - We calculate age by comparing today's date to BIRTH_DATE 
    (assuming it's in 'YYYY-MM-DD' format).
  - Then we COUNT distinct receipts per brand, filtering only users >= 21.
  - Finally, we return the top 5 brands.
  
  Top 5 Brands by Receipts Scanned Among Users 21 and Over
*/

SELECT 
    p."BRAND",
    COUNT(DISTINCT t."RECEIPT_ID") AS receipts_scanned
FROM public.transaction_takehome AS t
JOIN public.user_takehome AS u
    ON t."USER_ID" = u."ID"
JOIN public.products_takehome AS p
    ON t."BARCODE" = p."BARCODE"
WHERE date_part('year', age(to_date(u."BIRTH_DATE", 'YYYY-MM-DD'))) >= 21
GROUP BY p."BRAND"
ORDER BY receipts_scanned DESC
LIMIT 5
```

| BRAND       |   receipts_scanned |
|-------------|--------------------|
| NERDS CANDY |                  3 |
| DOVE        |                  3 |
|             |                  3 |
| GREAT VALUE |                  2 |
| COCA-COLA   |                  2 |

---

## Query
```sql
/*
  - "CREATED_DATE" is the date the user's account was created.
  - "PURCHASE_DATE" is the date of the transaction.
  - We parse both as dates and check if (purchase_date - created_date) >= ~180 days 
    (roughly 6 months).
  - We CAST "FINAL_SALE" to numeric so we can SUM it.
  - Group by BRAND to get total sales, pick the top 5.
  
  Top 5 Brands by Sales Among Users That Have Had Their Account for At Least Six Months
  
*/

SELECT
    p."BRAND",
    SUM(CAST(t."FINAL_SALE" AS numeric)) AS total_sales
FROM public.transaction_takehome AS t
JOIN public.user_takehome AS u
    ON t."USER_ID" = u."ID"
JOIN public.products_takehome AS p
    ON t."BARCODE" = p."BARCODE"
WHERE
    -- Only keep rows where FINAL_SALE is numeric (including decimals).
    t."FINAL_SALE" ~ '^[0-9]+(\.[0-9]+)?$'
    AND ( to_date(t."PURCHASE_DATE", 'YYYY-MM-DD') 
        - to_date(u."CREATED_DATE", 'YYYY-MM-DD') ) >= 180
GROUP BY p."BRAND"
ORDER BY total_sales DESC
LIMIT 5
```

| BRAND       |   total_sales |
|-------------|---------------|
| CVS         |         72    |
| TRIDENT     |         46.72 |
| DOVE        |         42.88 |
| COORS LIGHT |         34.96 |
| AXE         |         15.98 |

---

## Query
```sql
/*
  - We define generation categories using a CASE expression 
    that calculates the user's approximate age 
    (again using date_part/age on BIRTH_DATE).
  - We sum FINAL_SALE for "Health & Wellness" rows 
    vs. total FINAL_SALE for all rows, per generation.
  - Multiply by 100 to get a percentage, and round to 2 decimals.
  
  Percentage of Sales in the Health & Wellness Category by Generation
  
*/

SELECT
    CASE
       WHEN date_part('year', age(to_date(u."BIRTH_DATE", 'YYYY-MM-DD'))) < 25 THEN 'Gen Z'
       WHEN date_part('year', age(to_date(u."BIRTH_DATE", 'YYYY-MM-DD'))) BETWEEN 25 AND 40 THEN 'Millennial'
       WHEN date_part('year', age(to_date(u."BIRTH_DATE", 'YYYY-MM-DD'))) BETWEEN 41 AND 56 THEN 'Gen X'
       ELSE 'Boomer+'
    END AS generation,
    /* Calculate percentage of "Health & Wellness" sales */
    ROUND(
       100.0
       * SUM(
           CASE WHEN p."CATEGORY_1" = 'Health & Wellness'
                THEN CAST(t."FINAL_SALE" AS numeric)
                ELSE 0 
           END
         )
       / SUM(CAST(t."FINAL_SALE" AS numeric)),
    2) AS health_wellness_pct
FROM public.transaction_takehome AS t
JOIN public.user_takehome AS u
    ON t."USER_ID" = u."ID"
JOIN public.products_takehome AS p
    ON t."BARCODE" = p."BARCODE"
WHERE
    -- Filter only rows where FINAL_SALE is fully numeric
    t."FINAL_SALE" ~ '^[0-9]+(\.[0-9]+)?$'
GROUP BY 1
ORDER BY health_wellness_pct DESC
```

| generation   |   health_wellness_pct |
|--------------|-----------------------|
| Gen X        |                 39.72 |
| Boomer+      |                 35.81 |
| Millennial   |                 31.35 |

---

