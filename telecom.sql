/****** Script for SelectTopNRows command from SSMS  ******/
SELECT 
  top(3) * 
FROM 
  [telecom].[dbo].[telecom_customer_churn];
--remove some unwanted columns
ALTER TABLE 
  telecom.dbo.telecom_customer_churn 
DROP 
  COLUMN zip_code, 
  online_backup;
--Profit Our Company
Select 
  ROUND(
    SUM(Total_Revenue), 
    1
  ) AS Profit 
from 
  telecom.dbo.telecom_customer_churn 
where 
  Total_Revenue is not null;
--most cities charge 
SELECT 
  top(10) City, 
  ROUND(
    AVG(Total_Charges), 
    1
  ) AS Avg_Charges 
FROM 
  telecom.dbo.telecom_customer_churn 
Where 
  Total_Charges is not null 
  and City is not null 
GROUP BY 
  City 
ORDER BY 
  Avg_Charges DESC;
--Male VS Female
SELECT 
  Count(*) AS Count_Gender, 
  Gender 
FROM 
  telecom.dbo.telecom_customer_churn 
WHERE 
  Gender IS NOT NULL 
GROUP BY 
  Gender;
--who chargr More
SELECT 
  Gender, 
  Round(
    Sum(
      Avg_Monthly_Long_Distance_Charges
    ), 
    1
  ) AS Avg_Monthly_Charges 
FROM 
  telecom.dbo.telecom_customer_churn 
WHERE 
  Gender IS NOT NULL 
  AND Avg_Monthly_Long_Distance_Charges IS NOT NULL 
GROUP BY 
  Gender 
ORDER BY 
  Avg_Monthly_Charges DESC;
--kind servie
select 
  count(*) Numbers, 
  Contract 
from 
  telecom.dbo.telecom_customer_churn 
where 
  Contract is not null 
group by 
  Contract;
--Why Our Customers Making Churn 
SELECT 
  Churn_Reason, 
  COUNT(*) AS Churn_Count 
FROM 
  telecom.dbo.telecom_customer_churn 
WHERE 
  Churn_Reason IS NOT NULL 
GROUP BY 
  Churn_Reason 
ORDER BY 
  Churn_Count DESC;
--Customer_Status and realted Offers
SELECT 
  Customer_Status, 
  COUNT(*) AS Count, 
  Offer 
FROM 
  telecom.dbo.telecom_customer_churn 
GROUP BY 
  Customer_Status, 
  Offer 
order by 
  Count Desc;
SELECT 
  top(3) * 
FROM 
  [telecom].[dbo].[telecom_customer_churn];
--Most Internet Type usage
SELECT 
  Internet_Type, 
  COUNT(*) AS Count 
FROM 
  telecom.dbo.telecom_customer_churn 
WHERE 
  Internet_Type IS NOT NULL 
GROUP BY 
  Internet_Type;
SELECT 
  Internet_Type, 
  COUNT(*) AS Count 
FROM 
  telecom.dbo.telecom_customer_churn 
WHERE 
  Internet_Type IS NOT NULL 
GROUP BY 
  Internet_Type;
--Most Payment_Method usage for charges
SELECT 
  Payment_Method, 
  round(
    AVG(Monthly_Charge), 
    2
  ) AS Monthly_Charge 
FROM 
  telecom.dbo.telecom_customer_churn 
WHERE 
  Payment_Method IS NOT NULL 
  AND Monthly_Charge IS NOT NULL 
GROUP BY 
  Payment_Method;
--total amount of refunds issued to a customer over a certain period of time.
SELECT 
  Round(
    SUM(total_refunds), 
    2
  ) as Total_Refunds 
FROM 
  telecom.dbo.telecom_customer_churn;
--Customer Status Total Charges
SELECT 
  top(10) Customer_Status, 
  Round(
    SUM(Total_Charges), 
    2
  ) AS Total_Charges 
FROM 
  telecom.dbo.telecom_customer_churn 
GROUP BY 
  Customer_Status 
order by 
  Total_Charges desc --number of months a customer has been subscribed to a service or product.
  
  /*In many businesses, including telecom or subscription-based services,
  customers are charged on a monthly basis for using a product or service.
  The tenure_in_months column may contain the total number of months a customer has been subscribed to the service or product,
  starting from the date they first signed up.
  This information can be used by the company to track customer loyalty and identify
  customers who may be at risk of churning.*/
SELECT 
  AVG(tenure_in_months) AS avg_tenure, 
  Customer_Status 
FROM 
  telecom.dbo.telecom_customer_churn 
WHERE 
  customer_Status in ('Churned', 'Stayed', 'Joined') 
group by 
  Customer_Status
