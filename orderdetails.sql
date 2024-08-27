WITH orderdetails AS
(
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
	DATEDIFF(shippedDate, orderDate) IS NOT NULL AND
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
)
SELECT 
	*
FROM 
	orderdetails