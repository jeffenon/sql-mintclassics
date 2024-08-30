WITH warehouses AS
(	
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
)
SELECT
	*
FROM 
	warehouses
WHERE
	1 = 1