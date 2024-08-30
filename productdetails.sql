WITH productdetails AS
(
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
		IFNULL(((((quantityInStock + SUM(quantityOrdered)) + quantityInStock) / 2) * buyPrice) /  NULLIF(SUM(amount), 0), 'NA') AS ISRatio,
        IFNULL((SUM(profit) / NULLIF(SUM(amount), 0)), 'NA') AS profitRatio
	FROM 
		productxorders
	GROUP BY
		productCode,
        productName,
		productLine,
		warehouseName,
        quantityInStock
)
SELECT
	*
FROM
	productdetails
WHERE
	1 = 1
;
