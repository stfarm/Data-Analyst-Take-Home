## Query
```sql
--Checking user_takehome
--Missing Values and Blanks

-- How many rows in total?
SELECT COUNT(*) AS total_rows
FROM public.user_takehome
```

|   total_rows |
|--------------|
|       100000 |

---

## Query
```sql
-- Check for NULL or empty "BIRTH_DATE"
SELECT COUNT(*) AS missing_birth_date
FROM public.user_takehome
WHERE "BIRTH_DATE" IS NULL 
   OR "BIRTH_DATE" = ''
```

|   missing_birth_date |
|----------------------|
|                 3675 |

---

## Query
```sql
-- Similarly for STATE, LANGUAGE, GENDER
SELECT COUNT(*) AS missing_state
FROM public.user_takehome
WHERE "STATE" IS NULL 
   OR "STATE" = ''
```

|   missing_state |
|-----------------|
|            4812 |

---

## Query
```sql
SELECT COUNT(*) AS missing_language
FROM public.user_takehome
WHERE "LANGUAGE" IS NULL 
   OR "LANGUAGE" = ''
```

|   missing_language |
|--------------------|
|              30508 |

---

## Query
```sql
SELECT COUNT(*) AS missing_gender
FROM public.user_takehome
WHERE "GENDER" IS NULL 
   OR "GENDER" = ''
```

|   missing_gender |
|------------------|
|             5892 |

---

## Query
```sql
--Duplicates & Key Uniqueness

-- Check if "ID" is truly unique
SELECT "ID", COUNT(*) AS freq
FROM public.user_takehome
GROUP BY "ID"
HAVING COUNT(*) > 1
ORDER BY freq DESC
```

| ID   | freq   |
|------|--------|

---

## Query
```sql
-- Look for any obviously invalid "CREATED_DATE" formats (like blank or nonsense).
-- Postgres will error out if we do to_date() on invalid strings,
-- so we can do something like a simple check for numeric pattern:
SELECT COUNT(*) AS invalid_created_date_format
FROM public.user_takehome
WHERE "CREATED_DATE" !~ '^\d{4}-\d{2}-\d{2}'
```

|   invalid_created_date_format |
|-------------------------------|
|                             0 |

---

## Query
```sql
-- Similarly for "BIRTH_DATE"
SELECT COUNT(*) AS invalid_birth_date_format
FROM public.user_takehome
WHERE "BIRTH_DATE" !~ '^\d{4}-\d{2}-\d{2}'
```

|   invalid_birth_date_format |
|-----------------------------|
|                        3675 |

---

## Query
```sql
--Checking transaction_takehome
--Missing Values & Blanks

-- Row count
SELECT COUNT(*) AS total_rows
FROM public.transaction_takehome
```

|   total_rows |
|--------------|
|        50000 |

---

## Query
```sql
-- Check for any NULL or blank "BARCODE" 
SELECT COUNT(*) AS missing_barcode
FROM public.transaction_takehome
WHERE "BARCODE" IS NULL
```

|   missing_barcode |
|-------------------|
|              5762 |

---

## Query
```sql
-- "FINAL_SALE" could be empty strings or actual NULL
SELECT COUNT(*) AS missing_final_sale
FROM public.transaction_takehome
WHERE "FINAL_SALE" IS NULL 
   OR "FINAL_SALE" = ''
```

|   missing_final_sale |
|----------------------|
|                    0 |

---

## Query
```sql
--dups
-- Are multiple rows using the same RECEIPT_ID?
SELECT "RECEIPT_ID", COUNT(*) AS freq
FROM public.transaction_takehome
GROUP BY "RECEIPT_ID"
HAVING COUNT(*) > 1
ORDER BY freq DESC
LIMIT 10
```

