## Mint Classics Warehouse Analysis

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

### Warehouse Capacity </br>
![Warehouse Capacities Final](https://github.com/user-attachments/assets/b9c8fd8b-1c1d-4aab-b262-16d0800a3f67) </br>
* **Products Distribution** </br>
  The products of the same product line are stored in the same warehouse. </br>
  ![image](https://github.com/user-attachments/assets/de626a05-09d1-461f-8268-aec3fd9f9a09) </br>
* **Warehouse Capacities** </br>
  The South warehouse has the lowest inventory count, maximum capacity, and available capacity. The current inventory of the South warehouse
  could fit in either East or West. Alternatively, the inventory from the South warehouse could also be redistributed, one product line per
  warehouse, at any order. </br>
  ![image](https://github.com/user-attachments/assets/358224ee-dcbd-4cd7-b227-bc98bef747c9) </br>

### Inventory to Sales Ratio </br>
![IS Ratio per Product Line Final](https://github.com/user-attachments/assets/f59177d9-c47a-44a1-a3b7-2c7fcace6074) </br>
* **Overall Inventory-to-Sales Ratio** </br>
  The company's Inventory-to-Sales ratio is 3.62, which is too high. Ideally, this is to be kept around 0.167 to 0.25, however, not one product
  fits this criterion with the lowest I/S ratio being around 0.29.</br>
  ![image](https://github.com/user-attachments/assets/a7aa497b-169b-48fc-9c9a-dc97c826bd9d) </br>
* **Product Line Inventory-to-Sales Ratio** </br>
  ![image](https://github.com/user-attachments/assets/008d1d31-ccb8-44e5-b1c4-8f984a315a69) </br>
* **No-Sale Products** </br>
  ![image](https://github.com/user-attachments/assets/745be901-7025-4133-a090-e313ae86c092) </br>
  The 1985 Toyota Supra has not made any sales at all.
  
### Shipping Time </br>
![Ship Duration Boxplot Final](https://github.com/user-attachments/assets/c6a6f09e-19a4-4c9d-9271-045266aa4d0f) </br>
* **Overall Shipping Time** </br>
  The shipping time data ranges from 1 to 65 days. The shipping time of 65 days was caused by the customer's credit card being
  declined, thus, delaying the shipping after the payment was settled. </br>
  ![image](https://github.com/user-attachments/assets/157baea5-a1b1-4bfa-8cf0-5f483c7d666a) </br>
* **Shipping Time Distribution** </br>
  The majority of the orders were shipped within 6 days. This is true for all of the warehouses. </br>
  ![image](https://github.com/user-attachments/assets/bc5baf15-a519-4480-b741-e7e7dd39be22) </br>
  

## Recommendations
* The South warehouse can be considered as the one to be closed for the following reasons:
  * It has the lowest maximum capacity out of all the warehouses. This minimizes the reduction in overall warehouse capacity by just around **12.23%**. </br>
  ![image](https://github.com/user-attachments/assets/f66d123e-1e3b-4eb9-b197-362e77555f8b) </br>
  * It has the lowest current inventory which the other warehouse could easily cater to. This minimizes the complexity of transferring and organizing its products to the other warehouses. </br>
  ![image](https://github.com/user-attachments/assets/4eda9d7d-e336-4ad8-a932-b4ccd3ab5767) </br>
  By considering the product line stocks and available capacities, I recommend the following:
    * Move Trains to the North warehouse
    * Move Ships to the East warehouse
    * Move Trucks and Buses to the West warehouse </br>
* Consider testing what interval of Inventory-to-Sales ratio is best for the company and adjust the inventory accordingly. For reference, if the Inventory-to-Sales ratio is maintained within the ideal interval of 0.167 to 0.25, the stock value would only be around **$1.51M to $2.26M**. The company would save around **$30.99M to $33.25M**. </br>
  ![image](https://github.com/user-attachments/assets/d908432c-f299-47d9-981b-8eb10cf4fc14) </br>
* Consider dropping the 1985 Toyota Supra from the product line. This product has not made any sales and there are 7733 in stock. This could save the company around 
  **$440K** of stock value.
