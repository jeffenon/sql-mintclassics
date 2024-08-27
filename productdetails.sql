WITH productdetails AS
(
WITH productxorders AS
(
SELECT
	DISTINCT p.productCode AS productCode,
    productLine,
	REPLACE(REPLACE(REPLACE(REPLACE(warehouseCode, 'a', 'North'), 'c', 'West'), 'd', 'South'), 'b', 'East') AS warehouseName,
	quantityInStock,
    quantityOrdered / quantityInStock  AS orderpct,
	SUM(quantityOrdered) AS quantityOrdered,
    priceEach,
    buyPrice,
    quantityOrdered * priceEach AS amount
FROM 
	mintclassics.products as p
	LEFT JOIN
		(
		SELECT
			o.orderNumber as orderNumber,
            productCode,
            quantityOrdered,
            priceEach
        FROM
			mintclassics.orderdetails as od
			LEFT JOIN
				mintclassics.orders as o
			ON
				od.orderNumber = o.orderNumber
		WHERE
			shippedDate IS NOT NULL OR
            status <> 'Cancelled'
 		) as od
	ON
		p.productCode = od.productCode
GROUP BY
	productCode,
	warehouseName,
    productLine,
    quantityInStock,
    buyPrice,
    orderpct,
    priceEach,
    amount
)
SELECT
	productCode,
    productLine,
    warehouseName,
    quantityInStock,
    SUM(quantityOrdered) AS orders,
    SUM(amount) AS sales,
    ((quantityInStock + SUM(quantityOrdered)) * buyPrice) AS stockValue,
    ((quantityInStock + SUM(quantityOrdered)) * buyPrice) / SUM(amount) AS ISratio
FROM 
	productxorders
GROUP BY
	productCode,
    productLine,
    warehouseName
)
SELECT
	*
FROM
	productdetails
WHERE
	1 = 1
GROUP BY
	1
ORDER BY
	ISratio ASC
;
