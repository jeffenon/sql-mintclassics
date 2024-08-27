WITH productdetails AS
( 	
	WITH productsxorderdetails AS
	(
		SELECT
			orderNumber,
			products.productCode AS productCode,
			warehouseCode,
			quantityInStock,
			quantityOrdered
		FROM 
			mintclassics.products as products
			LEFT JOIN
				mintclassics.orderdetails as orderdetails
			ON
				products.productCode = orderdetails.productCode
	)
		
	SELECT
		warehouseCode,
		quantityInStock,
		SUM(quantityOrdered) AS orders,
		AVG(DATEDIFF(shippedDate, orderDate)) AS shipDuration
	FROM
		productsxorderdetails AS products
		LEFT JOIN
			mintclassics.orders AS orders
		ON
			products.orderNumber = orders.orderNumber
	WHERE
		shippedDate IS NOT NULL OR
        status <> 'Cancelled'
        
	GROUP BY
		productCode,
		warehouseCode
)

SELECT
	warehouseName,
	SUM(quantityInStock) as inventory,
    SUM(orders) as orders,
    FLOOR(SUM(quantityInStock) / (warehousePctCap * 0.01)) AS warehouseCap,
    FLOOR(SUM(quantityInStock) / (warehousePctCap * 0.01)) - SUM(quantityInStock) AS availableCap,
        AVG(shipDuration) AS avgShipDuration
FROM 
	productdetails AS products
	LEFT JOIN
		mintclassics.warehouses as warehouses
	ON
		products.warehouseCode = warehouses.warehouseCode
GROUP BY
	warehouseName,
    warehousePctCap