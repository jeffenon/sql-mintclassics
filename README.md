# Mint Classics Warehouse Analysis

## Scenario
Mint Classics, a retailer of classic cars and vintage cars, motorcycles, planes, trucks, buses, ships, and trains, is interested in
closing one of its warehouses. They are looking for suggestions and recommendations on how to do this without affecting the 
quality of their service to their customers.

## Business Questions
1. Where are items stored and if they were rearranged, could a warehouse be eliminated?
2. How are inventory numbers related to sales figures? Do the inventory counts seem appropriate for each item?
3. Are we storing items that are not moving? Are any items candidates for being dropped from the product line?

## Key Metrics
* **Warehouse Capacity** </br>
  The number of inventory a warehouse is capable of storing. This was calculated by dividing the current inventory by the
  warehouse capacity percentage.
  * **Inventory** </br> The quantity of products in stock
  * **Warehouse Capacity Percentage** </br> The portion of the warehouse capacity that is occupied
* **Inventory to Sales Ratio** </br>
  The Average Stock Value ratio against the products' Net Sales.
  * **Average Stock Value** </br>
    The amount of money spent on the stocked products. This is calculated by dividing the sum of the initial and current inventory
    count by two.
  * **Net Sales** </br>
    The total amount of sales of the products.
* **Shipping Time** </br>
  The time it took for the order to be shipped from the warehouse after the customer placed it.

## Summary of Insights

### Warehouse Capacity
* The South warehouse has the lowest inventory count, order count, warehouse capacity, and available capacity.
### Inventory to Sales Ratio
* The average Inventory-to-Sales ratio is 3.59, which is too high. Ideally, this is to be kept around 0.167 to 0.25, however, not one product
  fits this criterion with the lowest I/S ratio being around 0.29.
* The 1985 Toyota Supra has not made any sales at all.
### Shipping Time
* The shipping time ranges from 1 to 8 days.
* There is an order that took 65 days to be shipped because the customer's credit card was declined.
* The average shipping time is 4 days for all the warehouses.

## Recommendations
* The South warehouse can be considered as the one to be closed for the following reasons:
  * Closing the South warehouse would cause the least reduction in overall inventory capacity since it has the lowest warehouse capacity
    out of the four warehouses used by the company.
  * The number of products to be redistributed across the other warehouses will be lesser since the South warehouse has the lowest current
    inventory
* Consider investigating what interval of Inventory-to-Sales ratio is the best for the company and maintain the inventory accordingly. This would
  decrease the overall warehouse capacity of all the warehouses because of the removal of excess stocks.
* Consider dropping the 1985 Toyota Supra from the product line. This product has not made any sales and there are 7733 in stock.
  This could potentially save the company around $440858.33 of stock value.
