-- Products Table
CREATE TEMPORARY TABLE producttable
WITH productxorders AS
(
	SELECT
		products.productCode AS productCode,
		productName,
		productLine,
		REPLACE(REPLACE(REPLACE(REPLACE(warehouseCode, 'a', 'North'), 'c', 'West'), 'd', 'South'), 'b', 'East') AS warehouseName,
		quantityInStock,
		IFNULL(quantityOrdered, 0) AS quantityOrdered,
		priceEach,
		buyPrice,
		IFNULL((priceEach * quantityOrdered) - (buyPrice * quantityOrdered), 0) AS profit,
		IFNULL(quantityOrdered * priceEach, 0) AS amount
	FROM 
		mintclassics.products as products
		LEFT JOIN
			(
			SELECT
				orderdetails.orderNumber as orderNumber,
				productCode,
				quantityOrdered,
				priceEach
			FROM
				mintclassics.orderdetails as orderdetails
				LEFT JOIN
					mintclassics.orders as orders
				ON
					orderdetails.orderNumber = orders.orderNumber
			WHERE
				shippedDate IS NOT NULL AND
				status <> 'Cancelled'
			) as orderdetails
		ON
			products.productCode = orderdetails.productCode
)
SELECT
	productCode,
	productName,
	productLine,
	warehouseName,
	quantityInStock,
	SUM(quantityOrdered) AS orders,
	SUM(amount) AS sales,
	SUM(profit) AS profit,
	((((quantityInStock + SUM(quantityOrdered)) + quantityInStock) / 2) * buyPrice) AS stockValue,
	IFNULL(((((quantityInStock + SUM(quantityOrdered)) + quantityInStock) / 2) * buyPrice) / NULLIF(SUM(amount), 0), 'NA') AS ISratio
FROM 
	productxorders
GROUP BY
	productCode,
	productName,
	productLine,
	warehouseName,
	quantityInStock
;

-- Warehouse Table
CREATE TEMPORARY TABLE warehousetable
WITH inventory AS
(
	SELECT
		REPLACE(REPLACE(REPLACE(REPLACE(warehouseCode, 'a', 'North'), 'c', 'West'), 'd', 'South'), 'b', 'East') AS warehouseName,
		SUM(quantityInStock) AS inventory,
		SUM(quantityOrdered) AS orders
	FROM 
		mintclassics.products as products
		LEFT JOIN
			(
			SELECT
				productCode,
				SUM(quantityOrdered) AS quantityOrdered,
				AVG(DATEDIFF(shippedDate, orderdate)) AS shipDurationAvg
			FROM
				mintclassics.orderdetails as od
				LEFT JOIN
					mintclassics.orders as o
				ON
					od.orderNumber = o.orderNumber
			WHERE
				shippedDate IS NOT NULL AND
				status <> 'Cancelled'
			GROUP BY
				productCode
			) as orders
		ON
			products.productCode = orders.productCode
	GROUP BY
		warehouseCode
)
SELECT
	inventory.warehouseName,
	inventory,
	orders,
	FLOOR(inventory / (warehousePctCap / 100)) AS  warehouseCap,
	FLOOR(inventory / (warehousePctCap / 100)) - inventory AS availableCap
FROM
	inventory
	LEFT JOIN
		mintclassics.warehouses AS warehouse
	ON
		inventory.warehouseName = warehouse.warehouseName
;

-- Orders Table 
CREATE TEMPORARY TABLE ordertable
WITH orderdetailsxorder AS
(
	SELECT
		od.orderNumber AS orderNumber,
		productCode,
		quantityOrdered,
		priceEach,
		DATEDIFF(shippedDate, orderDate) AS shipDuration,
		status,
		comments,
		customerNumber,
		orderDate
	FROM
		mintclassics.orderdetails AS od
		LEFT JOIN
			mintclassics.orders AS o
		ON
			od.orderNumber = o.orderNumber
	WHERE
		shippedDate IS NOT NULL AND
		status <> 'Cancelled'
)
SELECT
	orderNumber,
	odxd.productCode AS productCode,
	quantityOrdered,
	priceEach * quantityOrdered AS amount,
	buyPrice * quantityOrdered AS cost,
	(priceEach * quantityOrdered) - (buyPrice * quantityOrdered) AS profit,
	buyPrice,
	MSRP,
	shipDuration,
	customerNumber,
	REPLACE(REPLACE(REPLACE(REPLACE(warehouseCode, 'a', 'North'), 'c', 'West'), 'd', 'South'), 'b', 'East') AS warehouseName,
	orderDate
FROM
	orderdetailsxorder AS odxd
	LEFT JOIN
		mintclassics.products AS p
	ON
		odxd.productCode = p.productCode
;