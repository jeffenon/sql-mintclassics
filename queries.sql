-- Warehouse Table
SELECT
	*
FROM
	warehousetable
;

-- Products Table
SELECT
	*
FROM
	producttable
;

-- Orders Table
SELECT
	*
FROM
	ordertable
;

-- Warehouse Capacities
SELECT
	warehouseName,
	inventory,
    warehouseCap,
    availableCap
FROM
	warehousetable
;

-- Products Distribution
SELECT
	productLine,
    warehouseName,
    SUM(quantityInStock) AS stocks
FROM
	producttable
GROUP BY
	warehouseName,
    productLine
;

-- Overall Inventory-to-Sales Ratio
SELECT
    SUM(stockValue)/SUM(sales) AS OverallISRatio,
    MIN(ISRatio) AS minISRatio,
    MAX(ISRatio) As maxISRatio
FROM
	producttable
WHERE
	sales <> 0
;

-- Product Line Inventory-to-Sales Ratio
SELECT
	productLine,
    SUM(stockValue) / SUM(sales) AS ISRatio
FROM
	producttable
WHERE
	sales <> 0
GROUP BY
	productLine
;

-- Products with no sales
SELECT
	productName,
    stockValue
FROM
	producttable
WHERE
	sales = 0
;

-- Shipping Time Distribution
SELECT
	shipDuration,
    COUNT(shipDuration) AS count
FROM
	ordertable
GROUP BY
	shipDuration
ORDER BY
	count DESC
;

-- Shipping Time Distribution
SELECT
	warehouseName,
	shipDuration,
    COUNT(shipDuration) AS count
FROM
	ordertable
GROUP BY
	warehouseName,
	shipDuration
ORDER BY
	warehouseName,
	count DESC