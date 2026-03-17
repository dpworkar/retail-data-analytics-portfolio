-- =====================================================
-- Import data into sales table
-- Dataset: Superstore
-- =====================================================

-- NOTE:
-- If COPY command does not work due to permission issues,
-- import the dataset using pgAdmin Import Tool.

COPY sales
FROM 'data/clean_superstore.csv'
DELIMITER ';'
CSV HEADER;