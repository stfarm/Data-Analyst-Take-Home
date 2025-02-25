--Checking user_takehome
--Missing Values and Blanks

-- How many rows in total?
SELECT COUNT(*) AS total_rows
FROM public.user_takehome;

-- Check for NULL or empty "BIRTH_DATE"
SELECT COUNT(*) AS missing_birth_date
FROM public.user_takehome
WHERE "BIRTH_DATE" IS NULL 
   OR "BIRTH_DATE" = '';

-- Similarly for STATE, LANGUAGE, GENDER
SELECT COUNT(*) AS missing_state
FROM public.user_takehome
WHERE "STATE" IS NULL 
   OR "STATE" = '';

SELECT COUNT(*) AS missing_language
FROM public.user_takehome
WHERE "LANGUAGE" IS NULL 
   OR "LANGUAGE" = '';

SELECT COUNT(*) AS missing_gender
FROM public.user_takehome
WHERE "GENDER" IS NULL 
   OR "GENDER" = '';

--Duplicates & Key Uniqueness

-- Check if "ID" is truly unique
SELECT "ID", COUNT(*) AS freq
FROM public.user_takehome
GROUP BY "ID"
HAVING COUNT(*) > 1
ORDER BY freq DESC;

-- Look for any obviously invalid "CREATED_DATE" formats (like blank or nonsense).
-- Postgres will error out if we do to_date() on invalid strings,
-- so we can do something like a simple check for numeric pattern:
SELECT COUNT(*) AS invalid_created_date_format
FROM public.user_takehome
WHERE "CREATED_DATE" !~ '^\d{4}-\d{2}-\d{2}';

-- Similarly for "BIRTH_DATE"
SELECT COUNT(*) AS invalid_birth_date_format
FROM public.user_takehome
WHERE "BIRTH_DATE" !~ '^\d{4}-\d{2}-\d{2}';



--Checking transaction_takehome
--Missing Values & Blanks

-- Row count
SELECT COUNT(*) AS total_rows
FROM public.transaction_takehome;

-- Check for any NULL or blank "BARCODE" 
SELECT COUNT(*) AS missing_barcode
FROM public.transaction_takehome
WHERE "BARCODE" IS NULL;

-- "FINAL_SALE" could be empty strings or actual NULL
SELECT COUNT(*) AS missing_final_sale
FROM public.transaction_takehome
WHERE "FINAL_SALE" IS NULL 
   OR "FINAL_SALE" = '';

--dups
-- Are multiple rows using the same RECEIPT_ID?
SELECT "RECEIPT_ID", COUNT(*) AS freq
FROM public.transaction_takehome
GROUP BY "RECEIPT_ID"
HAVING COUNT(*) > 1
ORDER BY freq DESC
LIMIT 10;


--Numeric or Date Parsing Checks
-- "FINAL_SALE" might be non-numeric. Let's see how many are invalid if we try a numeric regex.
SELECT COUNT(*) AS invalid_final_sale
FROM public.transaction_takehome
WHERE "FINAL_SALE" !~ '^[0-9]+(\.[0-9]+)?$' 
   OR "FINAL_SALE" IS NULL 
   OR "FINAL_SALE" = '';

-- Check if "PURCHASE_DATE" is in a valid 'YYYY-MM-DD' format
SELECT COUNT(*) AS invalid_purchase_date
FROM public.transaction_takehome
WHERE "PURCHASE_DATE" !~ '^\d{4}-\d{2}-\d{2}';



--Checking products_takehome

--Missing Values
SELECT COUNT(*) AS missing_category_1
FROM public.products_takehome
WHERE "CATEGORY_1" IS NULL
   OR "CATEGORY_1" = '';

SELECT COUNT(*) AS missing_category_2
FROM public.products_takehome
WHERE "CATEGORY_2" IS NULL
   OR "CATEGORY_2" = '';

SELECT COUNT(*) AS missing_category_3
FROM public.products_takehome
WHERE "CATEGORY_3" IS NULL
   OR "CATEGORY_3" = '';

SELECT COUNT(*) AS missing_category_4
FROM public.products_takehome
WHERE "CATEGORY_4" IS NULL
   OR "CATEGORY_4" = '';

SELECT COUNT(*) AS missing_manufacturer
FROM public.products_takehome
WHERE "MANUFACTURER" IS NULL
   OR "MANUFACTURER" = '';

SELECT COUNT(*) AS missing_brand
FROM public.products_takehome
WHERE "BRAND" IS NULL
   OR "BRAND" = '';



--Check for Duplicates (BARCODE)
SELECT 
    "BARCODE", 
    COUNT(*) AS freq
FROM public.products_takehome
GROUP BY "BARCODE"
HAVING COUNT(*) > 1
ORDER BY freq DESC
LIMIT 10;

--Invalid or Negative BARCODE Values
-- Negative or zero barcodes might be nonsensical
SELECT COUNT(*) AS invalid_barcode_values
FROM public.products_takehome
WHERE "BARCODE" <= 0
   OR "BARCODE" IS NULL;