| RECEIPT_ID                           |   freq |
|--------------------------------------|--------|
| bedac253-2256-461b-96af-267748e6cecf |     12 |
| 61dc6179-7ae7-4acd-b043-8ba796bc5949 |      8 |
| bc304cd7-8353-4142-ac7f-f3ccec720cb3 |      8 |
| 2acd7e8d-37df-4e51-8ee5-9a9c8c1d9711 |      8 |
| 4ec870d2-c39f-4a40-bf8a-26a079409b20 |      8 |
| 760c98da-5174-401f-a203-b839c4d406be |      8 |
| 43955b35-6fbc-4909-a4de-1a0de0dc387f |      6 |
| 85cfc641-99ed-4212-b309-82dff6f7f64f |      6 |
| d505350b-ba5a-4781-99cf-46a26f5550e6 |      6 |
| 94c7ebd0-a46c-41f1-89a3-92b2bad017a1 |      6 |

---

## Query
```sql
--Numeric or Date Parsing Checks
-- "FINAL_SALE" might be non-numeric. Let's see how many are invalid if we try a numeric regex.
SELECT COUNT(*) AS invalid_final_sale
FROM public.transaction_takehome
WHERE "FINAL_SALE" !~ '^[0-9]+(\.[0-9]+)?$' 
   OR "FINAL_SALE" IS NULL 
   OR "FINAL_SALE" = ''
```

|   invalid_final_sale |
|----------------------|
|                12500 |

---

## Query
```sql
-- Check if "PURCHASE_DATE" is in a valid 'YYYY-MM-DD' format
SELECT COUNT(*) AS invalid_purchase_date
FROM public.transaction_takehome
WHERE "PURCHASE_DATE" !~ '^\d{4}-\d{2}-\d{2}'
```

|   invalid_purchase_date |
|-------------------------|
|                       0 |

---

## Query
```sql
--Checking products_takehome

--Missing Values
SELECT COUNT(*) AS missing_category_1
FROM public.products_takehome
WHERE "CATEGORY_1" IS NULL
   OR "CATEGORY_1" = ''
```

|   missing_category_1 |
|----------------------|
|                  111 |

---

## Query
```sql
SELECT COUNT(*) AS missing_category_2
FROM public.products_takehome
WHERE "CATEGORY_2" IS NULL
   OR "CATEGORY_2" = ''
```

|   missing_category_2 |
|----------------------|
|                 1424 |

---

## Query
```sql
SELECT COUNT(*) AS missing_category_3
FROM public.products_takehome
WHERE "CATEGORY_3" IS NULL
   OR "CATEGORY_3" = ''
```

|   missing_category_3 |
|----------------------|
|                60566 |

---

## Query
```sql
SELECT COUNT(*) AS missing_category_4
FROM public.products_takehome
WHERE "CATEGORY_4" IS NULL
   OR "CATEGORY_4" = ''
```

|   missing_category_4 |
|----------------------|
|               778093 |

---

## Query
```sql
SELECT COUNT(*) AS missing_manufacturer
FROM public.products_takehome
WHERE "MANUFACTURER" IS NULL
   OR "MANUFACTURER" = ''
```

|   missing_manufacturer |
|------------------------|
|                 226474 |

---

## Query
```sql
SELECT COUNT(*) AS missing_brand
FROM public.products_takehome
WHERE "BRAND" IS NULL
   OR "BRAND" = ''
```

|   missing_brand |
|-----------------|
|          226472 |

---

## Query
```sql
--Check for Duplicates (BARCODE)
SELECT 
    "BARCODE", 
    COUNT(*) AS freq
FROM public.products_takehome
GROUP BY "BARCODE"
HAVING COUNT(*) > 1
ORDER BY freq DESC
LIMIT 10
```

|   BARCODE |   freq |
|-----------|--------|
|           |   4025 |
|   3448007 |      2 |
|   3409800 |      2 |
|   3449608 |      2 |
|   3481103 |      2 |
|  59939498 |      2 |
|  80199137 |      2 |
|   3472705 |      2 |
|   3484500 |      2 |
|   2818900 |      2 |

---

## Query
```sql
--Invalid or Negative BARCODE Values
-- Negative or zero barcodes might be nonsensical
SELECT COUNT(*) AS invalid_barcode_values
FROM public.products_takehome
WHERE "BARCODE" <= 0
   OR "BARCODE" IS NULL
```

|   invalid_barcode_values |
|--------------------------|
|                     4025 |

---

