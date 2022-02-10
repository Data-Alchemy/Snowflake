CREATE VIEW vHercules_allflows
AS

SELECT
af.DeviceCategory as DeviceCategory,
af.Country AS Country,
af.Region AS Region,
CONVERT(date, af.Date) AS 'Date',
CASE
WHEN af.Segment=  'Hercules F - All Flows Step 2(Upload Attempt) Funnel Segment' THEN 'Step 2 Upload Attempt'
WHEN af.Segment = 'Hercules F - All Flows Step 3(Configurator) Funnel Segment' THEN 'Step 3 Configurator'
WHEN af.Segment='Hercules F - All Flows Step 4(Summary) Funnel Segment' THEN 'Step 4 Summary'
WHEN af.Segment= 'Hercules F - All Flows Step 5(Cart) Funnel Segment' THEN 'Step 5 Cart'
END as Segment,
af.Sessions AS 'Sessions'



FROM RETAIL_DATA.GA_Hercules_Product_Funnels_All_Flows af


WHERE af.Country = 'United States'



UNION ALL

SELECT 


  RETAIL_DATA.GA_Hercules_Product_Funnels_Step_One.DeviceCategory AS DeviceCategory,
  RETAIL_DATA.GA_Hercules_Product_Funnels_Step_One.Country AS Country,
  RETAIL_DATA.GA_Hercules_Product_Funnels_Step_One.Region AS Region,
  CONVERT(date, RETAIL_DATA.GA_Hercules_Product_Funnels_Step_One.Date) AS 'Date',
  CASE 
  WHEN RETAIL_DATA.GA_Hercules_Product_Funnels_Step_One.Segment = 'Hercules Product Funnel - All Flows Step 1  Funnel Segment' THEN 'Step 1 Landing Page'
  END as Segment,
  RETAIL_DATA.GA_Hercules_Product_Funnels_Step_One.Sessions AS 'Sessions'

  FROM RETAIL_DATA.GA_Hercules_Product_Funnels_Step_One 


  WHERE RETAIL_DATA.GA_Hercules_Product_Funnels_Step_One.Segment = 'Hercules Product Funnel - All Flows Step 1  Funnel Segment'
  AND RETAIL_DATA.GA_Hercules_Product_Funnels_Step_One.Country = 'United States'








---commented out code around order status to imporve preformance on Aug 30th, 2021 by Pavel Nacev---
---added new product categorization for poster boards on Sep 8th, 2021 by Pavel Nacev---




CREATE VIEW RETAIL_DATA.vSelfServe
AS
 

SELECT 
Retailers.FactID,
Retailers.BaseRevenue,
Retailers.Revenue,
Retailers.Discount,
Retailers.Units,
Retailers.OrderID,
Retailers.SubOrderID,
Retailers.ShippingFee,
Retailers.UserID,
Retailers.ExternalOrderID,
Retailers.Calendar Date,
Retailers.Calendar Year,
Retailers.Calendar Month,
Retailers.Calendar Week of Year,
Retailers.Calendar Day of Year,
Retailers.Calendar Day of Week,
Retailers.isRIK,
Retailers.IsResubmitted,
Retailers.ResubmittedFlag,
Retailers.PromoCode,
Retailers.PromoDescription,
Retailers.ShippingMethod,
Retailers.ShippingType,
Retailers.DeliveryCategory,
Retailers.Retailer,
Retailers.AppType,
Retailers.AppContext,
Retailers.MobileOS,
Retailers.StateAbb,
Retailers.CountryAbb,
Retailers.City,
Retailers.Zip,
Retailers.Row_H,
Retailers.Column_H,
Retailers.State_H,
Retailers.Abbreviation_H,

Retailers.Category,

CASE
WHEN Retailers.Retailer = 'Costco CA' AND Retailers.RetailerProductName = 'Desktop Calendar' THEN 'Desktop Calendar'
WHEN Retailers.Retailer = 'Costco CA' AND Retailers.RetailerProductName = '5x6 Photo Cards' THEN 'Photo Cards'
WHEN Retailers.Retailer = 'Costco CA' AND Retailers.RetailerProductName ='25oz Mug (2-pack)' THEN 'Drinkware'
WHEN Retailers.Retailer = 'Costco CA' AND Retailers.RetailerProductName ='25oz Mugs' THEN 'Drinkware'
WHEN Retailers.Retailer = 'Costco CA' AND Retailers.RetailerProductName ='15oz Mug' THEN 'Drinkware'
WHEN Retailers.Retailer = 'Costco CA' AND Retailers.RetailerProductName ='15oz Travel Mug' THEN 'Drinkware'
WHEN Retailers.Retailer = 'Costco CA' AND LOWER(Retailers.RetailerProductName) LIKE '%waterbottle%' THEN 'Drinkware'
WHEN Retailers.Retailer = 'Costco CA' AND Retailers.RetailerProductName ='60x80 Photo Blanket' THEN 'Blankets'
WHEN Retailers.Retailer = 'Costco CA' AND LOWER(Retailers.RetailerProductName) LIKE '%framed canvas%' THEN 'Framed Canvas Prints'
WHEN Retailers.Retailer = 'Costco CA' AND LOWER(Retailers.RetailerProductName) LIKE '%framed metal print%' THEN 'Framed Metal Prints'
WHEN Retailers.Retailer = 'Costco CA' AND Retailers.RetailerProductName = '6 8X8 Cluster Canvas' THEN 'Canvas Print'
WHEN Retailers.Retailer = 'Costco CA' AND Retailers.RetailerProductName = 'Diptych 40x30 Framed Canvas' THEN 'Framed Canvas Print'
WHEN Retailers.Retailer = 'Costco CA' AND Retailers.RetailerProductName ='Diptych 40x30' THEN 'Canvas Prints' 
WHEN Retailers.Retailer = 'Costco CA' AND Retailers.RetailerProductName ='Triptych 48x30 Framed Canvas' THEN 'Framed Canvas Prints'
WHEN Retailers.Retailer = 'Costco CA' AND Retailers.RetailerProductName = 'Triptych 48x30' THEN 'Canvas Prints'
WHEN Retailers.Retailer = 'Costco CA' AND Retailers.RetailerProductName = '110-piece Puzzle' THEN 'Photo Gifts'
ELSE Retailers.SubCategory
END AS SubCategory,
Retailers.RetailerProductName,
Retailers.ItemName,
Retailers.PNIProductSKU,
Retailers.Tag,
Retailers.ProductCode,
Retailers.DesignCode,
Retailers.DesignerID,
Retailers.ProductSize,
Retailers.Orientation,
Retailers.Surfaces,
Retailers.IsCreateYourOwn,
Retailers.PaymentMethod,
Retailers.ProductOptions,
--Retailers.Status AS OrderStatus,
Retailers.Vendor,


RDate.Staples Day of Year,
RDate.Staples Period,
RDate.Staples Quarter,
RDate.Staples Week,
RDate.Staples Week of Period,
RDate.Staples Year,

CostcoFiscal.Costco Day of Year,
CostcoFiscal.Costco Period,
CostcoFiscal.Costco Quarter,
CostcoFiscal.Costco Week,
CostcoFiscal.Costco Week of Period,
CostcoFiscal.Costco Year,


SAMSFiscal.SAMS Year,
SAMSFiscal.SAMS Week,
SAMSFiscal.SAMS Period,
SAMSFiscal.SAMS Day of Year,
SAMSFiscal.SAMS Quarter
--Sams_Users.usertype as SAMS UserType



FROM 


((SELECT 

f.fact_id AS FactID,
f.baseItemTotal AS BaseRevenue,
f.itemTotal AS Revenue,
f.discountTotal AS Discount,
f.quantity AS Units,
f.orderID as OrderID,
f.subOrderID AS SubOrderID,
f.allocatedShippingFee As ShippingFee,
f.userID AS UserID,
ISNULL(f.ExternalOrderID, f.orderID) as ExternalOrderID,
dt.Date AS 'Calendar Date',
dt.Year AS 'Calendar Year',
dt.Month AS 'Calendar Month',
dt.WeekOfYear AS 'Calendar Week of Year',
dt.DayOfYear AS 'Calendar Day of Year',
dt.DayOfWeek AS 'Calendar Day of Week',
CASE 
WHEN f.isRIK = 1 THEN 'RIK'
WHEN f.isRIK =0 THEN 'NON_RIK'
ELSE 'NON_RIK'
END AS isRIK,
IIF(ISNULL(f.isResubmit,0) = 0, 'Not-Resubmitted', 'Resubmitted') AS IsResubmitted,
ISNULL(f.isResubmit,0) AS ResubmittedFlag,
pr.promoCode AS PromoCode,
pr.Description AS PromoDescription,
sh.shippingMethod AS ShippingMethod,
sh.ShippingType AS ShippingType,
del.deliveryCategory AS DeliveryCategory,
'Costco US' AS Retailer,
app.appType AS AppType,
app.appContextID AS AppContext,
app.mobileOS AS MobileOS,
d.state_abbrev AS 'StateAbb',
d.country_abbrev as 'CountryAbb',
d.city as 'City',
d.zip as 'Zip',
H.Row_H AS Row_H,
H.Column_H AS Column_H,
H.State_H AS State_H,
H.Abbreviation_H AS Abbreviation_H,
CASE WHEN p.SKU IN('PRGift;6888','PRGift;6889', 'PRGift;6890') THEN 'Prints'
ELSE p.RetailerProductTypeName END AS Category,

CASE
WHEN p.RetailerProductSubTypeName ='Stationery' THEN 'Stationery Cards'
WHEN p.SKU IN('PRGift;6888','PRGift;6889', 'PRGift;6890') THEN 'Poster Boards'
ELSE p.RetailerProductSubTypeName
END AS SubCategory,

CASE
WHEN p.SKU='PRGift;6888' THEN '11x14'
WHEN p.SKU='PRGift;6889' THEN '16x20'
WHEN p.SKU='PRGift;6890' THEN '20x30'
ELSE p.RetailerProductBaseName
END AS RetailerProductName,
p.retailerProductName AS ItemName,
p.SKU AS PNIProductSKU,
p.Tags AS Tag,
p.ProductCode AS ProductCode,
p.DesignCode AS DesignCode,
p.DesignerID AS DesignerID,
p.Size AS ProductSize,
p.Orientation AS Orientation,
p.NoOfSurfaces AS Surfaces,
p.IsCreateYourOwn AS IsCreateYourOwn,
pay.PaymentMethod AS PaymentMethod,
p.ProductOptions AS ProductOptions,
--ISNULL(sl.orderStatus,'Complete') AS Status,
vn.vendor As Vendor

FROM 


PROD_BRONZE_DB.RETAIL_DATA.factOrder as f
INNER JOIN PROD_BRONZE_DB.RETAIL_DATA.dimProduct as p
ON f.dim_product_id = p.dim_product_id
INNER JOIN PROD_BRONZE_DB.RETAIL_DATA.dimRetailer AS r
on f.dim_retailer_id = r.dim_retailer_id
INNER JOIN PROD_BRONZE_DB.RETAIL_DATA.dimPromo as pr
ON f.dim_promo_id = pr.dim_promo_id
INNER JOIN PROD_BRONZE_DB.RETAIL_DATA.dimApplication AS app
ON f.dim_app_id = app.dim_app_id
INNER JOIN PROD_BRONZE_DB.RETAIL_DATA.dimDestination as d
ON f.dim_dest_id = d.dim_dest_id
INNER JOIN PROD_BRONZE_DB.RETAIL_DATA.dimPayment as pay
ON f.dim_payment_id = pay.dim_payment_id
INNER JOIN PROD_BRONZE_DB.RETAIL_DATA.dimDate as dt
ON f.checkoutdate_id = dt.dim_date_ID
INNER JOIN PROD_BRONZE_DB.RETAIL_DATA.dimShipping as sh
ON f.dim_shipping_id = sh.dim_shipping_id
INNER JOIN PROD_BRONZE_DB.RETAIL_DATA.dimDelivery as del
ON f.dim_delivery_id = del.dim_delivery_id
INNER JOIN PROD_BRONZE_DB.MASTER_DATA.dimRDate as rdt
on dt.dim_date_ID = rdt.dim_date_id and f.retailerID = rdt.RetailerID
INNER JOIN PROD_BRONZE_DB.RETAIL_DATA.dimVendor as vn
ON f.dim_vendor_id = vn.dim_vendor_id
LEFT JOIN PROD_BRONZE_DB.RETAIL_DATA.Hexmap as H
ON d.state_abbrev = H.Abbreviation_H
--LEFT JOIN  PROD_BRONZE_DB.RETAIL_DATA.dimInCompletedSubOrderStatus st
--ON f.retailerID=st.retailerid and f.orderID=st.orderid and f.subOrderID=st.suborderid
--LEFT JOIN PROD_BRONZE_DB.RETAIL_DATA.RPT_TestUser as test on f.retailerID=test.retailerid and f.userID=test.userid
--LEFT JOIN PROD_BRONZE_DB.RETAIL_DATA.dimStatus as sl on st.orderstatusid =sl.orderStatusID AND sl.retailerID =27


WHERE f.retailerID = 27
AND ISNULL(f.isTest,0)=0
AND f.fact_id != 224811775
--and isnull(test.userid,0) =0
AND CONVERT(date,f.checkoutDateTime) >= '2019-01-01'
AND p.PNIProductTypeName != 'Business Products'
AND p.RetailerProductBaseName != 'Stationery Card Envelopes' -- Remove envelopes and VAC in cards
AND p.RetailerProductBaseName != '6x7.5 Photo Cards VAC'
AND p.SKU NOT IN ( 
'6x75_L_N_25',
'16x20_B_P_COMM',
'20x30_B_P_COMM',
'134',
'135',
'2061',
'2563',
'2564',
'2565',
'2571',
'2575',
'NB_1',
'Notepad_14',
'NP_2',
'NP_81',
'S_1',
'S_19',
'S_23',
'S_56',
'S_58'))

UNION ALL 


(SELECT 


f.fact_id AS FactID,
f.baseItemTotal AS BaseRevenue,
f.itemTotal AS Revenue,
f.discountTotal AS Discount,
f.quantity AS Units,
f.orderID as OrderID,
f.subOrderID AS SubOrderID,
f.allocatedShippingFee As ShippingFee,
f.userID AS UserID,
ISNULL(f.ExternalOrderID, f.orderID) as ExternalOrderID,
dt.Date AS 'Calendar Date',
dt.Year AS 'Calendar Year',
dt.Month AS 'Calendar Month',
dt.WeekOfYear AS 'Calendar Week of Year',
dt.DayOfYear AS 'Calendar Day of Year',
dt.DayOfWeek AS 'Calendar Day of Week',
CASE 
WHEN f.isRIK = 1 THEN 'RIK'
WHEN f.isRIK =0 THEN 'NON_RIK'
ELSE 'NON_RIK'
END AS isRIK,
IIF(ISNULL(f.isResubmit,0) = 0, 'Not-Resubmitted', 'Resubmitted') AS IsResubmitted,
ISNULL(f.isResubmit,0) AS ResubmittedFlag,
pr.promoCode AS PromoCode,
pr.Description AS PromoDescription,
sh.shippingMethod AS ShippingMethod,
sh.ShippingType AS ShippingType,
del.deliveryCategory AS DeliveryCategory,
'Costco BP' AS Retailer,
app.appType AS AppType,
app.appContextID AS AppContext,
app.mobileOS AS MobileOS,
d.state_abbrev AS 'StateAbb',
d.country_abbrev as 'CountryAbb',
d.city as 'City',
d.zip as 'Zip',
H.Row_H AS Row_H,
H.Column_H AS Column_H,
H.State_H AS State_H,
H.Abbreviation_H AS Abbreviation_H,

CASE
	  WHEN p.Tags LIKE '%yard sign%' THEN 'Signs'
	  WHEN p.Tags LIKE '%banner%' THEN 'Banners'
	  ELSE p.RetailerProductTypeName
	  END AS Category,

CASE 
	  WHEN p.Tags LIKE '%yard sign%' THEN 'Yard Signs' + ' - ' + p.Size
	  WHEN p.Tags LIKE '%banner%' THEN p.Size
	  ELSE  p.RetailerProductSubTypeName
	  END AS SubCategory,

CASE 
	  WHEN p.Tags LIKE '%yard sign%' THEN p.Size
	  WHEN p.Tags LIKE '%banner%' THEN p.Size
	  ELSE p.RetailerProductBaseName
	  END AS RetailerProductName,

p.retailerProductName AS ItemName,
p.SKU AS PNIProductSKU,
p.Tags AS Tag,
p.ProductCode AS ProductCode,
p.DesignCode AS DesignCode,
p.DesignerID AS DesignerID,
p.Size AS ProductSize,
p.Orientation AS Orientation,
p.NoOfSurfaces AS Surfaces,
p.IsCreateYourOwn AS IsCreateYourOwn,
pay.PaymentMethod AS PaymentMethod,
p.ProductOptions AS ProductOptions,
--ISNULL(sl.orderStatus,'Complete') AS Status,
vn.vendor AS Vendor



FROM 


PROD_BRONZE_DB.RETAIL_DATA.factOrder as f
INNER JOIN PROD_BRONZE_DB.RETAIL_DATA.dimProduct as p
ON f.dim_product_id = p.dim_product_id
INNER JOIN PROD_BRONZE_DB.RETAIL_DATA.dimRetailer AS r
on f.dim_retailer_id = r.dim_retailer_id
INNER JOIN PROD_BRONZE_DB.RETAIL_DATA.dimPromo as pr
ON f.dim_promo_id = pr.dim_promo_id
INNER JOIN PROD_BRONZE_DB.RETAIL_DATA.dimApplication AS app
ON f.dim_app_id = app.dim_app_id
INNER JOIN PROD_BRONZE_DB.RETAIL_DATA.dimDestination as d
ON f.dim_dest_id = d.dim_dest_id
INNER JOIN PROD_BRONZE_DB.RETAIL_DATA.dimPayment as pay
ON f.dim_payment_id = pay.dim_payment_id
INNER JOIN PROD_BRONZE_DB.RETAIL_DATA.dimDate as dt
ON f.checkoutdate_id = dt.dim_date_ID
INNER JOIN PROD_BRONZE_DB.RETAIL_DATA.dimShipping as sh
ON f.dim_shipping_id = sh.dim_shipping_id
INNER JOIN PROD_BRONZE_DB.RETAIL_DATA.dimDelivery as del
ON f.dim_delivery_id = del.dim_delivery_id
INNER JOIN PROD_BRONZE_DB.MASTER_DATA.dimRDate as rdt
on dt.dim_date_ID = rdt.dim_date_id and f.retailerID = rdt.RetailerID
INNER JOIN PROD_BRONZE_DB.RETAIL_DATA.dimVendor as vn
ON f.dim_vendor_id = vn.dim_vendor_id
LEFT JOIN PROD_BRONZE_DB.RETAIL_DATA.Hexmap as H
ON d.state_abbrev = H.Abbreviation_H
--LEFT JOIN  PROD_BRONZE_DB.RETAIL_DATA.dimInCompletedSubOrderStatus st
--ON f.retailerID=st.retailerid and f.orderID=st.orderid and f.subOrderID=st.suborderid
--LEFT JOIN PROD_BRONZE_DB.RETAIL_DATA.RPT_TestUser as test on f.retailerID=test.retailerid and f.userID=test.userid
--LEFT JOIN PROD_BRONZE_DB.RETAIL_DATA.dimStatus as sl on st.orderstatusid =sl.orderStatusID AND sl.retailerID =27




WHERE f.retailerID = 27
AND ISNULL(f.isTest,0)=0
--and isnull(test.userid,0) =0
AND f.fact_id != 224811775
AND f.orderID != 363133057
AND CONVERT(date,f.checkoutDateTime) >= '2019-01-01'
AND p.PNIProductTypeName = 'Business Products'
)

UNION ALL 


(SELECT 
f.fact_id AS FactID,
f.baseItemTotal AS BaseRevenue,
f.itemTotal AS Revenue,
f.discountTotal AS Discount,
f.quantity AS Units,
f.orderID as OrderID,
f.subOrderID AS SubOrderID,
f.allocatedShippingFee As ShippingFee,
f.userID AS UserID,
ISNULL(f.ExternalOrderID, f.orderID) as ExternalOrderID,
dt.Date AS 'Calendar Date',
dt.Year AS 'Calendar Year',
dt.Month AS 'Calendar Month',
dt.WeekOfYear AS 'Calendar Week of Year',
dt.DayOfYear AS 'Calendar Day of Year',
dt.DayOfWeek AS 'Calendar Day of Week',
CASE 
WHEN f.isRIK = 1 THEN 'RIK'
WHEN f.isRIK =0 THEN 'NON_RIK'
ELSE 'NON_RIK'
END AS isRIK,
IIF(ISNULL(f.isResubmit,0) = 0, 'Not-Resubmitted', 'Resubmitted') AS IsResubmitted,
ISNULL(f.isResubmit,0) AS ResubmittedFlag,
pr.promoCode AS PromoCode,
pr.Description AS PromoDescription,
sh.shippingMethod AS ShippingMethod,
sh.ShippingType AS ShippingType,
del.deliveryCategory AS DeliveryCategory,
'SAMS BP' AS Retailer,
app.appType AS AppType,
app.appContextID AS AppContext,
app.mobileOS AS MobileOS,
d.state_abbrev AS 'StateAbb',
d.country_abbrev as 'CountryAbb',
d.city as 'City',
d.zip as 'Zip',
H.Row_H AS Row_H,
H.Column_H AS Column_H,
H.State_H AS State_H,
H.Abbreviation_H AS Abbreviation_H,

p.PNIProductTypeName AS Category,
p.PNIProductSubTypeName AS SubCategory,
p.RetailerProductBaseName AS RetailerProductName,
p.retailerProductName AS ItemName,
p.SKU AS PNIProductSKU,
p.Tags AS Tag,
p.ProductCode AS ProductCode,
p.DesignCode AS DesignCode,
p.DesignerID AS DesignerID,
p.Size AS ProductSize,
p.Orientation AS Orientation,
p.NoOfSurfaces AS Surfaces,
p.IsCreateYourOwn AS IsCreateYourOwn,
pay.PaymentMethod AS PaymentMethod,
p.ProductOptions AS ProductOptions,
--ISNULL(sl.orderStatus,'Complete') AS Status,
vn.vendor AS Vendor



FROM 


PROD_BRONZE_DB.RETAIL_DATA.factOrder as f
INNER JOIN PROD_BRONZE_DB.RETAIL_DATA.dimProduct as p
ON f.dim_product_id = p.dim_product_id
INNER JOIN PROD_BRONZE_DB.RETAIL_DATA.dimRetailer AS r
on f.dim_retailer_id = r.dim_retailer_id
INNER JOIN PROD_BRONZE_DB.RETAIL_DATA.dimPromo as pr
ON f.dim_promo_id = pr.dim_promo_id
INNER JOIN PROD_BRONZE_DB.RETAIL_DATA.dimApplication AS app
ON f.dim_app_id = app.dim_app_id
INNER JOIN PROD_BRONZE_DB.RETAIL_DATA.dimDestination as d
ON f.dim_dest_id = d.dim_dest_id
INNER JOIN PROD_BRONZE_DB.RETAIL_DATA.dimPayment as pay
ON f.dim_payment_id = pay.dim_payment_id
INNER JOIN PROD_BRONZE_DB.RETAIL_DATA.dimDate as dt
ON f.checkoutdate_id = dt.dim_date_ID
INNER JOIN PROD_BRONZE_DB.RETAIL_DATA.dimShipping as sh
ON f.dim_shipping_id = sh.dim_shipping_id
INNER JOIN PROD_BRONZE_DB.RETAIL_DATA.dimDelivery as del
ON f.dim_delivery_id = del.dim_delivery_id
INNER JOIN PROD_BRONZE_DB.MASTER_DATA.dimRDate as rdt
on dt.dim_date_ID = rdt.dim_date_id and f.retailerID = rdt.RetailerID
INNER JOIN PROD_BRONZE_DB.RETAIL_DATA.dimVendor as vn
ON f.dim_vendor_id = vn.dim_vendor_id
LEFT JOIN PROD_BRONZE_DB.RETAIL_DATA.Hexmap as H
ON d.state_abbrev = H.Abbreviation_H
--LEFT JOIN  PROD_BRONZE_DB.RETAIL_DATA.dimInCompletedSubOrderStatus st
--ON f.retailerID=st.retailerid and f.orderID=st.orderid and f.subOrderID=st.suborderid
--LEFT JOIN PROD_BRONZE_DB.RETAIL_DATA.RPT_TestUser as test on f.retailerID=test.retailerid and f.userID=test.userid
--LEFT JOIN PROD_BRONZE_DB.RETAIL_DATA.dimStatus as sl on st.orderstatusid =sl.orderStatusID AND sl.retailerID =26


WHERE f.retailerID = 26
AND ISNULL(f.isTest,0)=0
--and isnull(test.userid,0) =0
AND f.fact_id != 224811775
--AND f.orderID != 363133057
AND CONVERT(date,f.checkoutDateTime) >= '2019-01-01'
AND p.PNIProductTypeName = 'Business Products')

UNION  ALL 

(SELECT 

f.fact_id AS FactID,
f.baseItemTotal AS BaseRevenue,
f.itemTotal AS Revenue,
f.discountTotal AS Discount,
f.quantity AS Units,
f.orderID as OrderID,
f.subOrderID AS SubOrderID,
f.allocatedShippingFee As ShippingFee,
f.userID AS UserID,
ISNULL(f.ExternalOrderID, f.orderID) as ExternalOrderID,
dt.Date AS 'Calendar Date',
dt.Year AS 'Calendar Year',
dt.Month AS 'Calendar Month',
dt.WeekOfYear AS 'Calendar Week of Year',
dt.DayOfYear AS 'Calendar Day of Year',
dt.DayOfWeek AS 'Calendar Day of Week',
CASE 
WHEN f.isRIK = 1 THEN 'RIK'
WHEN f.isRIK =0 THEN 'NON_RIK'
ELSE 'NON_RIK'
END AS isRIK,
IIF(ISNULL(f.isResubmit,0) = 0, 'Not-Resubmitted', 'Resubmitted') AS IsResubmitted,
ISNULL(f.isResubmit,0) AS ResubmittedFlag,
pr.promoCode AS PromoCode,
pr.Description AS PromoDescription,
sh.shippingMethod AS ShippingMethod,
sh.ShippingType AS ShippingType,
del.deliveryCategory AS DeliveryCategory,
'SAMS' AS Retailer,
app.appType AS AppType,
app.appContextID AS AppContext,
app.mobileOS AS MobileOS,
d.state_abbrev AS 'StateAbb',
d.country_abbrev as 'CountryAbb',
d.city as 'City',
d.zip as 'Zip',
H.Row_H AS Row_H,
H.Column_H AS Column_H,
H.State_H AS State_H,
H.Abbreviation_H AS Abbreviation_H,
ref_tbl.subProductGroup1  AS Category,
ref_tbl.subProductGroup2 AS SubCategory,
ref_tbl.productName AS RetailerProductName,
p.retailerProductName AS ItemName,
p.SKU AS PNIProductSKU,
p.Tags AS Tag,
p.ProductCode AS ProductCode,
p.DesignCode AS DesignCode,
p.DesignerID AS DesignerID,
p.Size AS ProductSize,
p.Orientation AS Orientation,
p.NoOfSurfaces AS Surfaces,
p.IsCreateYourOwn AS IsCreateYourOwn,
pay.PaymentMethod AS PaymentMethod,
p.ProductOptions AS ProductOptions,
--ISNULL(sl.orderStatus,'Complete') AS Status,
vn.vendor AS Vendor




FROM 


PROD_BRONZE_DB.RETAIL_DATA.factOrder as f
INNER JOIN PROD_BRONZE_DB.RETAIL_DATA.dimProduct as p
ON f.dim_product_id = p.dim_product_id
INNER JOIN PROD_BRONZE_DB.RETAIL_DATA.dimRetailer AS r
on f.dim_retailer_id = r.dim_retailer_id
INNER JOIN PROD_BRONZE_DB.RETAIL_DATA.dimPromo as pr
ON f.dim_promo_id = pr.dim_promo_id
INNER JOIN PROD_BRONZE_DB.RETAIL_DATA.dimApplication AS app
ON f.dim_app_id = app.dim_app_id
INNER JOIN PROD_BRONZE_DB.RETAIL_DATA.dimDestination as d
ON f.dim_dest_id = d.dim_dest_id
INNER JOIN PROD_BRONZE_DB.RETAIL_DATA.dimPayment as pay
ON f.dim_payment_id = pay.dim_payment_id
INNER JOIN PROD_BRONZE_DB.RETAIL_DATA.dimDate as dt
ON f.checkoutdate_id = dt.dim_date_ID
INNER JOIN PROD_BRONZE_DB.RETAIL_DATA.dimShipping as sh
ON f.dim_shipping_id = sh.dim_shipping_id
INNER JOIN PROD_BRONZE_DB.RETAIL_DATA.dimDelivery as del
ON f.dim_delivery_id = del.dim_delivery_id
INNER JOIN PROD_BRONZE_DB.MASTER_DATA.dimRDate as rdt
on dt.dim_date_ID = rdt.dim_date_id and f.retailerID = rdt.RetailerID
INNER JOIN PROD_BRONZE_DB.RETAIL_DATA.dimVendor as vn
ON f.dim_vendor_id = vn.dim_vendor_id
LEFT JOIN PROD_BRONZE_DB.RETAIL_DATA.Hexmap as H
ON d.state_abbrev = H.Abbreviation_H
LEFT JOIN PROD_BRONZE_DB.RETAIL_DATA.rpt_allretailer_ProductGroup AS ref_tbl
ON p.SKU=ref_tbl.SKU AND p.retailerProductID = ref_tbl.retailerProductID  AND ref_tbl.retailerID =26
--LEFT JOIN  PROD_BRONZE_DB.RETAIL_DATA.dimInCompletedSubOrderStatus st
--ON f.retailerID=st.retailerid and f.orderID=st.orderid and f.subOrderID=st.suborderid
--LEFT JOIN PROD_BRONZE_DB.RETAIL_DATA.RPT_TestUser as test on f.retailerID=test.retailerid and f.userID=test.userid
--LEFT JOIN PROD_BRONZE_DB.RETAIL_DATA.dimStatus as sl on st.orderstatusid =sl.orderStatusID AND sl.retailerID =26


WHERE f.retailerID = 26
AND ISNULL(f.isTest,0)=0
--and isnull(test.userid,0) =0
AND f.fact_id != 224811775
--AND f.orderID != 363133057
AND CONVERT(date,f.checkoutDateTime) >= '2019-01-01'
AND p.PNIProductTypeName != 'Business Products'
AND p.SKU != 'UNKN')

UNION ALL 

( SELECT

rn.Id AS FactID,
rn.BaseRevenue AS BaseRevenue,
rn.Revenue AS Revenue,
rn.DiscountAmount AS Discount,
rn.Units AS Units,
rn.OrderID AS OrderID,
rn.SubOrderID AS SubOrderID,
rn.ShippingFee AS ShippingFee,
rn.UserID AS UserID,
rn.ExternalOrderID AS ExternalOrderID,
rn.Date AS 'Calendar Date',
rn.CalendarYear AS 'Calendar Year',
rn.CalendarMonth AS 'Calendar Month',
rn.CalendarWeek AS 'Calendar Week of Year',
rn.CalendarDayOfYear AS 'Calendar Day of Year',
rn.DayOfWeek AS 'Calendar Day of Week',
rn.Rik_Classified AS isRIK,
rn.IsResubmitted AS IsResubmitted,
rn.ResubmittedFlag AS ResubmittedFlag,
rn.PromoCode AS PromoCode,
rn.PromoDesc AS PromoDescription,
rn.Shipping_Method AS ShippingMethod,
rn.ShippingType AS ShippingType,
rn.Delivery_Category AS DeliveryCategory,
'Staples BP (Design)' AS Retailer,
rn.AppType AS AppType,
rn.AppContextID AS AppContext,
rn.MobileOS AS MobileOS,
rn.State AS StateAbb,
rn.Country as CountryAbb,
rn.City AS City,
rn.ZipCode as Zip,
rn.Row_H as Row_H,
rn.Column_H as Column_H,
rn.State_H AS State_H,
rn.Abbreviation_H as	Abbreviation_H,
rn.SUb_Category AS Category,
CASE 
WHEN rn.SUb_Category='Business Card' AND LOWER(rn.Tags) LIKE '%raised%' THEN 'Raised Print'
WHEN rn.SUb_Category='Business Card' AND LOWER(rn.Tags) LIKE '%executive%' THEN 'Executive Print'
WHEN rn.SUb_Category='Business Card' AND LOWER(rn.Tags) LIKE '%ultra thick%' THEN 'Ultra Thick Print'
WHEN rn.SUb_Category='Business Card' AND ( NOT(LOWER(rn.Tags) LIKE '%ultra thick%') OR NOT(LOWER(rn.Tags) LIKE '%executive%') OR NOT(LOWER(rn.Tags) LIKE '%raised%')) THEN 'Standard Business Cards'
WHEN rn.SUb_Category='Signs' AND LOWER(rn.Tags) LIKE '%yard%' THEN 'Yard Signs'
WHEN rn.SUb_Category='Signs' AND LOWER(rn.Tags) LIKE '%floor decal%' THEN 'Floor Decal Signs'
WHEN rn.SUb_Category='Signs' AND LOWER(rn.Tags) LIKE '%wall decal%' THEN 'Wall Decal Signs'
WHEN rn.SUb_Category='Signs' AND LOWER(rn.Tags) LIKE '%window decal%' THEN 'Window Decal Signs'
WHEN rn.SUb_Category='Signs' AND LOWER(rn.Tags) LIKE '%outdoor sign%' THEN 'Outdoor Signs'
WHEN rn.SUb_Category='Signs' AND LOWER(rn.Tags) LIKE '%hanging sign%' THEN 'Hanging Signs'
WHEN rn.SUb_Category='Signs' AND LOWER(rn.Tags) LIKE '%aframe%' THEN 'A-Frame Signs'
WHEN rn.SUb_Category='Signs' AND LOWER(rn.Tags) LIKE '%snap frame%' THEN 'Snap Frame Signs'
WHEN rn.SUb_Category='Signs' AND LOWER(rn.Tags) LIKE '%parking sign%' THEN 'Parking Signs'
WHEN rn.SUb_Category='Signs' AND LOWER(rn.Tags) LIKE '%real estate sign%' THEN 'Real Estate Signs'
WHEN rn.SUb_Category='Signs' AND LOWER(rn.Tags) LIKE '%sign riders%' THEN 'Real Estate Signs Riders'
WHEN rn.SUb_Category='Signs' AND LOWER(rn.Tags) LIKE '%desk sign%' THEN 'Desk Signs'
WHEN rn.SUb_Category='Signs' AND LOWER(rn.Tags) LIKE '%wall sign%' THEN 'Wall Signs'
WHEN rn.SUb_Category='Signs' AND LOWER(rn.Tags) LIKE '%window cling%' THEN 'Window Cling'
WHEN rn.SUb_Category='Signs' AND LOWER(rn.Tags) LIKE '%unkn%' THEN 'Outdoor Signs'
WHEN rn.SUb_Category='Badges' AND LOWER(rn.Tags) LIKE '%badge engraved%' THEN 'Engraved Badges'
WHEN rn.SUb_Category='Badges' AND LOWER(rn.Tags) LIKE '%badge printed%' THEN 'Printed Badges'
WHEN rn.SUb_Category='Card' AND LOWER(rn.Tags) LIKE '%signature-cards%' AND NOT LOWER(rn.Tags) LIKE '%foil%' THEN 'Premium Cards'
WHEN rn.SUb_Category='Card' AND LOWER(rn.Tags) LIKE '%signature-cards%' AND LOWER(rn.Tags) LIKE '%foil%' THEN 'Premium Foil Cards'
WHEN rn.SUb_Category='Card' AND LOWER(rn.Tags) LIKE '%cards%' THEN 'Standard Cards'
WHEN rn.SUb_Category='Card' AND LOWER(rn.Tags) LIKE '%unkn%' THEN 'Premium Cards'
WHEN rn.SUb_Category='Posters' AND LOWER(rn.Tags) LIKE '%adhesive poster%' THEN 'Adhesive Posters' + ' - ' + rn.Size
WHEN rn.SUb_Category='Posters' AND LOWER(rn.Tags) LIKE '%foam board poster%' THEN 'Foam Board Posters' + ' - ' + rn.Size
WHEN rn.SUb_Category='Posters' AND LOWER(rn.Tags) LIKE '%poster%' THEN 'Posters' + ' - ' + rn.Size
WHEN rn.SUb_Category='Banner' THEN 'Banner' + ' - ' + rn.Size
WHEN rn.SUb_Category='Banner Stand' THEN 'Banner Stand' + ' - ' + rn.Size
WHEN rn.SUb_Category='Postcard' THEN 'Postcard' + ' - ' + rn.Size
WHEN rn.SUb_Category='Magnets' AND LOWER(rn.Tags) LIKE '%business card magnet%' THEN 'Business Card Magnet' + ' - '+ rn.Size
WHEN rn.SUb_Category='Magnets' AND LOWER(rn.Tags) LIKE '%postcard size magnet%' THEN 'Postcard Size Magnet' + ' - '+ rn.Size
WHEN rn.SUb_Category='Magnets' AND LOWER(rn.Tags) LIKE '%extra large photo magnets%' THEN 'Extra Large Photo Magnet' + ' - '+ rn.Size
WHEN rn.SUb_Category='Magnets' AND LOWER(rn.Tags) LIKE '%car door magnet%' THEN 'Car door Magnet' + ' - '+ rn.Size
WHEN rn.SUb_Category='Flyer' THEN 'Flyer' + ' - ' + rn.Size
WHEN rn.SUb_Category='Brochure' THEN 'Brochure' + ' - ' + rn.Size
WHEN rn.SUb_Category='Folder' THEN 'Folder' + ' - ' + rn.Size
WHEN rn.SUb_Category='Gift Certificates' THEN 'Gift Certificates' + ' - ' + rn.Size
WHEN rn.SUb_Category='Rackcards' THEN 'Rackcards' + ' - ' + rn.Size
WHEN rn.SUb_Category='Mugs' AND LOWER(rn.Tags) LIKE '%mug%' THEN 'Mugs' + ' - ' + rn.Size
WHEN rn.SUb_Category='Mugs' AND LOWER(rn.Tags) LIKE '%water bottle%' THEN 'Water Bottle' + ' - ' + rn.Size
WHEN rn.SUb_Category='Blankets' THEN 'Blankets' + ' - ' + rn.Size
WHEN rn.SUb_Category='Bumper Sticker' THEN 'Bumper Sticker' + ' - ' + rn.Size
WHEN rn.SUb_Category='Business Card Holder' THEN 'Business Card Holder' + ' - ' + rn.Size
WHEN rn.SUb_Category='Canvas' THEN 'Canvas' + ' - ' + rn.Size
WHEN rn.SUb_Category='Coasters' THEN 'Coasters' + ' - ' + rn.Size
WHEN rn.SUb_Category='Device Case' THEN 'Device Case' + ' - ' + rn.Size
WHEN rn.SUb_Category='Mounted Prints' THEN 'Mounted Prints' + ' - ' + rn.Size
WHEN rn.SUb_Category='Mousepad' THEN 'Mousepad' + ' - ' + rn.Size
WHEN rn.SUb_Category='Notebook' THEN 'Notebook' + ' - ' + rn.Size
WHEN rn.SUb_Category='Notecard' THEN 'Notecard' + ' - ' + rn.Size
WHEN rn.SUb_Category='Notepad' THEN 'Notepad' + ' - ' + rn.Size
WHEN rn.SUb_Category='Ornaments' THEN 'Ornaments' + ' - ' + rn.Size
WHEN rn.SUb_Category='Plaque' THEN 'Plaque' + ' - ' + rn.Size
WHEN rn.SUb_Category='Print' THEN 'Print' + ' - ' + rn.Size
WHEN rn.SUb_Category='Puzzle' THEN 'Puzzle' + ' - ' + rn.Size
WHEN rn.SUb_Category='Tote Bag' THEN 'Tote Bag' + ' - ' + rn.Size
WHEN rn.SUb_Category='Calendar'  THEN 'Calendar'
WHEN rn.SUb_Category='Envelope' AND rn.PNIProductSKU='PNI_Catalog_Envelopes' THEN 'Catalog Envelopes' + ' - '+ rn.Size
WHEN rn.SUb_Category='Envelope' AND rn.PNIProductSKU='PNI_Envelopes' THEN 'Envelopes' + ' - '+ rn.Size
WHEN rn.SUb_Category='Labels' AND LOWER(rn.Tags) LIKE '%fan folded label%' THEN 'Fan Folded Label' + ' - ' + rn.Size
WHEN rn.SUb_Category='Labels' AND LOWER(rn.Tags) LIKE '%mail label%' THEN 'Mailing Labels' + ' - ' + rn.Size
WHEN rn.SUb_Category='Labels' AND LOWER(rn.Tags) LIKE '%product label%' THEN 'Product Label' + ' - ' + rn.Size
WHEN rn.SUb_Category='Labels' AND LOWER(rn.Tags) LIKE '%return address label%' THEN 'Return Address Label' + ' - ' + rn.Size
WHEN rn.SUb_Category='Letterhead' THEN 'Letterhead' + ' - ' + rn.Size
WHEN rn.SUb_Category='Stamps' AND LOWER(rn.Tags) LIKE '%pre inked stamp%' THEN 'Pre Inked Stamps' + ' - ' + rn.Size
WHEN rn.SUb_Category='Stamps' AND LOWER(rn.Tags) LIKE '%date stamp%' THEN 'Date Stamps' + ' - ' + rn.Size
WHEN rn.SUb_Category='Stamps' AND LOWER(rn.Tags) LIKE '%mine stamp%' THEN 'Mime Stamps' + ' - ' + rn.Size
WHEN rn.SUb_Category='Stamps' AND LOWER(rn.Tags) LIKE '%rubber stamps%' THEN 'Rubber Stamps' + ' - ' + rn.Size
WHEN rn.SUb_Category='Stamps' AND LOWER(rn.Tags) LIKE '%refill ink%' THEN 'Refill Ink' + ' - ' + rn.Size
WHEN rn.SUb_Category='Stamps' AND LOWER(rn.Tags) LIKE '%self-inking stamps%' THEN 'Self Inking Stamps' + ' - ' + rn.Size
WHEN rn.SUb_Category='Stamps' AND LOWER(rn.Tags) LIKE '%stamp pad%' THEN 'Stamp Pad' + ' - ' + rn.Size
WHEN rn.SUb_Category='Stamps' AND LOWER(rn.Tags) LIKE '%address stamp%' THEN 'Address Stamps' + ' - ' + rn.Size
WHEN rn.SUb_Category='Stamps' AND LOWER(rn.Tags) LIKE '%notary stamps%' THEN 'Notary Stamps' + ' - ' + rn.Size
WHEN rn.SUb_Category='Stamps' AND LOWER(rn.Tags) LIKE '%message stamp%' THEN 'Message Stamps' + ' - ' + rn.Size
WHEN rn.SUb_Category='Stamps' AND LOWER(rn.Tags) LIKE '%signature stamp%' THEN 'Signature Stamps' + ' - ' + rn.Size
WHEN rn.SUb_Category='Stamps' AND LOWER(rn.Tags) LIKE '%unkn%' AND rn.PNIProductSKU ='PNI_Mime_Stamp' THEN 'Mime Stamps' + ' - ' + rn.Size
WHEN rn.SUb_Category='Stamps' AND LOWER(rn.Tags) LIKE '%endorsement stamp%' THEN 'Endorsement Stamps' + ' - ' + rn.Size
WHEN  rn.SUb_Category='CourierDelivery' THEN 'CourierDelivery'
ELSE rn.SUb_Category + ' ' + '-' + ' ' + rn.PNIProductSKU
END AS SubCategory,
rn.RetailerProductName AS RetailerProductName,
rn.ItemName AS ItemName,
rn.PNIProductSKU AS PNIProductSKU,
rn.Tags AS Tags,
rn.ProductCode AS ProductCode,
rn.DesignCode AS DesignCode,
rn.DesignerID AS DesignerID,
rn.Size AS ProductSize,
rn.Orientation AS Orientation,
rn.NoOfSurfaces AS Surfaces,
rn.IsCreateYourOwn AS IsCreateYourOwn,
rn.PaymentMethod AS PaymentMethod,
rn.ProductOptions AS ProductOptions,
--rn.Status,
'N/A' AS Vendor



FROM PROD_BRONZE_DB.RETAIL_DATA.vSPLUS_RIKvsNONRIK_Herc_exl as rn

WHERE rn.Date >= '2019-01-01')

UNION ALL 

(SELECT 
f.fact_id AS FactID,
f.baseItemTotal AS BaseRevenue,
f.itemTotal AS Revenue,
f.discountTotal AS Discount,
f.quantity AS Units,
f.orderID as OrderID,
f.subOrderID AS SubOrderID,
f.allocatedShippingFee As ShippingFee,
f.userID AS UserID,
ISNULL(f.ExternalOrderID, f.orderID) as ExternalOrderID,
dt.Date AS 'Calendar Date',
dt.Year AS 'Calendar Year',
dt.Month AS 'Calendar Month',
dt.WeekOfYear AS 'Calendar Week of Year',
dt.DayOfYear AS 'Calendar Day of Year',
dt.DayOfWeek AS 'Calendar Day of Week',
CASE 
WHEN f.isRIK = 1 THEN 'RIK'
WHEN f.isRIK =0 THEN 'NON_RIK'
ELSE 'NON_RIK'
END AS isRIK,
IIF(ISNULL(f.isResubmit,0) = 0, 'Not-Resubmitted', 'Resubmitted') AS IsResubmitted,
ISNULL(f.isResubmit,0) AS ResubmittedFlag,
pr.promoCode AS PromoCode,
pr.Description AS PromoDescription,
sh.shippingMethod AS ShippingMethod,
sh.ShippingType AS ShippingType,
del.deliveryCategory AS DeliveryCategory,
'Costco CA' AS Retailer,
app.appType AS AppType,
app.appContextID AS AppContext,
app.mobileOS AS MobileOS,
d.state_abbrev AS 'StateAbb',
d.country_abbrev as 'CountryAbb',
d.city as 'City',
d.zip as 'Zip',
H.Row_H AS Row_H,
H.Column_H AS Column_H,
H.State_H AS State_H,
H.Abbreviation_H AS Abbreviation_H,

p.RetailerProductTypeName AS Category,
p.RetailerProductSubTypeName AS SubCategory,
CASE 
WHEN p.SKU='Cal_10x5-25_3' THEN 'Desktop Calendar'
WHEN p.SKU= '11G_TRMUG2' THEN '15oz Travel Mug' 
WHEN p.SKU='15OZ_MUG_BKH' THEN '15oz Mug'
WHEN p.SKU = '15OZ_MUG_BKH_2' THEN '15oz Mug'
WHEN p.SKU = '15OZ_MUG_LBH' THEN '15oz Mug'
WHEN p.SKU ='15OZ_MUG_LBH_2' THEN '15oz Mug'
WHEN p.SKU= '15OZ_MUG_RH' THEN '15oz Mug'
WHEN p.SKU ='15OZ_MUG_RH_2' THEN '15oz Mug'
WHEN p.SKU = 'ORNA_GLASS_HEXAGON_2PK' THEN 'Glass Ornaments (2-pack)'
WHEN p.SKU = 'ORNA_METAL_SCAL' THEN 'Metal Ornament'
WHEN p.SKU = 'ORNA_METAL_SCAL_4PK' THEN 'Metal Ornament (4-pack)'
WHEN p.SKU = 'BLANKET_SS_60X80' THEN '60x80 Photo Blanket'
WHEN p.SKU ='BLANKET_SS_60X80' THEN '60x80 Photo Blanket' 
WHEN p.SKU = 'PLAQUE_WD_5X7' THEN '5x7 Desktop Plaque'
WHEN p.SKU ='PLAQUE_WD_8X10' THEN '8x10 Desktop Plaque'
WHEN p.SKU = 'PUZZLE_520PCS_2PK' AND p.retailerProductID=32243 THEN '520-piece Puzzles (2-Pack)'
WHEN p.SKU = 'PUZZLE_110PCS' THEN '110-piece Puzzle'
WHEN p.SKU = 'BOTTLE_SLIM_17OZ' THEN '17oz Waterbottle'
WHEN p.SKU = 'MCPB' THEN '11.25x8.75 Hard Cover Photobook'
WHEN p.SKU = 'MCPB_AGX' THEN '11.25x8.75 Hard Cover Photobook'
WHEN p.SKU = 'MCPB' THEN '11.25x8.75 Hard Cover Photobook'
WHEN p.SKU = 'PB_BB_11-25X8-75_LCUST||PB_COVER_11-25X8-75_LCUST' THEN '11x9 Custom Leather'
WHEN p.SKU = 'PB_BB_11-25X8-75_HARD||PB_COVER_11-25X8-75_HARD' THEN '11.25x8.75 Hard Cover Photobook'
WHEN p.SKU = 'PB_11-25X8-75_LEATH_BLK_KEY' THEN '11.25x8.75 Black Leather Photobook'
WHEN p.SKU ='PB_11-25X8-75_LEATH_BLU_KEY' THEN '11.25x8.75 Blue Leather Photobook'
WHEN p.SKU= 'PB_11-25X8-75_LEATH_BRN_KEY' THEN '11.25x8.75 Brown Leather Photobook'
WHEN p.SKU='PB_11-25X8-75_LEATH_WHT_KEY' THEN '11.25x8.75 White Leather Photobook'
WHEN p.SKU='PB_BB_12X12_AGX||PB_COVER_12X12_AGX' THEN '12x12 Premium Photobook'
WHEN p.SKU='PB_BB_12X12_LCUST||PB_COVER_12X12_LCUST' THEN '12x12 Premium Photobook'
WHEN p.SKU ='PB_BB_12X12_HARD-CWC||PB_COVER_12X12_HARD-CWC' THEN '12x12 Hard Cover Photobook'
WHEN p.SKU='11FKCWR_810' THEN '8x10 Framed Canvas'
WHEN p.SKU='11KCWR_810' THEN '8x10 Canvas'
WHEN p.SKU='11FKCWR_812' THEN '8x12 Framed Canvas'
WHEN p.SKU='11KCWR_812' THEN '8x12 Canvas'
WHEN p.SKU='11FKCWR_1114' THEN '11x14 Framed Canvas'
WHEN p.SKU='11KCWR_1114' THEN '11x14 Canvas'
WHEN p.SKU='11FKCWR_1218' THEN '12x18 Framed Canvas'
WHEN p.SKU='11KCWR_1218' THEN '12x18 Canvas'
WHEN p.SKU='11FKCWR_1620' THEN '16x20 Framed Canvas'
WHEN p.SKU='11KCWR_1620' THEN '16x20 Canvas'
WHEN p.SKU='11FKCWR_1648' THEN '16x48 Framed Canvas'
WHEN p.SKU='11KCWR_1648' THEN '16x48 Canvas'
WHEN p.SKU='11FKCWR_2436' THEN '24x36 Framed Canvas'
WHEN p.SKU='11KCWR_2436' THEN '24x36 Canvas'
WHEN p.SKU='11FKCWR_3040' THEN '30x40 Framed Canvas'
WHEN p.SKU='11KCWR_3040' THEN '30x40 Canvas'
WHEN p.SKU='11FKCWR_4060' THEN '40x60 Framed Canvas'
WHEN p.SKU='11KCWR_4060' THEN '40x60 Canvas'
WHEN p.SKU='13945001WF-810' THEN '8x10 Framed Print'
WHEN p.SKU='13945061WF-810' THEN '8x10 Framed Print'
WHEN p.SKU='13945063WF-810' THEN '8x10 Framed Print'
WHEN p.SKU='11FKCWR_1218' THEN '12x18 Framed Print'
WHEN p.SKU='13945001WF-1218' THEN '12x18 Framed Print'
WHEN p.SKU='13945061WF-1218' THEN '12x18 Framed Print'
WHEN p.SKU='13945063WF-1218' THEN '12x18 Framed Print'
WHEN p.SKU='13945001WF-1620' THEN '16x20 Framed Print'
WHEN p.SKU='13945061WF-1620' THEN '16x20 Framed Print'
WHEN p.SKU='13945063WF-1620' THEN '16x20 Framed Print'
WHEN p.SKU='13945001WF-2436' THEN '24x36 Framed Print'
WHEN p.SKU='13945061WF-2436' THEN '24x36 Framed Print'
WHEN p.SKU='13945063WF-2436' THEN '24x36 Framed Print'
WHEN p.SKU='11FKCWR_3040' THEN '30x40 Framed Print'
WHEN p.SKU='PANEL_AL_FR_11X14' THEN '11X14 Framed Metal Print'
WHEN p.SKU='PANEL_AL_FR_12X12' THEN '12X12 Framed Metal Print'
WHEN p.SKU='PANEL_AL_FR_16X20' THEN '16X20 Framed Metal Print'
WHEN p.SKU='PANEL_AL_FR_20X20' THEN '20X20 Framed Metal Print'
WHEN p.SKU='PANEL_AL_FR_20X30' THEN '20X30 Framed Metal Print'
WHEN p.SKU='PANEL_AL_FR_24X36' THEN '24X36 Framed Metal Print'
WHEN p.SKU='11DIPFKCWR_4030' THEN 'Diptych 40x30 Framed Canvas'
WHEN p.SKU='11TRIFKCWR_4830' THEN 'Triptych 48x30 Framed Canvas'
WHEN p.SKU='25OZ_MUG_CAFE_2PK' THEN '25oz Mug (2-pack)'
ELSE p.RetailerProductBaseName
END AS RetailerProductName,
p.retailerProductName AS ItemName,
p.SKU AS PNIProductSKU,
p.Tags AS Tag,
p.ProductCode AS ProductCode,
p.DesignCode AS DesignCode,
p.DesignerID AS DesignerID,
p.Size AS ProductSize,
p.Orientation AS Orientation,
p.NoOfSurfaces AS Surfaces,
p.IsCreateYourOwn AS IsCreateYourOwn,
pay.PaymentMethod AS PaymentMethod,
p.ProductOptions AS ProductOptions,
--ISNULL(sl.orderStatus,'Complete') AS Status,
vn.vendor AS Vendor




FROM 


PROD_BRONZE_DB.RETAIL_DATA.factOrder as f
INNER JOIN PROD_BRONZE_DB.RETAIL_DATA.dimProduct as p
ON f.dim_product_id = p.dim_product_id
INNER JOIN PROD_BRONZE_DB.RETAIL_DATA.dimRetailer AS r
on f.dim_retailer_id = r.dim_retailer_id
INNER JOIN PROD_BRONZE_DB.RETAIL_DATA.dimPromo as pr
ON f.dim_promo_id = pr.dim_promo_id
INNER JOIN PROD_BRONZE_DB.RETAIL_DATA.dimApplication AS app
ON f.dim_app_id = app.dim_app_id
INNER JOIN PROD_BRONZE_DB.RETAIL_DATA.dimDestination as d
ON f.dim_dest_id = d.dim_dest_id
INNER JOIN PROD_BRONZE_DB.RETAIL_DATA.dimPayment as pay
ON f.dim_payment_id = pay.dim_payment_id
INNER JOIN PROD_BRONZE_DB.RETAIL_DATA.dimDate as dt
ON f.checkoutdate_id = dt.dim_date_ID
INNER JOIN PROD_BRONZE_DB.RETAIL_DATA.dimShipping as sh
ON f.dim_shipping_id = sh.dim_shipping_id
INNER JOIN PROD_BRONZE_DB.RETAIL_DATA.dimDelivery as del
ON f.dim_delivery_id = del.dim_delivery_id
INNER JOIN PROD_BRONZE_DB.MASTER_DATA.dimRDate as rdt
on dt.dim_date_ID = rdt.dim_date_id and f.retailerID = rdt.RetailerID
INNER JOIN PROD_BRONZE_DB.RETAIL_DATA.dimVendor as vn
ON f.dim_vendor_id = vn.dim_vendor_id
LEFT JOIN PROD_BRONZE_DB.RETAIL_DATA.Hexmap as H
ON d.state_abbrev = H.Abbreviation_H
--LEFT JOIN  PROD_BRONZE_DB.RETAIL_DATA.dimInCompletedSubOrderStatus st
--ON f.retailerID=st.retailerid and f.orderID=st.orderid and f.subOrderID=st.suborderid
--LEFT JOIN PROD_BRONZE_DB.RETAIL_DATA.RPT_TestUser as test on f.retailerID=test.retailerid and f.userID=test.userid
--LEFT JOIN PROD_BRONZE_DB.RETAIL_DATA.dimStatus as sl on st.orderstatusid =sl.orderStatusID AND sl.retailerID =2



WHERE f.retailerID = 2
AND ISNULL(f.isTest,0)=0
--and isnull(test.userid,0) =0
AND f.fact_id != 224811775
AND CONVERT(date,f.checkoutDateTime) >= '2019-01-01'
AND p.PNIProductTypeName != 'Business Products'
AND p.RetailerProductBaseName != 'Stationery Card Envelopes' -- Remove envelopes and VAC in cards
AND p.RetailerProductBaseName != '6x7.5 Photo Cards VAC'
and p.RetailerProductBaseName != '5x7 Envelopes')

UNION ALL


(SELECT 

f.fact_id AS FactID,
f.baseItemTotal AS BaseRevenue,
f.itemTotal AS Revenue,
f.discountTotal AS Discount,
f.quantity AS Units,
f.orderID as OrderID,
f.subOrderID AS SubOrderID,
f.allocatedShippingFee As ShippingFee,
f.userID AS UserID,
ISNULL(f.ExternalOrderID, f.orderID) as ExternalOrderID,
dt.Date AS 'Calendar Date',
dt.Year AS 'Calendar Year',
dt.Month AS 'Calendar Month',
dt.WeekOfYear AS 'Calendar Week of Year',
dt.DayOfYear AS 'Calendar Day of Year',
dt.DayOfWeek AS 'Calendar Day of Week',
CASE 
WHEN f.isRIK = 1 THEN 'RIK'
WHEN f.isRIK =0 THEN 'NON_RIK'
ELSE 'NON_RIK'
END AS isRIK,
IIF(ISNULL(f.isResubmit,0) = 0, 'Not-Resubmitted', 'Resubmitted') AS IsResubmitted,
ISNULL(f.isResubmit,0) AS ResubmittedFlag,
pr.promoCode AS PromoCode,
pr.Description AS PromoDescription,
sh.shippingMethod AS ShippingMethod,
sh.ShippingType AS ShippingType,
del.deliveryCategory AS DeliveryCategory,
'Staples Doc Printing (Hercules)' AS Retailer,
app.appType AS AppType,
app.appContextID AS AppContext,
app.mobileOS AS MobileOS,
d.state_abbrev AS 'StateAbb',
d.country_abbrev as 'CountryAbb',
d.city as 'City',
d.zip as 'Zip',
H.Row_H AS Row_H,
H.Column_H AS Column_H,
H.State_H AS State_H,
H.Abbreviation_H AS Abbreviation_H,
'Document Print' AS Category,

CASE 
WHEN p.SKU ='PNI_DocumentPrints_SimplePrints_SameDay' THEN 'Simple Prints'
WHEN p.SKU ='PNI_DocumentPrints_SimplePrints' THEN 'Simple Prints'
WHEN p.SKU ='PNI_DocumentPrints_Resumes_SameDay' THEN 'Resumes'
WHEN p.SKU ='PNI_DocumentPrints_Resumes' THEN 'Resumes'
WHEN p.SKU ='PNI_DocumentPrints_PresentationsManuals_SameDay' THEN 'Presentations & Manuals'
WHEN p.SKU ='PNI_DocumentPrints_PresentationsManuals' THEN 'Presentations & Manuals'
WHEN p.SKU ='PNI_DocumentPrints_Newsletters_SameDay' THEN 'Newsletters'
WHEN p.SKU ='PNI_DocumentPrints_Newsletters' THEN 'Newsletters'
WHEN p.SKU ='PNI_DocumentPrints_SellSheets_SameDay' THEN 'Sell Sheets'
WHEN p.SKU ='PNI_DocumentPrints_SellSheets' THEN 'Sell Sheets'
WHEN p.SKU ='PNI_DocumentPrints_Blueprints_SameDay' THEN 'Blueprints'
WHEN p.SKU ='PNI_DocumentPrints_Blueprints' THEN 'Blueprints'
WHEN p.SKU='PNI_DocumentPrints_Booklets' THEN 'Booklets'
WHEN p.SKU='PNI_DocumentPrints_Booklets_SameDay' THEN 'Booklets'
END as SubCategory,

p.RetailerProductBaseName AS RetailerProductName,
p.retailerProductName AS ItemName,
p.SKU AS PNIProductSKU,
p.Tags AS Tag,
p.ProductCode AS ProductCode,
p.DesignCode AS DesignCode,
p.DesignerID AS DesignerID,
p.Size AS ProductSize,
p.Orientation AS Orientation,
p.NoOfSurfaces AS Surfaces,
p.IsCreateYourOwn AS IsCreateYourOwn,
pay.PaymentMethod AS PaymentMethod,
p.ProductOptions AS ProductOptions,
--ISNULL(sl.orderStatus,'Complete') AS Status,
'N/A' AS Vendor




FROM 


PROD_BRONZE_DB.RETAIL_DATA.factOrder as f
INNER JOIN PROD_BRONZE_DB.RETAIL_DATA.dimProduct as p
ON f.dim_product_id = p.dim_product_id
INNER JOIN PROD_BRONZE_DB.RETAIL_DATA.dimRetailer AS r
on f.dim_retailer_id = r.dim_retailer_id
INNER JOIN PROD_BRONZE_DB.RETAIL_DATA.dimPromo as pr
ON f.dim_promo_id = pr.dim_promo_id
INNER JOIN PROD_BRONZE_DB.RETAIL_DATA.dimApplication AS app
ON f.dim_app_id = app.dim_app_id
INNER JOIN PROD_BRONZE_DB.RETAIL_DATA.dimDestination as d
ON f.dim_dest_id = d.dim_dest_id
INNER JOIN PROD_BRONZE_DB.RETAIL_DATA.dimPayment as pay
ON f.dim_payment_id = pay.dim_payment_id
INNER JOIN PROD_BRONZE_DB.RETAIL_DATA.dimDate as dt
ON f.checkoutdate_id = dt.dim_date_ID
INNER JOIN PROD_BRONZE_DB.RETAIL_DATA.dimShipping as sh
ON f.dim_shipping_id = sh.dim_shipping_id
INNER JOIN PROD_BRONZE_DB.RETAIL_DATA.dimDelivery as del
ON f.dim_delivery_id = del.dim_delivery_id
INNER JOIN PROD_BRONZE_DB.MASTER_DATA.dimRDate as rdt
on dt.dim_date_ID = rdt.dim_date_id and f.retailerID = rdt.RetailerID
LEFT JOIN PROD_BRONZE_DB.RETAIL_DATA.Hexmap as H
ON d.state_abbrev = H.Abbreviation_H
--LEFT JOIN  PROD_BRONZE_DB.RETAIL_DATA.dimInCompletedSubOrderStatus st
--ON f.retailerID=st.retailerid and f.orderID=st.orderid and f.subOrderID=st.suborderid
--LEFT JOIN PROD_BRONZE_DB.RETAIL_DATA.RPT_TestUser as test on f.retailerID=test.retailerid and f.userID=test.userid
--LEFT JOIN PROD_BRONZE_DB.RETAIL_DATA.dimStatus as sl on st.orderstatusid =sl.orderStatusID AND sl.retailerID =50


WHERE f.retailerID = 50
AND ISNULL(f.isTest,0)=0
AND isnull(f.isRIK, 0) = 0 
--and isnull(test.userid,0) =0
AND f.fact_id != 224811775
AND f.orderID != 363133057
AND CONVERT(date,f.checkoutDateTime) >= '2019-05-05'
AND app.appContextID != 11945004
AND p.SKU IN ('PNI_DocumentPrints_SimplePrints_SameDay',
	'PNI_DocumentPrints_Resumes',
	'PNI_DocumentPrints_Resumes_SameDay',
	'PNI_DocumentPrints_PresentationsManuals_SameDay',
	'PNI_DocumentPrints_Newsletters_SameDay',
	'PNI_DocumentPrints_SellSheets_SameDay',
	'PNI_DocumentPrints_Blueprints',
	'PNI_DocumentPrints_Blueprints_SameDay',
	'PNI_DocumentPrints_PresentationsManuals',
	'PNI_DocumentPrints_SellSheets',
	'PNI_DocumentPrints_Newsletters',
	'PNI_DocumentPrints_SimplePrints',
	'PNI_DocumentPrints_Booklets',
	'PNI_DocumentPrints_Booklets_SameDay'))) AS Retailers


LEFT JOIN 

(SELECT 

rdt.RYear AS 'Staples Year',
rdt.RWeekOfYear AS 'Staples Week',
rdt.RPeriod AS 'Staples Period',
rdt.RWeekOfPeriod AS 'Staples Week of Period',
rdt.RDayOfYear AS 'Staples Day of Year',
rdt.RQuarter AS 'Staples Quarter',
rdt.Date AS 'Date'


FROM PROD_BRONZE_DB.MASTER_DATA.dimRDate rdt

where rdt.RetailerID = 50
AND rdt.RYear > 2017) AS RDate

ON Retailers.Calendar Date=RDate.Date

LEFT JOIN 

(SELECT 

rdt_cos.RYear AS 'Costco Year',
rdt_cos.RWeekOfYear AS 'Costco Week',
rdt_cos.RPeriod AS 'Costco Period',
rdt_cos.RWeekOfPeriod AS 'Costco Week of Period',
rdt_cos.RDayOfYear AS 'Costco Day of Year',
rdt_cos.RQuarter AS 'Costco Quarter',
rdt_cos.Date AS 'Date_Calendar'


FROM PROD_BRONZE_DB.MASTER_DATA.dimRDate rdt_cos

where rdt_cos.RetailerID = 27
AND rdt_cos.RYear > 2017) AS CostcoFiscal

ON Retailers.Calendar Date=CostcoFiscal.Date_Calendar

LEFT JOIN 

(SELECT 

rdt_sam.RYear AS SAMS Year,
rdt_sam.RWeekOfYear AS SAMS Week,
rdt_sam.RPeriod AS SAMS Period,
rdt_sam.RDayOfYear AS SAMS Day of Year,
rdt_sam.RQuarter AS SAMS Quarter,
rdt_sam.Date AS Date_Calendar_S


FROM PROD_BRONZE_DB.MASTER_DATA.dimRDate rdt_sam

where rdt_sam.RetailerID = 26
AND rdt_sam.RYear > 2017) AS SAMSFiscal

ON Retailers.Calendar Date = SAMSFiscal.Date_Calendar_S

LEFT JOIN 

PII_Lookup_SamsUS.RETAIL_DATA.SamsclubUs_user as Sams_Users
on Sams_Users.userid = Retailers.UserID and Retailers.Retailer in ('SAMS', 'SAMS BP')








CREATE VIEW RETAIL_DATA.vDailyKPIReport
AS


SELECT 

Retailers.*,
RDate.Staples Day of Year,
RDate.Staples Period,
RDate.Staples Quarter,
RDate.Staples Week,
RDate.Staples Week of Period,
RDate.Staples Year



FROM 


((SELECT 

f.baseItemTotal AS BaseRevenue,
f.itemTotal AS Revenue,
f.discountTotal AS Discount,
f.quantity AS Units,
f.orderID as OrderID,
f.subOrderID AS SubOrderID,
f.allocatedShippingFee As ShippingFee,
f.userID AS UserID,
ISNULL(f.ExternalOrderID, f.orderID) as ExternalOrderID,
dt.Date AS 'Calendar Date',
dt.Year AS 'Calendar Year',
dt.Month AS 'Calendar Month',
dt.WeekOfYear AS 'Calendar Week of Year',
dt.DayOfYear AS 'Calendar Day of Year',
dt.DayOfWeek AS 'Calendar Day of Week',
CASE 
WHEN f.isRIK = 1 THEN 'RIK'
WHEN f.isRIK =0 THEN 'NON_RIK'
ELSE 'NON_RIK'
END AS isRIK,
IIF(ISNULL(f.isResubmit,0) = 0, 'Not-Resubmitted', 'Resubmitted') AS IsResubmitted,
ISNULL(f.isResubmit,0) AS ResubmittedFlag,
pr.promoCode AS PromoCode,
pr.Description AS PromoDescription,
sh.shippingMethod AS ShippingMethod,
sh.ShippingType AS ShippingType,
del.deliveryCategory AS DeliveryCategory,
'Costco US' AS Retailer,
app.appType AS AppType,
app.appContextID AS AppContext,
app.mobileOS AS MobileOS,
d.state_abbrev AS 'StateAbb',
d.country_abbrev as 'CountryAbb',
d.city as 'City',
d.zip as 'Zip',
H.Row_H AS Row_H,
H.Column_H AS Column_H,
H.State_H AS State_H,
H.Abbreviation_H AS Abbreviation_H
--ISNULL(sl.orderStatus,'Complete') AS Status



FROM 


PROD_BRONZE_DB.RETAIL_DATA.factOrder as f
INNER JOIN PROD_BRONZE_DB.RETAIL_DATA.dimProduct as p
ON f.dim_product_id = p.dim_product_id
INNER JOIN PROD_BRONZE_DB.RETAIL_DATA.dimRetailer AS r
on f.dim_retailer_id = r.dim_retailer_id
INNER JOIN PROD_BRONZE_DB.RETAIL_DATA.dimPromo as pr
ON f.dim_promo_id = pr.dim_promo_id
INNER JOIN PROD_BRONZE_DB.RETAIL_DATA.dimApplication AS app
ON f.dim_app_id = app.dim_app_id
INNER JOIN PROD_BRONZE_DB.RETAIL_DATA.dimDestination as d
ON f.dim_dest_id = d.dim_dest_id
INNER JOIN PROD_BRONZE_DB.RETAIL_DATA.dimPayment as pay
ON f.dim_payment_id = pay.dim_payment_id
INNER JOIN PROD_BRONZE_DB.RETAIL_DATA.dimDate as dt
ON f.checkoutdate_id = dt.dim_date_ID
INNER JOIN PROD_BRONZE_DB.RETAIL_DATA.dimShipping as sh
ON f.dim_shipping_id = sh.dim_shipping_id
INNER JOIN PROD_BRONZE_DB.RETAIL_DATA.dimDelivery as del
ON f.dim_delivery_id = del.dim_delivery_id
INNER JOIN PROD_BRONZE_DB.MASTER_DATA.dimRDate as rdt
on dt.dim_date_ID = rdt.dim_date_id and f.retailerID = rdt.RetailerID
LEFT JOIN PROD_BRONZE_DB.RETAIL_DATA.Hexmap as H
ON d.state_abbrev = H.Abbreviation_H
LEFT JOIN PROD_BRONZE_DB.RETAIL_DATA.dimUser as us
ON f.dim_user_id=us.dim_user_id
--LEFT JOIN  PROD_BRONZE_DB.RETAIL_DATA.dimInCompletedSubOrderStatus st
--ON f.retailerID=st.retailerid and f.orderID=st.orderid and f.subOrderID=st.suborderid
--LEFT JOIN PROD_BRONZE_DB.RETAIL_DATA.RPT_TestUser as test on f.retailerID=test.retailerid and f.userID=test.userid
--LEFT JOIN PROD_BRONZE_DB.RETAIL_DATA.dimStatus as sl on st.orderstatusid =sl.orderStatusID AND sl.retailerID =27

WHERE f.retailerID = 27
AND ISNULL(f.isTest,0)=0
--and isnull(test.userid,0) =0
AND f.fact_id != 224811775
AND CONVERT(date,f.checkoutDateTime) >= '2019-02-03'
AND p.PNIProductTypeName != 'Business Products'
AND p.RetailerProductBaseName != 'Stationery Card Envelopes' -- Remove envelopes and VAC in cards
AND p.RetailerProductBaseName != '6x7.5 Photo Cards VAC'
AND p.SKU NOT IN ( 
'6x75_L_N_25',
'16x20_B_P_COMM',
'20x30_B_P_COMM',
'134',
'135',
'2061',
'2563',
'2564',
'2565',
'2571',
'2575',
'NB_1',
'Notepad_14',
'NP_2',
'NP_81',
'S_1',
'S_19',
'S_23',
'S_56',
'S_58'))

UNION ALL 


(SELECT 

f.baseItemTotal AS BaseRevenue,
f.itemTotal AS Revenue,
f.discountTotal AS Discount,
f.quantity AS Units,
f.orderID as OrderID,
f.subOrderID AS SubOrderID,
f.allocatedShippingFee As ShippingFee,
f.userID AS UserID,
ISNULL(f.ExternalOrderID, f.orderID) as ExternalOrderID,
dt.Date AS 'Calendar Date',
dt.Year AS 'Calendar Year',
dt.Month AS 'Calendar Month',
dt.WeekOfYear AS 'Calendar Week of Year',
dt.DayOfYear AS 'Calendar Day of Year',
dt.DayOfWeek AS 'Calendar Day of Week',
CASE 
WHEN f.isRIK = 1 THEN 'RIK'
WHEN f.isRIK =0 THEN 'NON_RIK'
ELSE 'NON_RIK'
END AS isRIK,
IIF(ISNULL(f.isResubmit,0) = 0, 'Not-Resubmitted', 'Resubmitted') AS IsResubmitted,
ISNULL(f.isResubmit,0) AS ResubmittedFlag,
pr.promoCode AS PromoCode,
pr.Description AS PromoDescription,
sh.shippingMethod AS ShippingMethod,
sh.ShippingType AS ShippingType,
del.deliveryCategory AS DeliveryCategory,
'Costco BP' AS Retailer,
app.appType AS AppType,
app.appContextID AS AppContext,
app.mobileOS AS MobileOS,
d.state_abbrev AS 'StateAbb',
d.country_abbrev as 'CountryAbb',
d.city as 'City',
d.zip as 'Zip',
H.Row_H AS Row_H,
H.Column_H AS Column_H,
H.State_H AS State_H,
H.Abbreviation_H AS Abbreviation_H
--ISNULL(sl.orderStatus,'Complete') AS Status



FROM 


PROD_BRONZE_DB.RETAIL_DATA.factOrder as f
INNER JOIN PROD_BRONZE_DB.RETAIL_DATA.dimProduct as p
ON f.dim_product_id = p.dim_product_id
INNER JOIN PROD_BRONZE_DB.RETAIL_DATA.dimRetailer AS r
on f.dim_retailer_id = r.dim_retailer_id
INNER JOIN PROD_BRONZE_DB.RETAIL_DATA.dimPromo as pr
ON f.dim_promo_id = pr.dim_promo_id
INNER JOIN PROD_BRONZE_DB.RETAIL_DATA.dimApplication AS app
ON f.dim_app_id = app.dim_app_id
INNER JOIN PROD_BRONZE_DB.RETAIL_DATA.dimDestination as d
ON f.dim_dest_id = d.dim_dest_id
INNER JOIN PROD_BRONZE_DB.RETAIL_DATA.dimPayment as pay
ON f.dim_payment_id = pay.dim_payment_id
INNER JOIN PROD_BRONZE_DB.RETAIL_DATA.dimDate as dt
ON f.checkoutdate_id = dt.dim_date_ID
INNER JOIN PROD_BRONZE_DB.RETAIL_DATA.dimShipping as sh
ON f.dim_shipping_id = sh.dim_shipping_id
INNER JOIN PROD_BRONZE_DB.RETAIL_DATA.dimDelivery as del
ON f.dim_delivery_id = del.dim_delivery_id
INNER JOIN PROD_BRONZE_DB.MASTER_DATA.dimRDate as rdt
on dt.dim_date_ID = rdt.dim_date_id and f.retailerID = rdt.RetailerID
LEFT JOIN PROD_BRONZE_DB.RETAIL_DATA.Hexmap as H
ON d.state_abbrev = H.Abbreviation_H
LEFT JOIN PROD_BRONZE_DB.RETAIL_DATA.dimUser as us
ON f.dim_user_id=us.dim_user_id
--LEFT JOIN  PROD_BRONZE_DB.RETAIL_DATA.dimInCompletedSubOrderStatus st
--ON f.retailerID=st.retailerid and f.orderID=st.orderid and f.subOrderID=st.suborderid
--LEFT JOIN PROD_BRONZE_DB.RETAIL_DATA.RPT_TestUser as test on f.retailerID=test.retailerid and f.userID=test.userid
--LEFT JOIN PROD_BRONZE_DB.RETAIL_DATA.dimStatus as sl on st.orderstatusid =sl.orderStatusID AND sl.retailerID =27

WHERE f.retailerID = 27
AND ISNULL(f.isTest,0)=0
--and isnull(test.userid,0) =0
AND f.fact_id != 224811775
AND f.orderID != 363133057
AND CONVERT(date,f.checkoutDateTime) >= '2019-02-03'
AND p.PNIProductTypeName = 'Business Products'
)

UNION ALL 


(SELECT 

f.baseItemTotal AS BaseRevenue,
f.itemTotal AS Revenue,
f.discountTotal AS Discount,
f.quantity AS Units,
f.orderID as OrderID,
f.subOrderID AS SubOrderID,
f.allocatedShippingFee As ShippingFee,
f.userID AS UserID,
ISNULL(f.ExternalOrderID, f.orderID) as ExternalOrderID,
dt.Date AS 'Calendar Date',
dt.Year AS 'Calendar Year',
dt.Month AS 'Calendar Month',
dt.WeekOfYear AS 'Calendar Week of Year',
dt.DayOfYear AS 'Calendar Day of Year',
dt.DayOfWeek AS 'Calendar Day of Week',
CASE 
WHEN f.isRIK = 1 THEN 'RIK'
WHEN f.isRIK =0 THEN 'NON_RIK'
ELSE 'NON_RIK'
END AS isRIK,
IIF(ISNULL(f.isResubmit,0) = 0, 'Not-Resubmitted', 'Resubmitted') AS IsResubmitted,
ISNULL(f.isResubmit,0) AS ResubmittedFlag,
pr.promoCode AS PromoCode,
pr.Description AS PromoDescription,
sh.shippingMethod AS ShippingMethod,
sh.ShippingType AS ShippingType,
del.deliveryCategory AS DeliveryCategory,
'SAMS BP' AS Retailer,
app.appType AS AppType,
app.appContextID AS AppContext,
app.mobileOS AS MobileOS,
d.state_abbrev AS 'StateAbb',
d.country_abbrev as 'CountryAbb',
d.city as 'City',
d.zip as 'Zip',
H.Row_H AS Row_H,
H.Column_H AS Column_H,
H.State_H AS State_H,
H.Abbreviation_H AS Abbreviation_H
--ISNULL(sl.orderStatus,'Complete') AS Status



FROM 


PROD_BRONZE_DB.RETAIL_DATA.factOrder as f
INNER JOIN PROD_BRONZE_DB.RETAIL_DATA.dimProduct as p
ON f.dim_product_id = p.dim_product_id
INNER JOIN PROD_BRONZE_DB.RETAIL_DATA.dimRetailer AS r
on f.dim_retailer_id = r.dim_retailer_id
INNER JOIN PROD_BRONZE_DB.RETAIL_DATA.dimPromo as pr
ON f.dim_promo_id = pr.dim_promo_id
INNER JOIN PROD_BRONZE_DB.RETAIL_DATA.dimApplication AS app
ON f.dim_app_id = app.dim_app_id
INNER JOIN PROD_BRONZE_DB.RETAIL_DATA.dimDestination as d
ON f.dim_dest_id = d.dim_dest_id
INNER JOIN PROD_BRONZE_DB.RETAIL_DATA.dimPayment as pay
ON f.dim_payment_id = pay.dim_payment_id
INNER JOIN PROD_BRONZE_DB.RETAIL_DATA.dimDate as dt
ON f.checkoutdate_id = dt.dim_date_ID
INNER JOIN PROD_BRONZE_DB.RETAIL_DATA.dimShipping as sh
ON f.dim_shipping_id = sh.dim_shipping_id
INNER JOIN PROD_BRONZE_DB.RETAIL_DATA.dimDelivery as del
ON f.dim_delivery_id = del.dim_delivery_id
INNER JOIN PROD_BRONZE_DB.MASTER_DATA.dimRDate as rdt
on dt.dim_date_ID = rdt.dim_date_id and f.retailerID = rdt.RetailerID
LEFT JOIN PROD_BRONZE_DB.RETAIL_DATA.Hexmap as H
ON d.state_abbrev = H.Abbreviation_H
LEFT JOIN PROD_BRONZE_DB.RETAIL_DATA.dimUser as us
ON f.dim_user_id=us.dim_user_id
--LEFT JOIN  PROD_BRONZE_DB.RETAIL_DATA.dimInCompletedSubOrderStatus st
--ON f.retailerID=st.retailerid and f.orderID=st.orderid and f.subOrderID=st.suborderid
--LEFT JOIN PROD_BRONZE_DB.RETAIL_DATA.RPT_TestUser as test on f.retailerID=test.retailerid and f.userID=test.userid
--LEFT JOIN PROD_BRONZE_DB.RETAIL_DATA.dimStatus as sl on st.orderstatusid =sl.orderStatusID AND sl.retailerID =26



WHERE f.retailerID = 26
AND ISNULL(f.isTest,0)=0
--and isnull(test.userid,0) =0
AND f.fact_id != 224811775
--AND f.orderID != 363133057
AND CONVERT(date,f.checkoutDateTime) >= '2019-02-03'
AND p.PNIProductTypeName = 'Business Products')

UNION  ALL 

(SELECT 

f.baseItemTotal AS BaseRevenue,
f.itemTotal AS Revenue,
f.discountTotal AS Discount,
f.quantity AS Units,
f.orderID as OrderID,
f.subOrderID AS SubOrderID,
f.allocatedShippingFee As ShippingFee,
f.userID AS UserID,
ISNULL(f.ExternalOrderID, f.orderID) as ExternalOrderID,
dt.Date AS 'Calendar Date',
dt.Year AS 'Calendar Year',
dt.Month AS 'Calendar Month',
dt.WeekOfYear AS 'Calendar Week of Year',
dt.DayOfYear AS 'Calendar Day of Year',
dt.DayOfWeek AS 'Calendar Day of Week',
CASE 
WHEN f.isRIK = 1 THEN 'RIK'
WHEN f.isRIK =0 THEN 'NON_RIK'
ELSE 'NON_RIK'
END AS isRIK,
IIF(ISNULL(f.isResubmit,0) = 0, 'Not-Resubmitted', 'Resubmitted') AS IsResubmitted,
ISNULL(f.isResubmit,0) AS ResubmittedFlag,
pr.promoCode AS PromoCode,
pr.Description AS PromoDescription,
sh.shippingMethod AS ShippingMethod,
sh.ShippingType AS ShippingType,
del.deliveryCategory AS DeliveryCategory,
'SAMS' AS Retailer,
app.appType AS AppType,
app.appContextID AS AppContext,
app.mobileOS AS MobileOS,
d.state_abbrev AS 'StateAbb',
d.country_abbrev as 'CountryAbb',
d.city as 'City',
d.zip as 'Zip',
H.Row_H AS Row_H,
H.Column_H AS Column_H,
H.State_H AS State_H,
H.Abbreviation_H AS Abbreviation_H
--ISNULL(sl.orderStatus,'Complete') AS Status




FROM 


PROD_BRONZE_DB.RETAIL_DATA.factOrder as f
INNER JOIN PROD_BRONZE_DB.RETAIL_DATA.dimProduct as p
ON f.dim_product_id = p.dim_product_id
INNER JOIN PROD_BRONZE_DB.RETAIL_DATA.dimRetailer AS r
on f.dim_retailer_id = r.dim_retailer_id
INNER JOIN PROD_BRONZE_DB.RETAIL_DATA.dimPromo as pr
ON f.dim_promo_id = pr.dim_promo_id
INNER JOIN PROD_BRONZE_DB.RETAIL_DATA.dimApplication AS app
ON f.dim_app_id = app.dim_app_id
INNER JOIN PROD_BRONZE_DB.RETAIL_DATA.dimDestination as d
ON f.dim_dest_id = d.dim_dest_id
INNER JOIN PROD_BRONZE_DB.RETAIL_DATA.dimPayment as pay
ON f.dim_payment_id = pay.dim_payment_id
INNER JOIN PROD_BRONZE_DB.RETAIL_DATA.dimDate as dt
ON f.checkoutdate_id = dt.dim_date_ID
INNER JOIN PROD_BRONZE_DB.RETAIL_DATA.dimShipping as sh
ON f.dim_shipping_id = sh.dim_shipping_id
INNER JOIN PROD_BRONZE_DB.RETAIL_DATA.dimDelivery as del
ON f.dim_delivery_id = del.dim_delivery_id
INNER JOIN PROD_BRONZE_DB.MASTER_DATA.dimRDate as rdt
on dt.dim_date_ID = rdt.dim_date_id and f.retailerID = rdt.RetailerID
LEFT JOIN PROD_BRONZE_DB.RETAIL_DATA.Hexmap as H
ON d.state_abbrev = H.Abbreviation_H
LEFT JOIN PROD_BRONZE_DB.RETAIL_DATA.dimUser as us
ON f.dim_user_id=us.dim_user_id
--LEFT JOIN  PROD_BRONZE_DB.RETAIL_DATA.dimInCompletedSubOrderStatus st
--ON f.retailerID=st.retailerid and f.orderID=st.orderid and f.subOrderID=st.suborderid
--LEFT JOIN PROD_BRONZE_DB.RETAIL_DATA.RPT_TestUser as test on f.retailerID=test.retailerid and f.userID=test.userid
--LEFT JOIN PROD_BRONZE_DB.RETAIL_DATA.dimStatus as sl on st.orderstatusid =sl.orderStatusID AND sl.retailerID =26

WHERE f.retailerID = 26
AND ISNULL(f.isTest,0)=0
--and isnull(test.userid,0) =0
AND f.fact_id != 224811775
--AND f.orderID != 363133057
AND CONVERT(date,f.checkoutDateTime) >= '2019-02-03'
AND p.PNIProductTypeName != 'Business Products')

UNION ALL 

( SELECT

rn.BaseRevenue AS BaseRevenue,
rn.Revenue AS Revenue,
rn.DiscountAmount AS Discount,
rn.Units AS Units,
rn.OrderID AS OrderID,
rn.SubOrderID AS SubOrderID,
rn.ShippingFee AS ShippingFee,
rn.UserID AS UserID,
rn.ExternalOrderID AS ExternalOrderID,
rn.Date AS 'Calendar Date',
rn.CalendarYear AS 'Calendar Year',
rn.CalendarMonth AS 'Calendar Month',
rn.CalendarWeek AS 'Calendar Week of Year',
rn.CalendarDayOfYear AS 'Calendar Day of Year',
rn.DayOfWeek AS 'Calendar Day of Week',
rn.Rik_Classified AS isRIK,
rn.IsResubmitted AS IsResubmitted,
rn.ResubmittedFlag AS ResubmittedFlag,
rn.PromoCode AS PromoCode,
rn.PromoDesc AS PromoDescription,
rn.Shipping_Method AS ShippingMethod,
rn.ShippingType AS ShippingType,
rn.Delivery_Category AS DeliveryCategory,
'Staples US' AS Retailer,
rn.AppType AS AppType,
rn.AppContextID AS AppContext,
rn.MobileOS AS MobileOS,
rn.State AS StateAbb,
rn.Country as CountryAbb,
rn.City AS City,
rn.ZipCode as Zip,
rn.Row_H as Row_H,
rn.Column_H as Column_H,
rn.State_H AS State_H,
rn.Abbreviation_H as	Abbreviation_H 
--rn.Status




FROM PROD_BRONZE_DB.RETAIL_DATA.vSPLUS_RIKvsNONRIK_Herc_exl as rn

WHERE rn.Date >= '2019-02-03')

UNION ALL 

(SELECT 

f.baseItemTotal AS BaseRevenue,
f.itemTotal AS Revenue,
f.discountTotal AS Discount,
f.quantity AS Units,
f.orderID as OrderID,
f.subOrderID AS SubOrderID,
f.allocatedShippingFee As ShippingFee,
f.userID AS UserID,
ISNULL(f.ExternalOrderID, f.orderID) as ExternalOrderID,
dt.Date AS 'Calendar Date',
dt.Year AS 'Calendar Year',
dt.Month AS 'Calendar Month',
dt.WeekOfYear AS 'Calendar Week of Year',
dt.DayOfYear AS 'Calendar Day of Year',
dt.DayOfWeek AS 'Calendar Day of Week',
CASE 
WHEN f.isRIK = 1 THEN 'RIK'
WHEN f.isRIK =0 THEN 'NON_RIK'
ELSE 'NON_RIK'
END AS isRIK,
IIF(ISNULL(f.isResubmit,0) = 0, 'Not-Resubmitted', 'Resubmitted') AS IsResubmitted,
ISNULL(f.isResubmit,0) AS ResubmittedFlag,
pr.promoCode AS PromoCode,
pr.Description AS PromoDescription,
sh.shippingMethod AS ShippingMethod,
sh.ShippingType AS ShippingType,
del.deliveryCategory AS DeliveryCategory,
'Staples US Business Printing' AS Retailer,
app.appType AS AppType,
app.appContextID AS AppContext,
app.mobileOS AS MobileOS,
d.state_abbrev AS 'StateAbb',
d.country_abbrev as 'CountryAbb',
d.city as 'City',
d.zip as 'Zip',
H.Row_H AS Row_H,
H.Column_H AS Column_H,
H.State_H AS State_H,
H.Abbreviation_H AS Abbreviation_H
--ISNULL(sl.orderStatus,'Complete') AS Status



FROM 


PROD_BRONZE_DB.RETAIL_DATA.factOrder as f
INNER JOIN PROD_BRONZE_DB.RETAIL_DATA.dimProduct as p
ON f.dim_product_id = p.dim_product_id
INNER JOIN PROD_BRONZE_DB.RETAIL_DATA.dimRetailer AS r
on f.dim_retailer_id = r.dim_retailer_id
INNER JOIN PROD_BRONZE_DB.RETAIL_DATA.dimPromo as pr
ON f.dim_promo_id = pr.dim_promo_id
INNER JOIN PROD_BRONZE_DB.RETAIL_DATA.dimApplication AS app
ON f.dim_app_id = app.dim_app_id
INNER JOIN PROD_BRONZE_DB.RETAIL_DATA.dimDestination as d
ON f.dim_dest_id = d.dim_dest_id
INNER JOIN PROD_BRONZE_DB.RETAIL_DATA.dimPayment as pay
ON f.dim_payment_id = pay.dim_payment_id
INNER JOIN PROD_BRONZE_DB.RETAIL_DATA.dimDate as dt
ON f.checkoutdate_id = dt.dim_date_ID
INNER JOIN PROD_BRONZE_DB.RETAIL_DATA.dimShipping as sh
ON f.dim_shipping_id = sh.dim_shipping_id
INNER JOIN PROD_BRONZE_DB.RETAIL_DATA.dimDelivery as del
ON f.dim_delivery_id = del.dim_delivery_id
INNER JOIN PROD_BRONZE_DB.MASTER_DATA.dimRDate as rdt
on dt.dim_date_ID = rdt.dim_date_id and f.retailerID = rdt.RetailerID
LEFT JOIN PROD_BRONZE_DB.RETAIL_DATA.Hexmap as H
ON d.state_abbrev = H.Abbreviation_H
LEFT JOIN PROD_BRONZE_DB.RETAIL_DATA.dimUser as us
ON f.dim_user_id=us.dim_user_id
--LEFT JOIN  PROD_BRONZE_DB.RETAIL_DATA.dimInCompletedSubOrderStatus st
--ON f.retailerID=st.retailerid and f.orderID=st.orderid and f.subOrderID=st.suborderid
--LEFT JOIN PROD_BRONZE_DB.RETAIL_DATA.RPT_TestUser as test on f.retailerID=test.retailerid and f.userID=test.userid
--LEFT JOIN PROD_BRONZE_DB.RETAIL_DATA.dimStatus as sl on st.orderstatusid =sl.orderStatusID AND sl.retailerID =50


WHERE f.retailerID = 50
AND ISNULL(f.isTest,0)=0
--and isnull(test.userid,0) =0
AND isnull(f.isRIK, 0) = 0 
AND f.fact_id != 224811775
AND f.orderID != 363133057
AND CONVERT(date,f.checkoutDateTime) >= '2019-02-03'
AND app.appContextID != 11945004
AND p.SKU IN ('PNI_DocumentPrints_SimplePrints_SameDay',
	'PNI_DocumentPrints_Resumes',
	'PNI_DocumentPrints_Resumes_SameDay',
	'PNI_DocumentPrints_PresentationsManuals_SameDay',
	'PNI_DocumentPrints_Newsletters_SameDay',
	'PNI_DocumentPrints_SellSheets_SameDay',
	'PNI_DocumentPrints_Blueprints',
	'PNI_DocumentPrints_Blueprints_SameDay',
	'PNI_DocumentPrints_PresentationsManuals',
	'PNI_DocumentPrints_SellSheets',
	'PNI_DocumentPrints_Newsletters',
	'PNI_DocumentPrints_SimplePrints',
	'PNI_DocumentPrints_Booklets',
	'PNI_DocumentPrints_Booklets_SameDay'
))

UNION ALL

(SELECT 

f.baseItemTotal AS BaseRevenue,
f.itemTotal AS Revenue,
f.discountTotal AS Discount,
f.quantity AS Units,
f.orderID as OrderID,
f.subOrderID AS SubOrderID,
f.allocatedShippingFee As ShippingFee,
f.userID AS UserID,
ISNULL(f.ExternalOrderID, f.orderID) as ExternalOrderID,
dt.Date AS 'Calendar Date',
dt.Year AS 'Calendar Year',
dt.Month AS 'Calendar Month',
dt.WeekOfYear AS 'Calendar Week of Year',
dt.DayOfYear AS 'Calendar Day of Year',
dt.DayOfWeek AS 'Calendar Day of Week',
CASE 
WHEN f.isRIK = 1 THEN 'RIK'
WHEN f.isRIK =0 THEN 'NON_RIK'
ELSE 'NON_RIK'
END AS isRIK,
IIF(ISNULL(f.isResubmit,0) = 0, 'Not-Resubmitted', 'Resubmitted') AS IsResubmitted,
ISNULL(f.isResubmit,0) AS ResubmittedFlag,
pr.promoCode AS PromoCode,
pr.Description AS PromoDescription,
sh.shippingMethod AS ShippingMethod,
sh.ShippingType AS ShippingType,
del.deliveryCategory AS DeliveryCategory,
'Costco CA' AS Retailer,
app.appType AS AppType,
app.appContextID AS AppContext,
app.mobileOS AS MobileOS,
d.state_abbrev AS 'StateAbb',
d.country_abbrev as 'CountryAbb',
d.city as 'City',
d.zip as 'Zip',
H.Row_H AS Row_H,
H.Column_H AS Column_H,
H.State_H AS State_H,
H.Abbreviation_H AS Abbreviation_H
--ISNULL(sl.orderStatus,'Complete') AS Status




FROM 


PROD_BRONZE_DB.RETAIL_DATA.factOrder as f
INNER JOIN PROD_BRONZE_DB.RETAIL_DATA.dimProduct as p
ON f.dim_product_id = p.dim_product_id
INNER JOIN PROD_BRONZE_DB.RETAIL_DATA.dimRetailer AS r
on f.dim_retailer_id = r.dim_retailer_id
INNER JOIN PROD_BRONZE_DB.RETAIL_DATA.dimPromo as pr
ON f.dim_promo_id = pr.dim_promo_id
INNER JOIN PROD_BRONZE_DB.RETAIL_DATA.dimApplication AS app
ON f.dim_app_id = app.dim_app_id
INNER JOIN PROD_BRONZE_DB.RETAIL_DATA.dimDestination as d
ON f.dim_dest_id = d.dim_dest_id
INNER JOIN PROD_BRONZE_DB.RETAIL_DATA.dimPayment as pay
ON f.dim_payment_id = pay.dim_payment_id
INNER JOIN PROD_BRONZE_DB.RETAIL_DATA.dimDate as dt
ON f.checkoutdate_id = dt.dim_date_ID
INNER JOIN PROD_BRONZE_DB.RETAIL_DATA.dimShipping as sh
ON f.dim_shipping_id = sh.dim_shipping_id
INNER JOIN PROD_BRONZE_DB.RETAIL_DATA.dimDelivery as del
ON f.dim_delivery_id = del.dim_delivery_id
INNER JOIN PROD_BRONZE_DB.MASTER_DATA.dimRDate as rdt
on dt.dim_date_ID = rdt.dim_date_id and f.retailerID = rdt.RetailerID
LEFT JOIN PROD_BRONZE_DB.RETAIL_DATA.Hexmap as H
ON d.state_abbrev = H.Abbreviation_H
LEFT JOIN PROD_BRONZE_DB.RETAIL_DATA.dimUser as us
ON f.dim_user_id=us.dim_user_id
--LEFT JOIN  PROD_BRONZE_DB.RETAIL_DATA.dimInCompletedSubOrderStatus st
--ON f.retailerID=st.retailerid and f.orderID=st.orderid and f.subOrderID=st.suborderid
--LEFT JOIN PROD_BRONZE_DB.RETAIL_DATA.RPT_TestUser as test on f.retailerID=test.retailerid and f.userID=test.userid
--LEFT JOIN PROD_BRONZE_DB.RETAIL_DATA.dimStatus as sl on st.orderstatusid =sl.orderStatusID AND sl.retailerID =2


WHERE f.retailerID = 2
AND ISNULL(f.isTest,0)=0
--and isnull(test.userid,0) =0
AND f.fact_id != 224811775
AND CONVERT(date,f.checkoutDateTime) >= '2019-02-03'
AND p.PNIProductTypeName != 'Business Products'
AND p.RetailerProductBaseName != 'Stationery Card Envelopes' -- Remove envelopes and VAC in cards
AND p.RetailerProductBaseName != '6x7.5 Photo Cards VAC'
and p.RetailerProductBaseName != '5x7 Envelopes'

)) AS Retailers


LEFT JOIN 

(SELECT 

rdt.RYear AS 'Staples Year',
rdt.RWeekOfYear AS 'Staples Week',
rdt.RPeriod AS 'Staples Period',
rdt.RWeekOfPeriod AS 'Staples Week of Period',
rdt.RDayOfYear AS 'Staples Day of Year',
rdt.RQuarter AS 'Staples Quarter',
rdt.Date AS 'Date'


FROM PROD_BRONZE_DB.MASTER_DATA.dimRDate rdt

where rdt.RetailerID = 50
AND rdt.RYear > 2018) AS RDate

ON Retailers.Calendar Date=RDate.Date













 


CREATE VIEW RETAIL_DATA.vSPLUS_RIKvsNONRIK_Herc_exl
AS

 

SELECT

 

Id = o.fact_id,

 

       Units = o.quantity,
      
	  CASE
	  WHEN po.Description IN ('25 5x7 flat cards Groupon', '25 flat cards Groupon') THEN o.itemTotal + 10.8
	  WHEN po.Description IN ('50 5x7 flat cards Groupon', '50 flat cards Groupon') THEN o.itemTotal + 18
	  WHEN po.Description IN ('100 5x7 flat cards Groupon', '100 flat cards Groupon') THEN o.itemTotal + 36
	  WHEN po.Description IN ('200 5x7 flat cards Groupon', '200 flat cards Groupon') THEN o.itemTotal + 55.8
	  ELSE o.itemTotal
	  END AS  Revenue,

	  CASE
	  WHEN po.Description IN ('25 5x7 flat cards Groupon', '25 flat cards Groupon') THEN o.discountTotal - 10.8
	  WHEN po.Description IN ('50 5x7 flat cards Groupon', '50 flat cards Groupon') THEN o.discountTotal - 18
	  WHEN po.Description IN ('100 5x7 flat cards Groupon', '100 flat cards Groupon') THEN o.discountTotal - 36
	  WHEN po.Description IN ('200 5x7 flat cards Groupon', '200 flat cards Groupon') THEN o.discountTotal - 55.8
	  ELSE o.discountTotal
	  END AS DiscountAmount,
       BaseRevenue = o.baseItemTotal,
       ShippingFee = o.allocatedShippingFee,
       PackSize = o.packSize,
       TotalPages = isnull(o.TotalPages, 0),
       ExtraPages = isnull(o.ExtraPages, 0), 
       NoOfOrderItems = isnull(o.NoOfOrderItems, 0),
       OrderID = o.orderID,
       SubOrderID = o.subOrderID,
       ExternalOrderID = isnull(o.ExternalOrderID, o.orderID),
       UserID = o.userID,

 

       RetailerID = o.retailerID,
       AppContextID = a.appContextID,
       AppType = a.appType,
       MobileOS = a.mobileOS,

 

       ItemName = p.retailerProductName,
       PNIProductSKU = p.SKU,
       PNIProductCategory = p.PNIProductTypeName,
       PNIProductType = p.PNIProductSubTypeName,

 

       RetailerProductCategory = p.RetailerProductTypeName,
       RetailerProductType = p.RetailerProductSubTypeName,
       RetailerProductName = p.RetailerProductBaseName,

 

       ProductCode = p.ProductCode,
       DesignCode = p.DesignCode,
       DesignerID = p.DesignerID,

 

       Size = p.Size,
       NoOfSurfaces = p.NoOfSurfaces,
       Orientation = p.Orientation,
       ProductOptions = p.ProductOptions,

 

       Tags = p.Tags,
       IsCreateYourOwn = p.IsCreateYourOwn,

 

       RetailerSKU = s.RetailerSKU,

 

       PromoCode = po.promoCode,
       PromoDesc = po.description,

 

       StoreID = d.retailerStoreID,
       Country = d.country_abbrev,
       State = d.state_abbrev,
       City = d.city,
       ZipCode = d.zip,

 

       PaymentMethod = py.PaymentMethod,
       ShippingType = sh.ShippingType,

 

       Date = dt.Date,

 

       CalendarYear = dt.Year,
       CalendarQuarter = dt.Quarter,
       CalendarMonth = dt.Month,
       CalendarWeek = dt.WeekOfYear,
       CalendarDayOfYear = dt.DayOfYear,

 

       DayOfWeek = left(dt.DayOfWeek,3),

 

       PNIYear = rd.RYear,
       PNIQuarter = rd.RQuarter,
       PNIPeriod = rd.RPeriod,
       PNIWeek = rd.RWeekOfYear,
       PNIDayOfYear = rd.RDayOfYear,

 

       RetailerYear = case when rd.RYear = 0 then dt.Year else rd.RYear end,
       RetailerQuarter = case when rd.RQuarter = 0 then dt.Quarter else rd.RQuarter end,
       RetailerPeriod = case when rd.RPeriod = 0 then dt.Month else rd.RPeriod end,
       RetailerWeek = case when rd.RWeekOfYear = 0 then dt.WeekOfYear else rd.RWeekOfYear end,
       RetailerDayOfYear = case when rd.RDayOfYear = 0 then dt.Day else rd.RDayOfYear end,
       RetailerWeekofPeriod= rd.RWeekOfPeriod,

 

       RetailerName = r.retailerName,
       o.isRIK,
       CASE 
       WHEN  o.isRIK = 1 THEN 'RIK'
       WHEN  o.isRIK =0 THEN 'NON_RIK'
       ELSE 'Investigate'
       END AS 'Rik_Classified',

 

       IIF(ISNULL(o.isResubmit,0) = 0, 'Not-Resubmitted', 'Resubmitted') AS IsResubmitted,
       ISNULL(o.isResubmit,0) AS ResubmittedFlag,

 


        
        sh.shippingMethod AS Shipping_Method,
        sh.shippingMethodID AS Shipping_Method_ID,
        del.deliveryCategory as Delivery_Category,
        del.deliveryCategoryID AS Delivery_CategoryID,
        H.Row_H AS Row_H,
        H.Column_H AS Column_H,
        H.State_H AS State_H,
        H.Abbreviation_H AS Abbreviation_H,
        o.isOriginalRIK AS Is_Original_Rik,
        o.originalOrderItemTotal AS Original_Base_Revenue,
        o.isOriginalRIK AS Original_Order_Id,


 

        --CASE
        --WHEN resubmit.originalOrderID IS NULL THEN 'Not Resubmitted'
        ---WHEN resubmit.originalOrderID IS NOT NULL THEN 'Resubmitted'
        --ELSE 'PLS FIX'
        --END AS 'Orignal Resubmission',
        
        CASE 
		WHEN p.SKU='PNI_CourierDelivery_Pricing' THEN 'CourierDelivery'
        WHEN (Apollo.Apollo_ProductCategory IS NULL AND (TRY_CONVERT(int, p.SKU) IS NOT NULL)) THEN 'Calendar' 
        WHEN (Apollo.Apollo_ProductCategory IS NULL AND (CHARINDEX('DocumentPrints',p.SKU) >= 1)) THEN 'Document Printing'
        WHEN (Apollo.Apollo_ProductCategory IS NULL AND p.SKU = 'PNI_Envelopes') THEN 'Envelope'
        ELSE Apollo.Apollo_ProductCategory
        END AS SUb_Category,

 

        CASE
        WHEN resubmit.OrderIDR IS NULL THEN 'Orignal Not Resumbitted'
        ELSE 'Orginal Resubmitted'
        END as OriginalResubmit,
        resubmit.ResubmitDate,
        o.isPayInStore AS 'Is Pay In Store'
		--ISNULL(sl.orderStatus,'Complete') AS Status

 


  from PROD_BRONZE_DB.RETAIL_DATA.factOrder o with(nolock)
       join PROD_BRONZE_DB.RETAIL_DATA.dimProduct p with(nolock) on p.dim_product_id = o.dim_product_id
       join PROD_BRONZE_DB.RETAIL_DATA.dimApplication a with(nolock) on a.dim_app_id = o.dim_app_id
       join PROD_BRONZE_DB.RETAIL_DATA.dimRetailer r with(nolock) on r.dim_retailer_id = o.dim_retailer_id
       join PROD_BRONZE_DB.RETAIL_DATA.dimPromo po with(nolock) on po.dim_promo_id = o.dim_promo_id
       join PROD_BRONZE_DB.RETAIL_DATA.dimDestination d with(nolock) on d.dim_dest_id = o.dim_dest_id
       join PROD_BRONZE_DB.RETAIL_DATA.dimPayment py with(nolock) on py.dim_payment_id = o.dim_payment_id
       join PROD_BRONZE_DB.RETAIL_DATA.dimDate dt with(nolock) on dt.dim_date_ID = o.checkoutdate_id
       join PROD_BRONZE_DB.RETAIL_DATA.dimShipping sh with(nolock) on sh.dim_shipping_id = o.dim_shipping_id
       join PROD_BRONZE_DB.RETAIL_DATA.dimSku s with(nolock) on s.dim_sku_id = isnull(o.dim_sku_id, -1)
       join PROD_BRONZE_DB.MASTER_DATA.dimRDate rd with(nolock) on rd.dim_date_id = dt.dim_date_id and rd.retailerID = o.retailerID
       LEFT JOIN  PROD_BRONZE_DB.RETAIL_DATA.dimDelivery del with(nolock) on o.dim_delivery_id = del.dim_delivery_id
       LEFT JOIN PROD_BRONZE_DB.RETAIL_DATA.Hexmap H ON d.state_abbrev = H.Abbreviation_H
	  -- LEFT JOIN  PROD_BRONZE_DB.RETAIL_DATA.dimInCompletedSubOrderStatus st
	  -- ON o.retailerID=st.retailerid and o.orderID=st.orderid and o.subOrderID=st.suborderid
	  -- LEFT JOIN PROD_BRONZE_DB.RETAIL_DATA.RPT_TestUser as test on o.retailerID=test.retailerid and o.userID=test.userid
	   --LEFT JOIN PROD_BRONZE_DB.RETAIL_DATA.dimStatus as sl on st.orderstatusid =sl.orderStatusID AND sl.retailerID =50
	 
 

 

    
    LEFT JOIN 

 


    (SELECT 
     

 

     f.originalOrderID AS OrderIDR,
      MAX(CONVERT(date,f.checkoutDateTime)) AS ResubmitDate

 

     FROM PROD_BRONZE_DB.RETAIL_DATA.factOrder as f

 

     WHERE ISNULL(f.isResubmit,0) = 1
     AND CONVERT(date,f.checkoutDateTime) >= '2018-01-01'
     AND f.originalOrderID IS NOT NULL 
     GROUP BY f.originalOrderID) AS resubmit

 

     ON o.orderID=resubmit.OrderIDR

 

     LEFT JOIN 

 

(SELECT 

 


AC.ProductCode AS Apollo_ProductCode,
AC.designcode AS Apollo_DesignCode, 
AC.ProductTypeCategoryKey AS Apollo_ProductCategory

 


FROM PROD_BRONZE_DB.RETAIL_DATA.SPLUS_ApolloProductCatalog AC

 


GROUP BY 
ProductCode, designcode, ProductTypeCategoryKey) AS Apollo

 

ON p.ProductCode = Apollo.Apollo_ProductCode
AND p.DesignCode = Apollo.Apollo_DesignCode

 

      where o.retailerID = 50
   and isnull(o.isTest, 0) = 0
   --and isnull(o.isRIK, 0) = 0 
   -- and isnull(test.userid,0) =0
   and a.appContextID != 11945004
   and o.userID != 138583463 --exclude this userid
   and o.fact_id != 224811775  -- wrong one, exclude!
   and CONVERT(date,o.checkoutDateTime) >= '2018-01-01'
   and
   p.SKU NOT IN ( 
     '10757',
     '1416392',
     '1416393',
     '1416394',
     '1416399',
     '1416401',
     '1416406',
     '1416407',
     '1416420',
     '1416421',
     '1416425',
     '1416426',
     '1416427',
     '1416434',
     '1416435',
     '1416440',
     '1416451',
     '1416457',
     '1416460',
     '1416476',
     '1416479',
     '1416480',
     '1416490',
     '1416494',
     '1416504',
     '1416506',
     '1416512',
     '1416532',
     '1416546',
     '1416575',
     '1416576',
     'ExpressService',
     'Makr_Generic_Product_Delivered',
     'Makr_Generic_Product_Instore',
    'PX_ENV',
    'STPLS_DOC',
    'Taylor_Products',
    'PX_ENV_Premium',
    '24390398',
    '24390399',
    '24390401',
    '24390402',
    '24390403',
    '24391002'
    ,'Taylor_Product',
    'PNI_DocumentPrints_SimplePrints_SameDay',
    'PNI_DocumentPrints_Resumes',
    'PNI_DocumentPrints_Resumes_SameDay',
    'PNI_DocumentPrints_PresentationsManuals_SameDay',
    'PNI_DocumentPrints_Newsletters_SameDay',
    'PNI_DocumentPrints_SellSheets_SameDay',
    'PNI_DocumentPrints_Blueprints',
    'PNI_DocumentPrints_Blueprints_SameDay',
    'PNI_DocumentPrints_PresentationsManuals',
    'PNI_DocumentPrints_SellSheets',
    'PNI_DocumentPrints_Newsletters',
    'PNI_DocumentPrints_SimplePrints',
	'PNI_DocumentPrints_Booklets',
	'PNI_DocumentPrints_Booklets_SameDay'
)
    AND NOT( p.SKU = N'PNI_BusinessCards' AND p.ProductCode=N'EXBIZCRD3X2H' AND p.DesignCode = N'AFXEXBC00040')
    AND NOT (p.SKU =N'PX_Greeting_Card_01' AND p.ProductCode = N'UNKN' AND p.DesignCode = N'APG2379SP')
    AND NOT (p.SKU =N'PX_Greeting_Card_01' AND p.ProductCode = N'UNKN' AND p.DesignCode = N'APT0864SP')
    AND NOT (p.SKU =N'PX_Greeting_Card_01' AND p.ProductCode = N'UNKN' AND p.DesignCode = N'UNKN') 
	AND o.orderID NOT IN (580718134, 580718134, 581431704, 581431959, 581433805
							,581431704
							,581434066
							,581432548
							,581433019
							,581447397
							,581433366
							,581431021
							,581433917
							,581432220
							,581447559
							,581432663
							,581585201
							,581584877
							,581585104) -- Removed out these orders because I think they are test orders not properly flagged

 



CREATE VIEW MASTER_DATA.vDailyKPIReportv2
AS


SELECT 

Retailers.*,
RDate.Staples Day of Year,
RDate.Staples Period,
RDate.Staples Quarter,
RDate.Staples Week,
RDate.Staples Week of Period,
RDate.Staples Year



FROM 


((SELECT 

f.baseItemTotal AS BaseRevenue,
f.itemTotal AS Revenue,
f.discountTotal AS Discount,
f.quantity AS Units,
f.orderID as OrderID,
f.subOrderID AS SubOrderID,
f.allocatedShippingFee As ShippingFee,
f.userID AS UserID,
ISNULL(f.ExternalOrderID, f.orderID) as ExternalOrderID,
dt.Date AS 'Calendar Date',
dt.Year AS 'Calendar Year',
dt.Month AS 'Calendar Month',
dt.WeekOfYear AS 'Calendar Week of Year',
dt.DayOfYear AS 'Calendar Day of Year',
dt.DayOfWeek AS 'Calendar Day of Week',
CASE 
WHEN f.isRIK = 1 THEN 'RIK'
WHEN f.isRIK =0 THEN 'NON_RIK'
ELSE 'NON_RIK'
END AS isRIK,
IIF(ISNULL(f.isResubmit,0) = 0, 'Not-Resubmitted', 'Resubmitted') AS IsResubmitted,
ISNULL(f.isResubmit,0) AS ResubmittedFlag,
pr.promoCode AS PromoCode,
pr.Description AS PromoDescription,
sh.shippingMethod AS ShippingMethod,
sh.ShippingType AS ShippingType,
del.deliveryCategory AS DeliveryCategory,
'Costco US' AS Retailer,
app.appType AS AppType,
app.appContextID AS AppContext,
app.mobileOS AS MobileOS,
d.state_abbrev AS 'StateAbb',
d.country_abbrev as 'CountryAbb',
d.city as 'City',
d.zip as 'Zip',
H.Row_H AS Row_H,
H.Column_H AS Column_H,
H.State_H AS State_H,
H.Abbreviation_H AS Abbreviation_H


FROM 


PROD_BRONZE_DB.MASTER_DATA.factOrder as f
INNER JOIN PROD_BRONZE_DB.MASTER_DATA.dimProduct as p
ON f.dim_product_id = p.dim_product_id
INNER JOIN PROD_BRONZE_DB.MASTER_DATA.dimRetailer AS r
on f.dim_retailer_id = r.dim_retailer_id
INNER JOIN PROD_BRONZE_DB.MASTER_DATA.dimPromo as pr
ON f.dim_promo_id = pr.dim_promo_id
INNER JOIN PROD_BRONZE_DB.MASTER_DATA.dimApplication AS app
ON f.dim_app_id = app.dim_app_id
INNER JOIN PROD_BRONZE_DB.MASTER_DATA.dimDestination as d
ON f.dim_dest_id = d.dim_dest_id
INNER JOIN PROD_BRONZE_DB.MASTER_DATA.dimPayment as pay
ON f.dim_payment_id = pay.dim_payment_id
INNER JOIN PROD_BRONZE_DB.MASTER_DATA.dimDate as dt
ON f.checkoutdate_id = dt.dim_date_ID
INNER JOIN PROD_BRONZE_DB.MASTER_DATA.dimShipping as sh
ON f.dim_shipping_id = sh.dim_shipping_id
INNER JOIN PROD_BRONZE_DB.MASTER_DATA.dimDelivery as del
ON f.dim_delivery_id = del.dim_delivery_id
INNER JOIN PROD_BRONZE_DB.MASTER_DATA.dimRDate as rdt
on dt.dim_date_ID = rdt.dim_date_id and f.retailerID = rdt.RetailerID
LEFT JOIN PROD_BRONZE_DB.MASTER_DATA.Hexmap as H
ON d.state_abbrev = H.Abbreviation_H

WHERE f.retailerID = 27
AND ISNULL(f.isTest,0)=0
AND f.fact_id != 224811775
AND CONVERT(date,f.checkoutDateTime) >= '2019-02-03'
AND p.PNIProductTypeName != 'Business Products'
AND p.RetailerProductBaseName != 'Stationery Card Envelopes' -- Remove envelopes and VAC in cards
AND p.RetailerProductBaseName != '6x7.5 Photo Cards VAC'
AND p.SKU NOT IN ( 
'6x75_L_N_25',
'16x20_B_P_COMM',
'20x30_B_P_COMM',
'134',
'135',
'2061',
'2563',
'2564',
'2565',
'2571',
'2575',
'NB_1',
'Notepad_14',
'NP_2',
'NP_81',
'S_1',
'S_19',
'S_23',
'S_56',
'S_58'))

UNION ALL 


(SELECT 

f.baseItemTotal AS BaseRevenue,
f.itemTotal AS Revenue,
f.discountTotal AS Discount,
f.quantity AS Units,
f.orderID as OrderID,
f.subOrderID AS SubOrderID,
f.allocatedShippingFee As ShippingFee,
f.userID AS UserID,
ISNULL(f.ExternalOrderID, f.orderID) as ExternalOrderID,
dt.Date AS 'Calendar Date',
dt.Year AS 'Calendar Year',
dt.Month AS 'Calendar Month',
dt.WeekOfYear AS 'Calendar Week of Year',
dt.DayOfYear AS 'Calendar Day of Year',
dt.DayOfWeek AS 'Calendar Day of Week',
CASE 
WHEN f.isRIK = 1 THEN 'RIK'
WHEN f.isRIK =0 THEN 'NON_RIK'
ELSE 'NON_RIK'
END AS isRIK,
IIF(ISNULL(f.isResubmit,0) = 0, 'Not-Resubmitted', 'Resubmitted') AS IsResubmitted,
ISNULL(f.isResubmit,0) AS ResubmittedFlag,
pr.promoCode AS PromoCode,
pr.Description AS PromoDescription,
sh.shippingMethod AS ShippingMethod,
sh.ShippingType AS ShippingType,
del.deliveryCategory AS DeliveryCategory,
'Costco BP' AS Retailer,
app.appType AS AppType,
app.appContextID AS AppContext,
app.mobileOS AS MobileOS,
d.state_abbrev AS 'StateAbb',
d.country_abbrev as 'CountryAbb',
d.city as 'City',
d.zip as 'Zip',
H.Row_H AS Row_H,
H.Column_H AS Column_H,
H.State_H AS State_H,
H.Abbreviation_H AS Abbreviation_H



FROM 


PROD_BRONZE_DB.MASTER_DATA.factOrder as f
INNER JOIN PROD_BRONZE_DB.MASTER_DATA.dimProduct as p
ON f.dim_product_id = p.dim_product_id
INNER JOIN PROD_BRONZE_DB.MASTER_DATA.dimRetailer AS r
on f.dim_retailer_id = r.dim_retailer_id
INNER JOIN PROD_BRONZE_DB.MASTER_DATA.dimPromo as pr
ON f.dim_promo_id = pr.dim_promo_id
INNER JOIN PROD_BRONZE_DB.MASTER_DATA.dimApplication AS app
ON f.dim_app_id = app.dim_app_id
INNER JOIN PROD_BRONZE_DB.MASTER_DATA.dimDestination as d
ON f.dim_dest_id = d.dim_dest_id
INNER JOIN PROD_BRONZE_DB.MASTER_DATA.dimPayment as pay
ON f.dim_payment_id = pay.dim_payment_id
INNER JOIN PROD_BRONZE_DB.MASTER_DATA.dimDate as dt
ON f.checkoutdate_id = dt.dim_date_ID
INNER JOIN PROD_BRONZE_DB.MASTER_DATA.dimShipping as sh
ON f.dim_shipping_id = sh.dim_shipping_id
INNER JOIN PROD_BRONZE_DB.MASTER_DATA.dimDelivery as del
ON f.dim_delivery_id = del.dim_delivery_id
INNER JOIN PROD_BRONZE_DB.MASTER_DATA.dimRDate as rdt
on dt.dim_date_ID = rdt.dim_date_id and f.retailerID = rdt.RetailerID
LEFT JOIN PROD_BRONZE_DB.MASTER_DATA.Hexmap as H
ON d.state_abbrev = H.Abbreviation_H


WHERE f.retailerID = 27
AND ISNULL(f.isTest,0)=0
AND f.fact_id != 224811775
AND f.orderID != 363133057
AND CONVERT(date,f.checkoutDateTime) >= '2019-02-03'
AND p.PNIProductTypeName = 'Business Products'
)

UNION ALL 


(SELECT 

f.baseItemTotal AS BaseRevenue,
f.itemTotal AS Revenue,
f.discountTotal AS Discount,
f.quantity AS Units,
f.orderID as OrderID,
f.subOrderID AS SubOrderID,
f.allocatedShippingFee As ShippingFee,
f.userID AS UserID,
ISNULL(f.ExternalOrderID, f.orderID) as ExternalOrderID,
dt.Date AS 'Calendar Date',
dt.Year AS 'Calendar Year',
dt.Month AS 'Calendar Month',
dt.WeekOfYear AS 'Calendar Week of Year',
dt.DayOfYear AS 'Calendar Day of Year',
dt.DayOfWeek AS 'Calendar Day of Week',
CASE 
WHEN f.isRIK = 1 THEN 'RIK'
WHEN f.isRIK =0 THEN 'NON_RIK'
ELSE 'NON_RIK'
END AS isRIK,
IIF(ISNULL(f.isResubmit,0) = 0, 'Not-Resubmitted', 'Resubmitted') AS IsResubmitted,
ISNULL(f.isResubmit,0) AS ResubmittedFlag,
pr.promoCode AS PromoCode,
pr.Description AS PromoDescription,
sh.shippingMethod AS ShippingMethod,
sh.ShippingType AS ShippingType,
del.deliveryCategory AS DeliveryCategory,
'SAMS BP' AS Retailer,
app.appType AS AppType,
app.appContextID AS AppContext,
app.mobileOS AS MobileOS,
d.state_abbrev AS 'StateAbb',
d.country_abbrev as 'CountryAbb',
d.city as 'City',
d.zip as 'Zip',
H.Row_H AS Row_H,
H.Column_H AS Column_H,
H.State_H AS State_H,
H.Abbreviation_H AS Abbreviation_H



FROM 


PROD_BRONZE_DB.MASTER_DATA.factOrder as f
INNER JOIN PROD_BRONZE_DB.MASTER_DATA.dimProduct as p
ON f.dim_product_id = p.dim_product_id
INNER JOIN PROD_BRONZE_DB.MASTER_DATA.dimRetailer AS r
on f.dim_retailer_id = r.dim_retailer_id
INNER JOIN PROD_BRONZE_DB.MASTER_DATA.dimPromo as pr
ON f.dim_promo_id = pr.dim_promo_id
INNER JOIN PROD_BRONZE_DB.MASTER_DATA.dimApplication AS app
ON f.dim_app_id = app.dim_app_id
INNER JOIN PROD_BRONZE_DB.MASTER_DATA.dimDestination as d
ON f.dim_dest_id = d.dim_dest_id
INNER JOIN PROD_BRONZE_DB.MASTER_DATA.dimPayment as pay
ON f.dim_payment_id = pay.dim_payment_id
INNER JOIN PROD_BRONZE_DB.MASTER_DATA.dimDate as dt
ON f.checkoutdate_id = dt.dim_date_ID
INNER JOIN PROD_BRONZE_DB.MASTER_DATA.dimShipping as sh
ON f.dim_shipping_id = sh.dim_shipping_id
INNER JOIN PROD_BRONZE_DB.MASTER_DATA.dimDelivery as del
ON f.dim_delivery_id = del.dim_delivery_id
INNER JOIN PROD_BRONZE_DB.MASTER_DATA.dimRDate as rdt
on dt.dim_date_ID = rdt.dim_date_id and f.retailerID = rdt.RetailerID
LEFT JOIN PROD_BRONZE_DB.MASTER_DATA.Hexmap as H
ON d.state_abbrev = H.Abbreviation_H



WHERE f.retailerID = 26
AND ISNULL(f.isTest,0)=0
AND f.fact_id != 224811775
--AND f.orderID != 363133057
AND CONVERT(date,f.checkoutDateTime) >= '2019-02-03'
AND p.PNIProductTypeName = 'Business Products')

UNION  ALL 

(SELECT 

f.baseItemTotal AS BaseRevenue,
f.itemTotal AS Revenue,
f.discountTotal AS Discount,
f.quantity AS Units,
f.orderID as OrderID,
f.subOrderID AS SubOrderID,
f.allocatedShippingFee As ShippingFee,
f.userID AS UserID,
ISNULL(f.ExternalOrderID, f.orderID) as ExternalOrderID,
dt.Date AS 'Calendar Date',
dt.Year AS 'Calendar Year',
dt.Month AS 'Calendar Month',
dt.WeekOfYear AS 'Calendar Week of Year',
dt.DayOfYear AS 'Calendar Day of Year',
dt.DayOfWeek AS 'Calendar Day of Week',
CASE 
WHEN f.isRIK = 1 THEN 'RIK'
WHEN f.isRIK =0 THEN 'NON_RIK'
ELSE 'NON_RIK'
END AS isRIK,
IIF(ISNULL(f.isResubmit,0) = 0, 'Not-Resubmitted', 'Resubmitted') AS IsResubmitted,
ISNULL(f.isResubmit,0) AS ResubmittedFlag,
pr.promoCode AS PromoCode,
pr.Description AS PromoDescription,
sh.shippingMethod AS ShippingMethod,
sh.ShippingType AS ShippingType,
del.deliveryCategory AS DeliveryCategory,
'SAMS' AS Retailer,
app.appType AS AppType,
app.appContextID AS AppContext,
app.mobileOS AS MobileOS,
d.state_abbrev AS 'StateAbb',
d.country_abbrev as 'CountryAbb',
d.city as 'City',
d.zip as 'Zip',
H.Row_H AS Row_H,
H.Column_H AS Column_H,
H.State_H AS State_H,
H.Abbreviation_H AS Abbreviation_H




FROM 


PROD_BRONZE_DB.MASTER_DATA.factOrder as f
INNER JOIN PROD_BRONZE_DB.MASTER_DATA.dimProduct as p
ON f.dim_product_id = p.dim_product_id
INNER JOIN PROD_BRONZE_DB.MASTER_DATA.dimRetailer AS r
on f.dim_retailer_id = r.dim_retailer_id
INNER JOIN PROD_BRONZE_DB.MASTER_DATA.dimPromo as pr
ON f.dim_promo_id = pr.dim_promo_id
INNER JOIN PROD_BRONZE_DB.MASTER_DATA.dimApplication AS app
ON f.dim_app_id = app.dim_app_id
INNER JOIN PROD_BRONZE_DB.MASTER_DATA.dimDestination as d
ON f.dim_dest_id = d.dim_dest_id
INNER JOIN PROD_BRONZE_DB.MASTER_DATA.dimPayment as pay
ON f.dim_payment_id = pay.dim_payment_id
INNER JOIN PROD_BRONZE_DB.MASTER_DATA.dimDate as dt
ON f.checkoutdate_id = dt.dim_date_ID
INNER JOIN PROD_BRONZE_DB.MASTER_DATA.dimShipping as sh
ON f.dim_shipping_id = sh.dim_shipping_id
INNER JOIN PROD_BRONZE_DB.MASTER_DATA.dimDelivery as del
ON f.dim_delivery_id = del.dim_delivery_id
INNER JOIN PROD_BRONZE_DB.MASTER_DATA.dimRDate as rdt
on dt.dim_date_ID = rdt.dim_date_id and f.retailerID = rdt.RetailerID
LEFT JOIN PROD_BRONZE_DB.MASTER_DATA.Hexmap as H
ON d.state_abbrev = H.Abbreviation_H


WHERE f.retailerID = 26
AND ISNULL(f.isTest,0)=0
AND f.fact_id != 224811775
--AND f.orderID != 363133057
AND CONVERT(date,f.checkoutDateTime) >= '2019-02-03'
AND p.PNIProductTypeName != 'Business Products')

UNION ALL 

( SELECT

rn.BaseRevenue AS BaseRevenue,
rn.Revenue AS Revenue,
rn.DiscountAmount AS Discount,
rn.Units AS Units,
rn.OrderID AS OrderID,
rn.SubOrderID AS SubOrderID,
rn.ShippingFee AS ShippingFee,
rn.UserID AS UserID,
rn.ExternalOrderID AS ExternalOrderID,
rn.Date AS 'Calendar Date',
rn.CalendarYear AS 'Calendar Year',
rn.CalendarMonth AS 'Calendar Month',
rn.CalendarWeek AS 'Calendar Week of Year',
rn.CalendarDayOfYear AS 'Calendar Day of Year',
rn.DayOfWeek AS 'Calendar Day of Week',
rn.Rik_Classified AS isRIK,
rn.IsResubmitted AS IsResubmitted,
rn.ResubmittedFlag AS ResubmittedFlag,
rn.PromoCode AS PromoCode,
rn.PromoDesc AS PromoDescription,
rn.Shipping_Method AS ShippingMethod,
rn.ShippingType AS ShippingType,
rn.Delivery_Category AS DeliveryCategory,
'Staples US' AS Retailer,
rn.AppType AS AppType,
rn.AppContextID AS AppContext,
rn.MobileOS AS MobileOS,
rn.State AS StateAbb,
rn.Country as CountryAbb,
rn.City AS City,
rn.ZipCode as Zip,
rn.Row_H as Row_H,
rn.Column_H as Column_H,
rn.State_H AS State_H,
rn.Abbreviation_H as	Abbreviation_H 




FROM PROD_BRONZE_DB.MASTER_DATA.vSPLUS_RIKvsNONRIK_Herc_exl as rn

WHERE rn.Date >= '2019-02-03')

UNION ALL 

(SELECT 

f.baseItemTotal AS BaseRevenue,
f.itemTotal AS Revenue,
f.discountTotal AS Discount,
f.quantity AS Units,
f.orderID as OrderID,
f.subOrderID AS SubOrderID,
f.allocatedShippingFee As ShippingFee,
f.userID AS UserID,
ISNULL(f.ExternalOrderID, f.orderID) as ExternalOrderID,
dt.Date AS 'Calendar Date',
dt.Year AS 'Calendar Year',
dt.Month AS 'Calendar Month',
dt.WeekOfYear AS 'Calendar Week of Year',
dt.DayOfYear AS 'Calendar Day of Year',
dt.DayOfWeek AS 'Calendar Day of Week',
CASE 
WHEN f.isRIK = 1 THEN 'RIK'
WHEN f.isRIK =0 THEN 'NON_RIK'
ELSE 'NON_RIK'
END AS isRIK,
IIF(ISNULL(f.isResubmit,0) = 0, 'Not-Resubmitted', 'Resubmitted') AS IsResubmitted,
ISNULL(f.isResubmit,0) AS ResubmittedFlag,
pr.promoCode AS PromoCode,
pr.Description AS PromoDescription,
sh.shippingMethod AS ShippingMethod,
sh.ShippingType AS ShippingType,
del.deliveryCategory AS DeliveryCategory,
'Costco CA' AS Retailer,
app.appType AS AppType,
app.appContextID AS AppContext,
app.mobileOS AS MobileOS,
d.state_abbrev AS 'StateAbb',
d.country_abbrev as 'CountryAbb',
d.city as 'City',
d.zip as 'Zip',
H.Row_H AS Row_H,
H.Column_H AS Column_H,
H.State_H AS State_H,
H.Abbreviation_H AS Abbreviation_H




FROM 


PROD_BRONZE_DB.MASTER_DATA.factOrder as f
INNER JOIN PROD_BRONZE_DB.MASTER_DATA.dimProduct as p
ON f.dim_product_id = p.dim_product_id
INNER JOIN PROD_BRONZE_DB.MASTER_DATA.dimRetailer AS r
on f.dim_retailer_id = r.dim_retailer_id
INNER JOIN PROD_BRONZE_DB.MASTER_DATA.dimPromo as pr
ON f.dim_promo_id = pr.dim_promo_id
INNER JOIN PROD_BRONZE_DB.MASTER_DATA.dimApplication AS app
ON f.dim_app_id = app.dim_app_id
INNER JOIN PROD_BRONZE_DB.MASTER_DATA.dimDestination as d
ON f.dim_dest_id = d.dim_dest_id
INNER JOIN PROD_BRONZE_DB.MASTER_DATA.dimPayment as pay
ON f.dim_payment_id = pay.dim_payment_id
INNER JOIN PROD_BRONZE_DB.MASTER_DATA.dimDate as dt
ON f.checkoutdate_id = dt.dim_date_ID
INNER JOIN PROD_BRONZE_DB.MASTER_DATA.dimShipping as sh
ON f.dim_shipping_id = sh.dim_shipping_id
INNER JOIN PROD_BRONZE_DB.MASTER_DATA.dimDelivery as del
ON f.dim_delivery_id = del.dim_delivery_id
INNER JOIN PROD_BRONZE_DB.MASTER_DATA.dimRDate as rdt
on dt.dim_date_ID = rdt.dim_date_id and f.retailerID = rdt.RetailerID
LEFT JOIN PROD_BRONZE_DB.MASTER_DATA.Hexmap as H
ON d.state_abbrev = H.Abbreviation_H


WHERE f.retailerID = 2
AND ISNULL(f.isTest,0)=0
AND f.fact_id != 224811775
AND CONVERT(date,f.checkoutDateTime) >= '2019-02-03'
AND p.PNIProductTypeName != 'Business Products'
AND p.RetailerProductBaseName != 'Stationery Card Envelopes' -- Remove envelopes and VAC in cards
AND p.RetailerProductBaseName != '6x7.5 Photo Cards VAC'
and p.RetailerProductBaseName != '5x7 Envelopes'

)) AS Retailers


LEFT JOIN 

(SELECT 

rdt.RYear AS 'Staples Year',
rdt.RWeekOfYear AS 'Staples Week',
rdt.RPeriod AS 'Staples Period',
rdt.RWeekOfPeriod AS 'Staples Week of Period',
rdt.RDayOfYear AS 'Staples Day of Year',
rdt.RQuarter AS 'Staples Quarter',
rdt.Date AS 'Date'


FROM PROD_BRONZE_DB.MASTER_DATA.dimRDate rdt

where rdt.RetailerID = 50
AND rdt.RYear > 2018) AS RDate

ON Retailers.Calendar Date=RDate.Date
 
CREATE View RETAIL_DATA.vTOF_BOF_All_Retailers
as

SELECT * 

FROM

(SELECT 
cus.DeviceCategory AS DeviceCategory,
CONVERT(date, cus.Date) AS 'Date',
cus.Segment AS Segment,
cus.Sessions AS 'Sessions',
CASE 
WHEN cus.Segment = 'Costco US BOF - Cart Visits Funnel Segment' THEN 'BOF - Card Visits'
WHEN cus.Segment ='Costco US BOF - Order Confirmation Visits Funnel Segment' THEN 'BOF - Order Confirmation'
WHEN cus.Segment ='Costco US TOF - All Visits Funnel Segment' THEN 'TOF - All Visits'
WHEN cus.Segment ='Costco US TOF - Cart Visits Funnel Segment' THEN 'TOF - Cart Visits'
END AS 'Segment Category',
'Costco US' AS Retailer

FROM PROD_BRONZE_DB.RETAIL_DATA.GA_Costco_US_BOF_TOF as cus


UNION ALL 


SELECT 
cbp.DeviceCategory AS DeviceCategory,
CONVERT(date, cbp.Date) AS 'Date',
cbp.Segment AS Segment,
cbp.Sessions AS 'Sessions',
CASE 
WHEN cbp.Segment = 'Costco BP BOF - Cart Visits Funnel Segment' THEN 'BOF - Card Visits'
WHEN cbp.Segment ='Costco BP BOF - Order Confirmation Visits Funnel Segment' THEN 'BOF - Order Confirmation'
WHEN cbp.Segment ='Costco BP TOF - All Visits Funnel Segment' THEN 'TOF - All Visits'
WHEN cbp.Segment ='Costco BP TOF - Cart Visits Funnel Segment' THEN 'TOF - Cart Visits'
END AS 'Segment Category',
'Costco BP' AS Retailer

FROM PROD_BRONZE_DB.RETAIL_DATA.GA_Costco_BP_BOF_TOF as cbp

UNION ALL


SELECT 
ca.DeviceCategory AS DeviceCategory,
CONVERT(date, ca.Date) AS 'Date',
ca.Segment AS Segment,
ca.Sessions AS 'Sessions',
CASE 
WHEN ca.Segment = 'Costco CA BOF - Cart Visits Funnel Segment' THEN 'BOF - Card Visits'
WHEN ca.Segment ='Costco CA BOF - Order Confirmation Visits Funnel Segment' THEN 'BOF - Order Confirmation'
WHEN ca.Segment ='Costco CA TOF - All Visits Funnel Segment' THEN 'TOF - All Visits'
WHEN ca.Segment ='Costco CA TOF - Cart Visits Funnel Segment' THEN 'TOF - Cart Visits'
END AS 'Segment Category',
'Costco CA' AS Retailer

FROM PROD_BRONZE_DB.RETAIL_DATA.GA_Costco_CA_BOF_TOF as ca

UNION ALL

SELECT 

dsplus.DeviceCategory AS DeviceCategory,
CONVERT(date, dsplus.Date) AS 'Date',
dsplus.Segment AS Segment,
dsplus.Sessions as 'Sesions',
CASE 
WHEN dsplus.Segment ='Design Sessions(DO NOT EDIT - USED FOR API)' THEN 'TOF - All Visits'
WHEN dsplus.Segment ='Design Sessions to Cart(DO NOT EDIT - USED FOR API)' THEN 'TOF - Cart Visits'
WHEN dsplus.Segment ='Design - Sessions With Purchase(DO NOT EDIT - USED FOR API)' THEN 'BOF - Order Confirmation'
END AS 'Segment Category',
'Staples US' AS Retailer


FROM PROD_BRONZE_DB.RETAIL_DATA.GA_Staples_US_Design_BOF_TOF as dsplus

UNION ALL

SELECT 

ddsplus.DeviceCategory AS DeviceCategory,
CONVERT(date, ddsplus.Date) AS 'Date',
ddsplus.Segment AS Segment,
ddsplus.Sessions as 'Sesions',
CASE 
WHEN ddsplus.Segment ='Design Sessions(DO NOT EDIT - USED FOR API)' THEN 'BOF - Card Visits'
END AS 'Segment Category',
'Staples US' AS Retailer


FROM PROD_BRONZE_DB.RETAIL_DATA.GA_Staples_US_Design_BOF_TOF as ddsplus

WHERE ddsplus.Segment = 'Design Sessions(DO NOT EDIT - USED FOR API)'


UNION ALL 

SELECT 

docsplus.DeviceCategory AS DeviceCategory,
CONVERT(date, docsplus.Date) AS 'Date',
docsplus.Segment AS Segment,
docsplus.Sessions as 'Sesions',
CASE 
WHEN docsplus.Segment ='Hercules Sessions(DO NOT EDIT - USED FOR API)' THEN 'TOF - All Visits'
WHEN docsplus.Segment ='Hercules - Product Added to Cart(DO NOT EDIT - USED FOR API)' THEN 'TOF - Cart Visits'
WHEN docsplus.Segment ='Hercules - Sessions with Purchase(DO NOT EDIT - USED FOR API)' THEN 'BOF - Order Confirmation'
END AS 'Segment Category',
'Staples Document Printing' AS Retailer


FROM PROD_BRONZE_DB.RETAIL_DATA.GA_Staples_US_Hercules_BOF_TOF as docsplus

UNION ALL 

SELECT 

ddocsplus.DeviceCategory AS DeviceCategory,
CONVERT(date, ddocsplus.Date) AS 'Date',
ddocsplus.Segment AS Segment,
ddocsplus.Sessions as 'Sesions',
CASE 
WHEN ddocsplus.Segment ='Hercules Sessions(DO NOT EDIT - USED FOR API)' THEN 'BOF - Card Visits'

END AS 'Segment Category',
'Staples Document Printing' AS Retailer


FROM PROD_BRONZE_DB.RETAIL_DATA.GA_Staples_US_Hercules_BOF_TOF as ddocsplus


WHERE ddocsplus.Segment ='Hercules Sessions(DO NOT EDIT - USED FOR API)'


UNION ALL 

SELECT 
sam.DeviceCategory AS DeviceCategory,
CONVERT(date, sam.Date) AS 'Date',
sam.Segment AS Segment,
sam.Sessions AS 'Sessions',
CASE 
WHEN sam.Segment = 'Sams BOF - Cart Visits Funnel Segment' THEN 'BOF - Card Visits'
WHEN sam.Segment ='Sams BOF - Order Confirmation Visits Funnel Segment' THEN 'BOF - Order Confirmation'
WHEN sam.Segment ='Sams TOF - All Visits Funnel Segment' THEN 'TOF - All Visits'
WHEN sam.Segment ='Sams TOF - Cart Visits Funnel Segment' THEN 'TOF - Cart Visits'
END AS 'Segment Category',
'Sams US' AS Retailer

FROM PROD_BRONZE_DB.RETAIL_DATA.GA_Sams_US_BOF_TOF as sam) AS Main

LEFT JOIN 

(SELECT 
dt.RYear AS 'Staples Year',
dt.RPeriod as 'Staples Period',
dt.RWeekOfYear as 'Staples Week of Year',
dt.RWeekOfPeriod as 'Staples Week of Period',
dt.Date AS 'Date Calendar'

FROM
PROD_BRONZE_DB.MASTER_DATA.dimRDate as dt

WHERE dt.RetailerID =50)  as rd

ON  main.Date=rd.Date Calendar

CREATE VIEW RETAIL_DATA.vStaplesExpressServicePostCards
AS
SELECT 
    Id
      ,Units
      ,Revenue
      ,DiscountAmount
      ,BaseRevenue
      ,ShippingFee
      ,PackSize
      ,TotalPages
      ,ExtraPages
      ,NoOfOrderItems
      ,OrderID
      ,SubOrderID
      ,ExternalOrderID
      ,UserID
      ,RetailerID
      ,AppContextID
      ,AppType
      ,MobileOS
      ,ItemName
      ,PNIProductSKU
      ,PNIProductCategory
      ,PNIProductType
      ,RetailerProductCategory
      ,RetailerProductType
      ,RetailerProductName
      ,ProductCode
      ,DesignCode
      ,DesignerID
      ,ProductOptions
      ,Size
      ,NoOfSurfaces
      ,Orientation
      ,Tags
      ,IsCreateYourOwn
      ,RetailerSKU
      ,PromoCode
      ,PromoDesc
      ,StoreID
      ,Country
      ,State
      ,City
      ,ZipCode
      ,PaymentMethod
      ,ShippingType
      ,Date
      ,CalendarYear
      ,CalendarQuarter
      ,CalendarMonth
      ,CalendarWeek
      ,CalendarDayOfYear
      ,DayOfWeek
      ,PNIYear
      ,PNIQuarter
      ,PNIPeriod
      ,PNIWeek
      ,PNIDayOfYear
      ,RetailerYear
      ,RetailerQuarter
      ,RetailerPeriod
      ,RetailerWeek
      ,RetailerDayOfYear
      ,RetailerName
    
  FROM PROD_BRONZE_DB.RETAIL_DATA.vOrdersSPLUSMacTest
  where (PNIProductSKU = N'PNI_PostCards' OR PNIProductSKU = N'PNI_PostCards_SameDay')
 and Date > '2019-11-21'





CREATE VIEW RETAIL_DATA.vStaplesExpressServicePostCardsv2
AS
select Id = o.fact_id,

       Units = o.quantity,
       Revenue = o.itemTotal,
       DiscountAmount = o.discountTotal,
       BaseRevenue = o.baseItemTotal,
       ShippingFee = o.allocatedShippingFee,
       PackSize = o.packSize,
       TotalPages = isnull(o.TotalPages, 0),
       ExtraPages = isnull(o.ExtraPages, 0), 
       NoOfOrderItems = isnull(o.NoOfOrderItems, 0),
       OrderID = o.orderID,
       SubOrderID = o.subOrderID,
       ExternalOrderID = isnull(o.ExternalOrderID, o.orderID),
       UserID = o.userID,

       RetailerID = o.retailerID,
       AppContextID = a.appContextID,
       AppType = a.appType,
       MobileOS = a.mobileOS,

       ItemName = p.retailerProductName,
       PNIProductSKU = p.SKU,
       PNIProductCategory = p.PNIProductTypeName,
       PNIProductType = p.PNIProductSubTypeName,

       RetailerProductCategory = p.RetailerProductTypeName,
       RetailerProductType = p.RetailerProductSubTypeName,
       RetailerProductName = p.RetailerProductBaseName,

       ProductCode = p.ProductCode,
       DesignCode = p.DesignCode,
       DesignerID = p.DesignerID,

       Size = p.Size,
       NoOfSurfaces = p.NoOfSurfaces,
       Orientation = p.Orientation,

       Tags = p.Tags,
       IsCreateYourOwn = p.IsCreateYourOwn,

	   CASE 
	   WHEN p.SKU IN ('PNI_PostCards_SameDay',  'PNI_PostCards') THEN 'PostCards'
	   WHEN p.SKU IN ('PNI_Banners','PNI_Banners_SameDay') THEN 'Banners'
	   WHEN p.SKU IN ('PNI_Brochure', 'PNI_Brochure_SameDay', 'PNI_Brochures','PNI_Brochures_SameDay') THEN 'Brochures'
	   WHEN p.SKU IN ('PNI_BusinessCards', 'PNI_BusinessCards_SameDay') THEN 'Business Cards'
	   WHEN p.SKU ='PX_Greeting_Card_01' THEN 'Greeting Cards'
	   WHEN p.SKU IN ('PNI_Flyers', 'PNI_Flyers_SameDay') THEN 'Flyers'
	   WHEN p.SKU IN ('PNI_ReturnAddress_Labels','PNI_ReturnAddress_Labels_SameDay') THEN 'Return Address Labels'
	   WHEN p.SKU IN ('PNI_Posters', 'PNI_Posters_SameDay') THEN 'Posters'
	   WHEN p.SKU IN ('PNI_PreInking_Stamps', 'PNI_Stamps_SameDay') THEN 'PreInking Stamps'
	   END AS Category,

       RetailerSKU = s.RetailerSKU,

       PromoCode = po.promoCode,
       PromoDesc = po.description,

       StoreID = d.retailerStoreID,
       Country = d.country_abbrev,
       State = d.state_abbrev,
       City = d.city,
       ZipCode = d.zip,

       PaymentMethod = py.PaymentMethod,
       ShippingType = sh.ShippingType,

       Date = dt.Date,

       CalendarYear = dt.Year,
       CalendarQuarter = dt.Quarter,
       CalendarMonth = dt.Month,
       CalendarWeek = dt.WeekOfYear,
       CalendarDayOfYear = dt.DayOfYear,

       DayOfWeek = left(dt.DayOfWeek,3),

       PNIYear = rd.RYear,
       PNIQuarter = rd.RQuarter,
       PNIPeriod = rd.RPeriod,
       PNIWeek = rd.RWeekOfYear,
       PNIDayOfYear = rd.RDayOfYear,
	   PNIWeekOfPeriod=rd.RWeekOfPeriod,

       RetailerYear = case when rd.RYear = 0 then dt.Year else rd.RYear end,
       RetailerQuarter = case when rd.RQuarter = 0 then dt.Quarter else rd.RQuarter end,
       RetailerPeriod = case when rd.RPeriod = 0 then dt.Month else rd.RPeriod end,
       RetailerWeek = case when rd.RWeekOfYear = 0 then dt.WeekOfYear else rd.RWeekOfYear end,
       RetailerDayOfYear = case when rd.RDayOfYear = 0 then dt.Day else rd.RDayOfYear end,
       RetailerName = r.retailerName,

	   del.deliveryCategory AS Delivery_Category,
	   CASE 
	   WHEN del.deliveryCategory = N'Express Delivery' THEN 'Express'
	   WHEN del.deliveryCategory = N'one business day' THEN 'Standard'
	   ELSE 'Ship to Home'
	   END AS Delivery_Type,
	   o.checkoutDateTime,
	   del.deliveryCategoryID AS 'Delivery Category ID',
	   o.isRIK AS ISRIK,
	   rd.RWeekOfPeriod AS 'Week of Period',
	   CASE 
	   
	   WHEN o.isResubmit= 1 THEN 'Resubmit'
	   WHEN ISNULL(o.isResubmit,0) = 0 THEN 'Not Resubmited'
	   END As Resubmit,
	   o.isPayInStore AS PayinStore
	
	 
	

  from PROD_BRONZE_DB..factOrder o with(nolock)
       join PROD_BRONZE_DB..dimProduct p with(nolock) on p.dim_product_id = o.dim_product_id
       join PROD_BRONZE_DB..dimApplication a with(nolock) on a.dim_app_id = o.dim_app_id
       join PROD_BRONZE_DB..dimRetailer r with(nolock) on r.dim_retailer_id = o.dim_retailer_id
       join PROD_BRONZE_DB..dimPromo po with(nolock) on po.dim_promo_id = o.dim_promo_id
       join PROD_BRONZE_DB..dimDestination d with(nolock) on d.dim_dest_id = o.dim_dest_id
       join PROD_BRONZE_DB..dimPayment py with(nolock) on py.dim_payment_id = o.dim_payment_id
       join PROD_BRONZE_DB..dimDate dt with(nolock) on dt.dim_date_ID = o.checkoutdate_id
       join PROD_BRONZE_DB..dimShipping sh with(nolock) on sh.dim_shipping_id = o.dim_shipping_id
       join PROD_BRONZE_DB..dimSku s with(nolock) on s.dim_sku_id = isnull(o.dim_sku_id, -1)
       join PROD_BRONZE_DB..dimRDate rd with(nolock) on rd.dim_date_id = dt.dim_date_id and rd.retailerID = o.retailerID
	   join PROD_BRONZE_DB..dimDelivery del with(nolock) on o.dim_delivery_id=del.dim_delivery_id
	     LEFT JOIN  PROD_BRONZE_DB.RETAIL_DATA.dimInCompletedSubOrderStatus st
	   ON o.retailerID=st.retailerid and o.orderID=st.orderid and o.subOrderID=st.suborderid
	   LEFT JOIN PROD_BRONZE_DB.RETAIL_DATA.RPT_TestUser as test on o.retailerID=test.retailerid and o.userID=test.userid
	   LEFT JOIN PROD_BRONZE_DB.RETAIL_DATA.dimStatus as sl on st.orderstatusid =sl.orderStatusID AND sl.retailerID =50

 where o.retailerID = 50
   and isnull(o.isTest, 0) = 0
   --and isnull(o.isRIK, 0) = 0 
   and isnull(test.userid,0) =0
   and a.appContextID != 11945004
   and o.fact_id != 224811775  -- wrong one, exclude!
   and o.checkoutDateTime >= '2018-1-1'
   AND p.SKU IN('PNI_PostCards_SameDay',  'PNI_PostCards', 'PNI_Banners','PNI_Banners_SameDay', 'PNI_Brochure', 'PNI_Brochure_SameDay', 'PNI_Brochures'
   ,'PNI_Brochures_SameDay', 'PNI_BusinessCards', 'PNI_BusinessCards_SameDay', 'PX_Greeting_Card_01','PNI_Flyers', 'PNI_Flyers_SameDay', 'PNI_ReturnAddress_Labels',
   'PNI_ReturnAddress_Labels_SameDay', 'PNI_Posters', 'PNI_Posters_SameDay', 'PNI_PreInking_Stamps', 'PNI_Stamps_SameDay')
   AND o.orderID NOT IN (580718134, 580718134, 581431704, 581431959, 581433805
							,581431704
							,581434066
							,581432548
							,581433019
							,581447397
							,581433366
							,581431021
							,581433917
							,581432220
							,581447559
							,581432663
							,581585201
							,581584877
							,581585104) -- Removed out these orders because I think they are test orders not properly flagged

   
--Start with SAMS - Both Business and Consumer, the Start Date is 2018-01-01.


CREATE VIEW  GA_Consolidated 
AS
SELECT *


FROM 




(SELECT 

RETAIL_DATA.GA_SAMSBP_GA_KPI.UserType AS 'User Type',
RETAIL_DATA.GA_SAMSBP_GA_KPI.DeviceCategory AS 'Device Category',
RETAIL_DATA.GA_SAMSBP_GA_KPI.ChannelGrouping AS 'Traffic Channel',
CONVERT(date,RETAIL_DATA.GA_SAMSBP_GA_KPI.Date) AS Date,
RETAIL_DATA.GA_SAMSBP_GA_KPI.Users AS Users,
RETAIL_DATA.GA_SAMSBP_GA_KPI.Sessions AS 'Sessions',
RETAIL_DATA.GA_SAMSBP_GA_KPI.Bounces AS Bounces,
RETAIL_DATA.GA_SAMSBP_GA_KPI.Transactions AS Transactions,
RETAIL_DATA.GA_SAMSBP_GA_KPI.TransactionRevenue AS 'Transaction Revenue',
'SamsClub BP' AS Retailer

FROM RETAIL_DATA.GA_SAMSBP_GA_KPI

UNION ALL 
  
--Sams Consumer GA Data the start date is 2018-01-01.
  
SELECT 
RETAIL_DATA.GA_SAMUS_GA_KPI.UserType AS 'User Type',
RETAIL_DATA.GA_SAMUS_GA_KPI.DeviceCategory AS 'Device Category',
RETAIL_DATA.GA_SAMUS_GA_KPI.ChannelGrouping AS 'Traffic Channel',
CONVERT(date,RETAIL_DATA.GA_SAMUS_GA_KPI.Date) AS Date,
RETAIL_DATA.GA_SAMUS_GA_KPI.Users AS Users,
RETAIL_DATA.GA_SAMUS_GA_KPI.Sessions AS 'Sessions',
RETAIL_DATA.GA_SAMUS_GA_KPI.Bounces AS Bounces,
RETAIL_DATA.GA_SAMUS_GA_KPI.Transactions AS Transactions,
RETAIL_DATA.GA_SAMUS_GA_KPI.TransactionRevenue AS 'Transaction Revenue',
'SamsClub' AS Retailer

FROM RETAIL_DATA.GA_SAMUS_GA_KPI

UNION ALL

--Adding Staples US to the dataset. the start date is 2018-01-01.

SELECT 

RETAIL_DATA.GA_SPLUS_KPI_GA.UserType AS 'User Type',
RETAIL_DATA.GA_SPLUS_KPI_GA.DeviceCategory AS 'Device Category',
RETAIL_DATA.GA_SPLUS_KPI_GA.ChannelGrouping	AS 'Traffic Channel',
CONVERT(date,RETAIL_DATA.GA_SPLUS_KPI_GA.Date)  AS Date,
RETAIL_DATA.GA_SPLUS_KPI_GA.Users AS Users,
RETAIL_DATA.GA_SPLUS_KPI_GA.Sessions AS 'Sessions' ,
RETAIL_DATA.GA_SPLUS_KPI_GA.Bounces AS Bounces,
RETAIL_DATA.GA_SPLUS_KPI_GA.Transactions AS Transactions,
RETAIL_DATA.GA_SPLUS_KPI_GA.TransactionRevenue AS 'Transaction Revenue',
'Staples US' AS Retailer

FROM RETAIL_DATA.GA_SPLUS_KPI_GA

UNION ALL 

--Now the tricky part. The previous analyst added this retroactive load that adds the data from this retroactive GA table (not sure where they got the data from or why this is used, just replicatiing this)

SELECT 

RETAIL_DATA.GA_COSCA_KPI_GA.UserType AS 'User Type',
RETAIL_DATA.GA_COSCA_KPI_GA.DeviceCategory AS 'Device Category',
RETAIL_DATA.GA_COSCA_KPI_GA.ChannelGrouping AS 'Traffic Channel',
CONVERT(date,RETAIL_DATA.GA_COSCA_KPI_GA.Date)   AS Date,

CASE WHEN CONVERT(date,RETAIL_DATA.GA_COSCA_KPI_GA.Date) <'2019-06-10' then RA_GA.Users ELSE RETAIL_DATA.GA_COSCA_KPI_GA.Users END AS Users,
CASE WHEN CONVERT(date,RETAIL_DATA.GA_COSCA_KPI_GA.Date) <'2019-06-10' then RA_GA.Sessions ELSE RETAIL_DATA.GA_COSCA_KPI_GA.Sessions END AS 'Sessions',
CASE WHEN CONVERT(date,RETAIL_DATA.GA_COSCA_KPI_GA.Date) <'2019-06-10' then RA_GA.Bounces ELSE RETAIL_DATA.GA_COSCA_KPI_GA.Bounces END AS Bounces,
CASE WHEN CONVERT(date,RETAIL_DATA.GA_COSCA_KPI_GA.Date) <'2019-06-10' then RA_GA.Transactions else RETAIL_DATA.GA_COSCA_KPI_GA.Transactions END as Transactions,
CASE WHEN CONVERT(date,RETAIL_DATA.GA_COSCA_KPI_GA.Date) <'2019-06-10' then RA_GA.Transaction Revenue ELSE  RETAIL_DATA.GA_COSCA_KPI_GA.TransactionRevenue end as 'Transaction Revenue',
'Costco CA' AS Retailer

FROM RETAIL_DATA.GA_COSCA_KPI_GA
LEFT JOIN 

(SELECT 
	RETAIL_DATA.COSTCO_GA_RETROACTIVE_LOAD.User Type AS 'User Type',
	RETAIL_DATA.COSTCO_GA_RETROACTIVE_LOAD.Device Category AS 'Device Category',
	RETAIL_DATA.COSTCO_GA_RETROACTIVE_LOAD.Traffic Channel AS 'Traffic Channel',
	RETAIL_DATA.COSTCO_GA_RETROACTIVE_LOAD.Date AS 'Date',
	ISNULL(RETAIL_DATA.COSTCO_GA_RETROACTIVE_LOAD.Users,0) AS Users,
	ISNULL(RETAIL_DATA.COSTCO_GA_RETROACTIVE_LOAD.Sessions,0) AS 'Sessions',
	ISNULL(RETAIL_DATA.COSTCO_GA_RETROACTIVE_LOAD.Bounces,0) AS Bounces,
	ISNULL(RETAIL_DATA.COSTCO_GA_RETROACTIVE_LOAD.Transactions,0) AS Transactions,
	ISNULL(RETAIL_DATA.COSTCO_GA_RETROACTIVE_LOAD.Revenue,0) AS 'Transaction Revenue'


FROM RETAIL_DATA.COSTCO_GA_RETROACTIVE_LOAD

WHERE RETAIL_DATA.COSTCO_GA_RETROACTIVE_LOAD.Retailer = 'Costco CA') AS RA_GA
ON CONVERT(date,RETAIL_DATA.GA_COSCA_KPI_GA.Date) = RA_GA.Date AND RETAIL_DATA.GA_COSCA_KPI_GA.UserType=RA_GA.User Type AND RETAIL_DATA.GA_COSCA_KPI_GA.DeviceCategory=RA_GA.Device Category AND RETAIL_DATA.GA_COSCA_KPI_GA.ChannelGrouping=RA_GA.Traffic Channel

-- COSTCO US TO Follow Same Issue like before here

UNION ALL 

SELECT 

RETAIL_DATA.GA_COSUS_KPI_GA.UserType AS 'User Type',
RETAIL_DATA.GA_COSUS_KPI_GA.DeviceCategory AS 'Device Category',
RETAIL_DATA.GA_COSUS_KPI_GA.ChannelGrouping AS 'Traffic Channel',
CONVERT(date, RETAIL_DATA.GA_COSUS_KPI_GA.Date) AS 'Date',
CASE WHEN CONVERT(date, RETAIL_DATA.GA_COSUS_KPI_GA.Date) < '2019-06-10' THEN RA_GA_US.Users ELSE RETAIL_DATA.GA_COSUS_KPI_GA.Users END AS Users,
CASE WHEN CONVERT(date, RETAIL_DATA.GA_COSUS_KPI_GA.Date) < '2019-06-10' THEN RA_GA_US.Sessions ELSE RETAIL_DATA.GA_COSUS_KPI_GA.Sessions END AS 'Sessions',
CASE WHEN CONVERT(date, RETAIL_DATA.GA_COSUS_KPI_GA.Date) < '2019-06-10' THEN RA_GA_US.Bounces ELSE RETAIL_DATA.GA_COSUS_KPI_GA.Bounces END AS Bounces,
CASE WHEN CONVERT(date, RETAIL_DATA.GA_COSUS_KPI_GA.Date) < '2019-06-10' THEN RA_GA_US.Transactions ELSE RETAIL_DATA.GA_COSUS_KPI_GA.Transactions END AS Transactions,
CASE WHEN CONVERT(date, RETAIL_DATA.GA_COSUS_KPI_GA.Date) < '2019-06-10' THEN RA_GA_US.Transaction Revenue ELSE RETAIL_DATA.GA_COSUS_KPI_GA.TransactionRevenue END AS 'Transaction Revenue',
'Costco US' AS Retailer



FROM RETAIL_DATA.GA_COSUS_KPI_GA

LEFT JOIN 
(SELECT 
	RETAIL_DATA.COSTCO_GA_RETROACTIVE_LOAD.User Type AS 'User Type',
	RETAIL_DATA.COSTCO_GA_RETROACTIVE_LOAD.Device Category AS 'Device Category',
	RETAIL_DATA.COSTCO_GA_RETROACTIVE_LOAD.Traffic Channel AS 'Traffic Channel',
	RETAIL_DATA.COSTCO_GA_RETROACTIVE_LOAD.Date AS 'Date',
	ISNULL(RETAIL_DATA.COSTCO_GA_RETROACTIVE_LOAD.Users,0) AS Users,
	ISNULL(RETAIL_DATA.COSTCO_GA_RETROACTIVE_LOAD.Sessions,0) AS 'Sessions',
	ISNULL(RETAIL_DATA.COSTCO_GA_RETROACTIVE_LOAD.Bounces,0) AS Bounces,
	ISNULL(RETAIL_DATA.COSTCO_GA_RETROACTIVE_LOAD.Transactions,0) AS Transactions,
	ISNULL(RETAIL_DATA.COSTCO_GA_RETROACTIVE_LOAD.Revenue,0) AS 'Transaction Revenue'


FROM RETAIL_DATA.COSTCO_GA_RETROACTIVE_LOAD

WHERE RETAIL_DATA.COSTCO_GA_RETROACTIVE_LOAD.Retailer = 'Costco US') AS RA_GA_US

ON CONVERT(date, RETAIL_DATA.GA_COSUS_KPI_GA.Date)=RA_GA_US.Date AND RETAIL_DATA.GA_COSUS_KPI_GA.UserType = RA_GA_US.User Type AND RETAIL_DATA.GA_COSUS_KPI_GA.DeviceCategory=RA_GA_US.Device Category AND RETAIL_DATA.GA_COSUS_KPI_GA.ChannelGrouping=RA_GA_US.Traffic Channel

--Costco US Business PRINT to Follow

UNION ALL 


SELECT 

RETAIL_DATA.GA_COSBP_KPI_GA.UserType AS 'User Type',
RETAIL_DATA.GA_COSBP_KPI_GA.DeviceCategory AS 'Device Category',
RETAIL_DATA.GA_COSBP_KPI_GA.ChannelGrouping AS 'Traffic Channel',
CONVERT(date, RETAIL_DATA.GA_COSBP_KPI_GA.Date) AS 'Date',
CASE WHEN CONVERT(date, RETAIL_DATA.GA_COSBP_KPI_GA.Date) < '2019-06-10' then RA_GA_BP.Users ELSE RETAIL_DATA.GA_COSBP_KPI_GA.Users END AS Users,
CASE WHEN CONVERT(date, RETAIL_DATA.GA_COSBP_KPI_GA.Date) < '2019-06-10' then RA_GA_BP.Sessions ELSE RETAIL_DATA.GA_COSBP_KPI_GA.Sessions END AS 'Sessions',
CASE WHEN CONVERT(date, RETAIL_DATA.GA_COSBP_KPI_GA.Date) < '2019-06-10' then RA_GA_BP.Bounces ELSE RETAIL_DATA.GA_COSBP_KPI_GA.Bounces END AS Bounces,
CASE WHEN CONVERT(date, RETAIL_DATA.GA_COSBP_KPI_GA.Date) < '2019-06-10' then RA_GA_BP.Transactions ELSE RETAIL_DATA.GA_COSBP_KPI_GA.Transactions END AS Transactions,
CASE WHEN CONVERT(date, RETAIL_DATA.GA_COSBP_KPI_GA.Date) < '2019-06-10' then RA_GA_BP.Transaction Revenue ELSE RETAIL_DATA.GA_COSBP_KPI_GA.TransactionRevenue END AS 'Transaction Revenue',
'Costco BP' AS Retailer

FROM 

RETAIL_DATA.GA_COSBP_KPI_GA

LEFT JOIN (
SELECT 
	RETAIL_DATA.COSTCO_GA_RETROACTIVE_LOAD.User Type AS 'User Type',
	RETAIL_DATA.COSTCO_GA_RETROACTIVE_LOAD.Device Category AS 'Device Category',
	RETAIL_DATA.COSTCO_GA_RETROACTIVE_LOAD.Traffic Channel AS 'Traffic Channel',
	RETAIL_DATA.COSTCO_GA_RETROACTIVE_LOAD.Date AS 'Date',
	ISNULL(RETAIL_DATA.COSTCO_GA_RETROACTIVE_LOAD.Users,0) AS Users,
	ISNULL(RETAIL_DATA.COSTCO_GA_RETROACTIVE_LOAD.Sessions,0) AS 'Sessions',
	ISNULL(RETAIL_DATA.COSTCO_GA_RETROACTIVE_LOAD.Bounces,0) AS Bounces,
	ISNULL(RETAIL_DATA.COSTCO_GA_RETROACTIVE_LOAD.Transactions,0) AS Transactions,
	ISNULL(RETAIL_DATA.COSTCO_GA_RETROACTIVE_LOAD.Revenue,0) AS 'Transaction Revenue'


FROM RETAIL_DATA.COSTCO_GA_RETROACTIVE_LOAD

WHERE RETAIL_DATA.COSTCO_GA_RETROACTIVE_LOAD.Retailer ='Costco BP') AS RA_GA_BP
ON CONVERT(date,RETAIL_DATA.GA_COSBP_KPI_GA.Date) = RA_GA_BP.Date AND  RETAIL_DATA.GA_COSBP_KPI_GA.UserType = RA_GA_BP.User Type AND RETAIL_DATA.GA_COSBP_KPI_GA.DeviceCategory = RA_GA_BP.Device Category AND RETAIL_DATA.GA_COSBP_KPI_GA.ChannelGrouping = RA_GA_BP.Traffic Channel) AS GA

LEFT JOIN 



(SELECT 
		RETAIL_DATA.Costco CAL REF 2020.Date AS 'Costco Date',
		RETAIL_DATA.Costco CAL REF 2020.Costco Day AS 'Costco Day',
		RETAIL_DATA.Costco CAL REF 2020.Costco Period AS 'Costco Period',
		RETAIL_DATA.Costco CAL REF 2020.Costco Period Name AS 'Costco Period Name',
		RETAIL_DATA.Costco CAL REF 2020.Costco Quarter AS 'Costco Quarter',
		RETAIL_DATA.Costco CAL REF 2020.Costco Quarter Name AS 'Costco Quarter Name',
		RETAIL_DATA.Costco CAL REF 2020.Costco Week AS 'Costco Week',
		RETAIL_DATA.Costco CAL REF 2020.Costco Week Name AS ' Costco Week Name',
		RETAIL_DATA.Costco CAL REF 2020.Costco Year AS 'Costco Year'

FROM RETAIL_DATA.Costco CAL REF 2020) AS Costco_Cal

ON GA.Date = Costco_Cal.Costco Date

LEFT JOIN 

(SELECT RETAIL_DATA.SAMUSCALREF.Costco_Day AS 'Sams Day',
		RETAIL_DATA.SAMUSCALREF.Costco_Period AS 'Sams Period',
		RETAIL_DATA.SAMUSCALREF.Costco_Period_Name AS 'Sams Period Name',
		RETAIL_DATA.SAMUSCALREF.Costco_Quarter AS 'Sams Quarter',
		RETAIL_DATA.SAMUSCALREF.Costco_Quarter_Name AS 'Sams Quarter Namer',
		RETAIL_DATA.SAMUSCALREF.Costco_Week AS 'Sams Week',
		RETAIL_DATA.SAMUSCALREF.Costco_Week_Name AS 'Sams Week Name',
		RETAIL_DATA.SAMUSCALREF.Costco_Year AS 'Sams Year',
		RETAIL_DATA.SAMUSCALREF.Day_of_Date AS 'Day of Date Sams',
		RETAIL_DATA.SAMUSCALREF.PNI_Period AS 'PNI Period',
		RETAIL_DATA.SAMUSCALREF.PNI_Day as 'PNI Day',
		RETAIL_DATA.SAMUSCALREF.PNI_Period_Name AS 'PNI Period Name',
		RETAIL_DATA.SAMUSCALREF.PNI_Quarter AS 'PNI Quarter',
		RETAIL_DATA.SAMUSCALREF.PNI_Quarter_Name AS 'PNI Quarter Name',
		RETAIL_DATA.SAMUSCALREF.PNI_Week AS 'PNI Week',
		RETAIL_DATA.SAMUSCALREF.PNI_Week_Name AS 'PNI Week Name',
		RETAIL_DATA.SAMUSCALREF.PNI_Week_Name AS 'PNI Year'


FROM RETAIL_DATA.SAMUSCALREF) AS SAM_CAL
ON GA.Date = SAM_CAL.Day of Date Sams



CREATE VIEW  RETAIL_DATA.vGA_Consolidatedv2
AS
SELECT *


FROM 




((SELECT 

RETAIL_DATA.GA_SAMSBP_GA_KPI.UserType AS 'User Type',
RETAIL_DATA.GA_SAMSBP_GA_KPI.DeviceCategory AS 'Device Category',
RETAIL_DATA.GA_SAMSBP_GA_KPI.ChannelGrouping AS 'Traffic Channel',
CONVERT(date,RETAIL_DATA.GA_SAMSBP_GA_KPI.Date) AS Date,
RETAIL_DATA.GA_SAMSBP_GA_KPI.Users AS Users,
RETAIL_DATA.GA_SAMSBP_GA_KPI.Sessions AS 'Sessions',
RETAIL_DATA.GA_SAMSBP_GA_KPI.Bounces AS Bounces,
RETAIL_DATA.GA_SAMSBP_GA_KPI.Transactions AS Transactions,
RETAIL_DATA.GA_SAMSBP_GA_KPI.TransactionRevenue AS 'Transaction Revenue',
'SamsClub BP' AS Retailer

FROM RETAIL_DATA.GA_SAMSBP_GA_KPI)

UNION ALL 
  
--Sams Consumer GA Data the start date is 2018-01-01.
  
(SELECT 
RETAIL_DATA.GA_SAMUS_GA_KPI.UserType AS 'User Type',
RETAIL_DATA.GA_SAMUS_GA_KPI.DeviceCategory AS 'Device Category',
RETAIL_DATA.GA_SAMUS_GA_KPI.ChannelGrouping AS 'Traffic Channel',
CONVERT(date,RETAIL_DATA.GA_SAMUS_GA_KPI.Date) AS Date,
RETAIL_DATA.GA_SAMUS_GA_KPI.Users AS Users,
RETAIL_DATA.GA_SAMUS_GA_KPI.Sessions AS 'Sessions',
RETAIL_DATA.GA_SAMUS_GA_KPI.Bounces AS Bounces,
RETAIL_DATA.GA_SAMUS_GA_KPI.Transactions AS Transactions,
RETAIL_DATA.GA_SAMUS_GA_KPI.TransactionRevenue AS 'Transaction Revenue',
'SamsClub' AS Retailer

FROM RETAIL_DATA.GA_SAMUS_GA_KPI)

UNION ALL

--Adding Staples US to the dataset. the start date is 2018-01-01.

(SELECT 

RETAIL_DATA.GA_SPLUS_KPI_Design_Hercules_Split.UserType AS 'User Type',
RETAIL_DATA.GA_SPLUS_KPI_Design_Hercules_Split.DeviceCategory AS 'Device Category',
RETAIL_DATA.GA_SPLUS_KPI_Design_Hercules_Split.ChannelGrouping	AS 'Traffic Channel',
CONVERT(date,RETAIL_DATA.GA_SPLUS_KPI_Design_Hercules_Split.Date)  AS Date,
RETAIL_DATA.GA_SPLUS_KPI_Design_Hercules_Split.Users AS Users,
RETAIL_DATA.GA_SPLUS_KPI_Design_Hercules_Split.Sessions AS 'Sessions' ,
RETAIL_DATA.GA_SPLUS_KPI_Design_Hercules_Split.Bounces AS Bounces,
RETAIL_DATA.GA_SPLUS_KPI_Design_Hercules_Split.Transactions AS Transactions,
RETAIL_DATA.GA_SPLUS_KPI_Design_Hercules_Split.TransactionRevenue AS 'Transaction Revenue',
CASE
WHEN RETAIL_DATA.GA_SPLUS_KPI_Design_Hercules_Split.Segment = 'Design Sessions(DO NOT EDIT - USED FOR API)' THEN 'Staples US'
WHEN RETAIL_DATA.GA_SPLUS_KPI_Design_Hercules_Split.Segment ='Hercules Sessions(DO NOT EDIT - USED FOR API)' THEN 'Staples US Business Printing'
END as Retailer

FROM RETAIL_DATA.GA_SPLUS_KPI_Design_Hercules_Split


)

UNION ALL 

--Now the tricky part. The previous analyst added this retroactive load that adds the data from this retroactive GA table (not sure where they got the data from or why this is used, just replicatiing this)

(SELECT 

RETAIL_DATA.GA_COSCA_KPI_GA.UserType AS 'User Type',
RETAIL_DATA.GA_COSCA_KPI_GA.DeviceCategory AS 'Device Category',
RETAIL_DATA.GA_COSCA_KPI_GA.ChannelGrouping AS 'Traffic Channel',
CONVERT(date,RETAIL_DATA.GA_COSCA_KPI_GA.Date)   AS Date,

CASE WHEN CONVERT(date,RETAIL_DATA.GA_COSCA_KPI_GA.Date) <'2019-06-10' then RA_GA.Users ELSE RETAIL_DATA.GA_COSCA_KPI_GA.Users END AS Users,
CASE WHEN CONVERT(date,RETAIL_DATA.GA_COSCA_KPI_GA.Date) <'2019-06-10' then RA_GA.Sessions ELSE RETAIL_DATA.GA_COSCA_KPI_GA.Sessions END AS 'Sessions',
CASE WHEN CONVERT(date,RETAIL_DATA.GA_COSCA_KPI_GA.Date) <'2019-06-10' then RA_GA.Bounces ELSE RETAIL_DATA.GA_COSCA_KPI_GA.Bounces END AS Bounces,
CASE WHEN CONVERT(date,RETAIL_DATA.GA_COSCA_KPI_GA.Date) <'2019-06-10' then RA_GA.Transactions else RETAIL_DATA.GA_COSCA_KPI_GA.Transactions END as Transactions,
CASE WHEN CONVERT(date,RETAIL_DATA.GA_COSCA_KPI_GA.Date) <'2019-06-10' then RA_GA.Transaction Revenue ELSE  RETAIL_DATA.GA_COSCA_KPI_GA.TransactionRevenue end as 'Transaction Revenue',
'Costco CA' AS Retailer

FROM RETAIL_DATA.GA_COSCA_KPI_GA
LEFT JOIN 

(SELECT 
	RETAIL_DATA.COSTCO_GA_RETROACTIVE_LOAD.User Type AS 'User Type',
	RETAIL_DATA.COSTCO_GA_RETROACTIVE_LOAD.Device Category AS 'Device Category',
	RETAIL_DATA.COSTCO_GA_RETROACTIVE_LOAD.Traffic Channel AS 'Traffic Channel',
	RETAIL_DATA.COSTCO_GA_RETROACTIVE_LOAD.Date AS 'Date',
	ISNULL(RETAIL_DATA.COSTCO_GA_RETROACTIVE_LOAD.Users,0) AS Users,
	ISNULL(RETAIL_DATA.COSTCO_GA_RETROACTIVE_LOAD.Sessions,0) AS 'Sessions',
	ISNULL(RETAIL_DATA.COSTCO_GA_RETROACTIVE_LOAD.Bounces,0) AS Bounces,
	ISNULL(RETAIL_DATA.COSTCO_GA_RETROACTIVE_LOAD.Transactions,0) AS Transactions,
	ISNULL(RETAIL_DATA.COSTCO_GA_RETROACTIVE_LOAD.Revenue,0) AS 'Transaction Revenue'


FROM RETAIL_DATA.COSTCO_GA_RETROACTIVE_LOAD

WHERE RETAIL_DATA.COSTCO_GA_RETROACTIVE_LOAD.Retailer = 'Costco CA') AS RA_GA
ON CONVERT(date,RETAIL_DATA.GA_COSCA_KPI_GA.Date) = RA_GA.Date AND RETAIL_DATA.GA_COSCA_KPI_GA.UserType=RA_GA.User Type AND RETAIL_DATA.GA_COSCA_KPI_GA.DeviceCategory=RA_GA.Device Category AND RETAIL_DATA.GA_COSCA_KPI_GA.ChannelGrouping=RA_GA.Traffic Channel)

-- COSTCO US TO Follow Same Issue like before here

UNION ALL 

(SELECT 

RETAIL_DATA.GA_COSUS_KPI_GA.UserType AS 'User Type',
RETAIL_DATA.GA_COSUS_KPI_GA.DeviceCategory AS 'Device Category',
RETAIL_DATA.GA_COSUS_KPI_GA.ChannelGrouping AS 'Traffic Channel',
CONVERT(date, RETAIL_DATA.GA_COSUS_KPI_GA.Date) AS 'Date',
CASE WHEN CONVERT(date, RETAIL_DATA.GA_COSUS_KPI_GA.Date) < '2019-06-10' THEN RA_GA_US.Users ELSE RETAIL_DATA.GA_COSUS_KPI_GA.Users END AS Users,
CASE WHEN CONVERT(date, RETAIL_DATA.GA_COSUS_KPI_GA.Date) < '2019-06-10' THEN RA_GA_US.Sessions ELSE RETAIL_DATA.GA_COSUS_KPI_GA.Sessions END AS 'Sessions',
CASE WHEN CONVERT(date, RETAIL_DATA.GA_COSUS_KPI_GA.Date) < '2019-06-10' THEN RA_GA_US.Bounces ELSE RETAIL_DATA.GA_COSUS_KPI_GA.Bounces END AS Bounces,
CASE WHEN CONVERT(date, RETAIL_DATA.GA_COSUS_KPI_GA.Date) < '2019-06-10' THEN RA_GA_US.Transactions ELSE RETAIL_DATA.GA_COSUS_KPI_GA.Transactions END AS Transactions,
CASE WHEN CONVERT(date, RETAIL_DATA.GA_COSUS_KPI_GA.Date) < '2019-06-10' THEN RA_GA_US.Transaction Revenue ELSE RETAIL_DATA.GA_COSUS_KPI_GA.TransactionRevenue END AS 'Transaction Revenue',
'Costco US' AS Retailer



FROM RETAIL_DATA.GA_COSUS_KPI_GA

LEFT JOIN 
(SELECT 
	RETAIL_DATA.COSTCO_GA_RETROACTIVE_LOAD.User Type AS 'User Type',
	RETAIL_DATA.COSTCO_GA_RETROACTIVE_LOAD.Device Category AS 'Device Category',
	RETAIL_DATA.COSTCO_GA_RETROACTIVE_LOAD.Traffic Channel AS 'Traffic Channel',
	RETAIL_DATA.COSTCO_GA_RETROACTIVE_LOAD.Date AS 'Date',
	ISNULL(RETAIL_DATA.COSTCO_GA_RETROACTIVE_LOAD.Users,0) AS Users,
	ISNULL(RETAIL_DATA.COSTCO_GA_RETROACTIVE_LOAD.Sessions,0) AS 'Sessions',
	ISNULL(RETAIL_DATA.COSTCO_GA_RETROACTIVE_LOAD.Bounces,0) AS Bounces,
	ISNULL(RETAIL_DATA.COSTCO_GA_RETROACTIVE_LOAD.Transactions,0) AS Transactions,
	ISNULL(RETAIL_DATA.COSTCO_GA_RETROACTIVE_LOAD.Revenue,0) AS 'Transaction Revenue'


FROM RETAIL_DATA.COSTCO_GA_RETROACTIVE_LOAD

WHERE RETAIL_DATA.COSTCO_GA_RETROACTIVE_LOAD.Retailer = 'Costco US') AS RA_GA_US

ON CONVERT(date, RETAIL_DATA.GA_COSUS_KPI_GA.Date)=RA_GA_US.Date AND RETAIL_DATA.GA_COSUS_KPI_GA.UserType = RA_GA_US.User Type AND RETAIL_DATA.GA_COSUS_KPI_GA.DeviceCategory=RA_GA_US.Device Category AND RETAIL_DATA.GA_COSUS_KPI_GA.ChannelGrouping=RA_GA_US.Traffic Channel)

--Costco US Business PRINT to Follow

UNION ALL 


(SELECT 

RETAIL_DATA.GA_COSBP_KPI_GA.UserType AS 'User Type',
RETAIL_DATA.GA_COSBP_KPI_GA.DeviceCategory AS 'Device Category',
RETAIL_DATA.GA_COSBP_KPI_GA.ChannelGrouping AS 'Traffic Channel',
CONVERT(date, RETAIL_DATA.GA_COSBP_KPI_GA.Date) AS 'Date',
CASE WHEN CONVERT(date, RETAIL_DATA.GA_COSBP_KPI_GA.Date) < '2019-06-10' then RA_GA_BP.Users ELSE RETAIL_DATA.GA_COSBP_KPI_GA.Users END AS Users,
CASE WHEN CONVERT(date, RETAIL_DATA.GA_COSBP_KPI_GA.Date) < '2019-06-10' then RA_GA_BP.Sessions ELSE RETAIL_DATA.GA_COSBP_KPI_GA.Sessions END AS 'Sessions',
CASE WHEN CONVERT(date, RETAIL_DATA.GA_COSBP_KPI_GA.Date) < '2019-06-10' then RA_GA_BP.Bounces ELSE RETAIL_DATA.GA_COSBP_KPI_GA.Bounces END AS Bounces,
CASE WHEN CONVERT(date, RETAIL_DATA.GA_COSBP_KPI_GA.Date) < '2019-06-10' then RA_GA_BP.Transactions ELSE RETAIL_DATA.GA_COSBP_KPI_GA.Transactions END AS Transactions,
CASE WHEN CONVERT(date, RETAIL_DATA.GA_COSBP_KPI_GA.Date) < '2019-06-10' then RA_GA_BP.Transaction Revenue ELSE RETAIL_DATA.GA_COSBP_KPI_GA.TransactionRevenue END AS 'Transaction Revenue',
'Costco BP' AS Retailer

FROM 

RETAIL_DATA.GA_COSBP_KPI_GA

LEFT JOIN (
SELECT 
	RETAIL_DATA.COSTCO_GA_RETROACTIVE_LOAD.User Type AS 'User Type',
	RETAIL_DATA.COSTCO_GA_RETROACTIVE_LOAD.Device Category AS 'Device Category',
	RETAIL_DATA.COSTCO_GA_RETROACTIVE_LOAD.Traffic Channel AS 'Traffic Channel',
	RETAIL_DATA.COSTCO_GA_RETROACTIVE_LOAD.Date AS 'Date',
	ISNULL(RETAIL_DATA.COSTCO_GA_RETROACTIVE_LOAD.Users,0) AS Users,
	ISNULL(RETAIL_DATA.COSTCO_GA_RETROACTIVE_LOAD.Sessions,0) AS 'Sessions',
	ISNULL(RETAIL_DATA.COSTCO_GA_RETROACTIVE_LOAD.Bounces,0) AS Bounces,
	ISNULL(RETAIL_DATA.COSTCO_GA_RETROACTIVE_LOAD.Transactions,0) AS Transactions,
	ISNULL(RETAIL_DATA.COSTCO_GA_RETROACTIVE_LOAD.Revenue,0) AS 'Transaction Revenue'


FROM RETAIL_DATA.COSTCO_GA_RETROACTIVE_LOAD

WHERE RETAIL_DATA.COSTCO_GA_RETROACTIVE_LOAD.Retailer ='Costco BP') AS RA_GA_BP
ON CONVERT(date,RETAIL_DATA.GA_COSBP_KPI_GA.Date) = RA_GA_BP.Date AND  RETAIL_DATA.GA_COSBP_KPI_GA.UserType = RA_GA_BP.User Type AND RETAIL_DATA.GA_COSBP_KPI_GA.DeviceCategory = RA_GA_BP.Device Category AND RETAIL_DATA.GA_COSBP_KPI_GA.ChannelGrouping = RA_GA_BP.Traffic Channel)) AS GA

LEFT JOIN 



(SELECT	
	rtdc.RYear AS Costco Year,
	rtdc.RWeekOfYear AS Costco Week,
	rtdc.RPeriod AS Costco Period,
	rtdc.RWeekOfPeriod AS Costco Week of Period,
	rtdc.RDayOfYear AS Costco Day of Year,
	rtdc.RQuarter AS Costco Quarter,
	rtdc.Date AS DateC

FROM PROD_BRONZE_DB.MASTER_DATA.dimRDate as rtdc WHERE rtdc.RetailerID = 27

) AS Costco_Cal

ON GA.Date = Costco_Cal.DateC

LEFT JOIN 

(SELECT	
	rtdsc.RYear AS SAMS Year,
	rtdsc.RWeekOfYear AS SAMS Week,
	rtdsc.RPeriod AS SAMS Period,
	rtdsc.RWeekOfPeriod AS SAMS Week of Period,
	rtdsc.RDayOfYear AS SAMS Day of Year,
	rtdsc.RQuarter AS SAMS Quarter,
	rtdsc.Date AS DateS

FROM PROD_BRONZE_DB.MASTER_DATA.dimRDate as rtdsc WHERE rtdsc.RetailerID = 26) AS SAM_CAL
ON GA.Date = SAM_CAL.DateS

LEFT JOIN 

(SELECT PROD_BRONZE_DB.MASTER_DATA.dimRDate.Date AS 'Date_R',
		PROD_BRONZE_DB.MASTER_DATA.dimRDate.RYear AS 'PNI Year',
		PROD_BRONZE_DB.MASTER_DATA.dimRDate.RPeriod AS 'PNI Period',
		PROD_BRONZE_DB.MASTER_DATA.dimRDate.RDayOfYear AS 'PNI Day of Year',
		PROD_BRONZE_DB.MASTER_DATA.dimRDate.RQuarter AS 'PNI Quarter',
		PROD_BRONZE_DB.MASTER_DATA.dimRDate.RWeekOfYear AS 'PNI Week',
		PROD_BRONZE_DB.MASTER_DATA.dimRDate.RWeekOfPeriod as 'Week of Period'

  FROM PROD_BRONZE_DB.MASTER_DATA.dimRDate
  WHERE PROD_BRONZE_DB.MASTER_DATA.dimRDate.RetailerID = 50) AS Retailer_Cal

  ON GA.Date = Retailer_Cal.Date_R

create view ga.vGeneralReport
as

select gr.id,
       gr.date,
       gr.retailerID,
       gr.userType,
       gr.deviceCategory,
       gr.channelGrouping,
       gr.users,
       gr.newUsers,
       gr.sessions,
       gr.bounces,
       gr.transactions,
       gr.transactionRevenue,

       r.retailerName,
       d.staplesDayOfYear,
       d.staplesMonthOfYear,
       d.staplesQuarter,
       d.staplesWeekOfYear,
       d.staplesYear
  from ga.GeneralReport gr
       join dimDate d on d.Date = gr.date
       join dimRetailer r on r.retailerID = gr.retailerID
CREATE view RETAIL_DATA.vFactOrderAllByDay50
as
select o.Id,
       o.retailerID,
       o.appContextID,
       o.quantity,
       o.itemTotal,
       o.discountTotal,
       o.baseItemTotal,
       o.allocatedShippingFee,
       o.allocatedTax,
       o.packSize,
       o.orders,
       o.suborders,

       p.retailerProductName,
       p.SKU,
       p.PNIProductTypeName,
       p.ProductDesign,
       p.ProductCode,
       p.ProductDesc,
       p.Size,
       p.NoOfSurfaces,
       p.Orientation,
       p.PNIProductSubTypeName,
       p.DesignCode,

       a.appVersionID,
       a.appVerNotes,
       a.appServerID,
       a.appServerDesc,
       a.consumerName,
       appDescription = a.Description,
       a.appType,

       r.retailerName,

       po.promoCode,

       d.retailerStoreID,
       d.country_abbrev,
       d.state_abbrev,
       d.city,
       d.zip,

       v.vendor,

       py.provider,

       dt.Date,
       dt.Day,
       dt.DayOfWeek,
       dt.DayOfYear,
       dt.WeekOfYear,
       dt.Month,
       dt.Quarter,
       dt.Year,

       dt.PNIYear,
       dt.PNIQuarter,

       dt.SYear,
       dt.SQuarter,
       dt.SMonthOfYear,
       dt.SWeekOfYear,
       dt.SDayOfYear,

       dt.staplesYear,
       dt.staplesQuarter,
       dt.staplesMonthOfYear,
       dt.staplesWeekOfYear,
       dt.staplesDayOfYear,

       dt.costcoYear,
       dt.costcoQuarter,
       dt.costcoPeriod,
       dt.costcoWeek,
       dt.costcoDay

  from FactOrderDaily50 o
       join dimProduct p on p.dim_product_id = o.dim_product_id
       join dimApplication a on a.dim_app_id = o.dim_app_id
       join dimRetailer r on r.dim_retailer_id = o.dim_retailer_id
       join dimPromo po on po.dim_promo_id = o.dim_promo_id
       join dimDestination d on d.dim_dest_id = o.dim_dest_id
       join dimVendor v on v.dim_vendor_id = o.dim_vendor_id
       join dimPayment py on py.dim_payment_id = o.dim_payment_id
       join dimDate dt on dt.dim_date_ID = o.checkoutdate_id

/****** Script for SelectTopNRows command from SSMS  ******/

CREATE VIEW RETAIL_DATA.vUsersSamsUS_BP as
SELECT
       RetailerName
	  ,UserID
      ,count(distinct OrderID) as Orders
	  ,SUM(Revenue) as Revenue
	  ,CASE 
		WHEN count(distinct OrderID)= 1 then '1 Order'
		WHEN count(distinct OrderID)= 2 then '2 Orders'
		WHEN count(distinct OrderID)= 3 then '3 Orders'
		WHEN count(distinct OrderID)= 4 then '4 Orders'
		WHEN count(distinct OrderID)= 5 then '5 Orders'
		WHEN count(distinct OrderID)= 6 then '6 Orders'
		WHEN count(distinct OrderID)= 7 then '7 Orders'
		WHEN count(distinct OrderID)= 8 then '8 Orders'
		WHEN count(distinct OrderID)>= 9 then '9+ Orders'
		END AS OrderFreq
  FROM PROD_BRONZE_DB.RETAIL_DATA.vOrdersSAMUS_BP 
  WHERE convert(date,date) >= (select dateadd(day,-364,max(convert(date,date))) from PROD_BRONZE_DB.RETAIL_DATA.vOrdersCOSUS )
  GROUP BY RetailerName,UserID,NoOfOrderItems
CREATE view RETAIL_DATA.vFactOrderAll2
as
select o.fact_id,
       o.retailerID,
       o.orderID,
       o.subOrderID,
       o.appContextID,
       o.checkoutDateTime,
       o.quantity,
       o.itemTotal,
       o.discountTotal,
       o.baseItemTotal,
       o.allocatedShippingFee,
       o.allocatedTax,
       o.userID,
       o.packSize,
       o.TotalPages,
       o.ExtraPages,
       o.NoOfOrderItems,

       p.retailerProductName,
       p.SKU,
       p.PNIProductTypeName,
       p.ProductDesign,
       p.ProductCode,
       p.ProductDesc,
       p.Size,
       p.NoOfSurfaces,
       p.Orientation,
       p.PNIProductSubTypeName,
       p.DesignCode,

       a.appVersionID,
       a.appVerNotes,
       a.appServerID,
       a.appServerDesc,
       a.consumerName,
       appDescription = a.Description,
       a.appType,

       r.retailerName,

       po.promoCode,

       d.retailerStoreID,
       d.country_abbrev,
       d.state_abbrev,
       d.city,
       d.zip,

       v.vendor,

       py.provider,

       dt.Day,
       dt.DayOfWeek,
       dt.DayOfYear,
       dt.WeekOfYear,
       dt.Month,
       dt.Quarter,
       dt.Year,

       dt.PNIYear,
       dt.PNIQuarter,

       dt.CostcoYear,
       dt.CostcoPeriod,
       dt.CostcoWeek,
       dt.CostcoWeekStartdt,
       dt.CostcoWeekEnddt,

       dt.SYear,
       dt.SQuarter,
       dt.SMonthOfYear,
       dt.SWeekOfYear,
       dt.SDayOfYear,

       dt.staplesDayOfYear,
       dt.staplesMonthOfYear,
       dt.staplesQuarter,
       dt.staplesWeekOfYear,
       dt.staplesYear,

       p.Theme,
       p.Cover,
       p.Category

  from factOrder o
       join dimProduct p on p.dim_product_id = o.dim_product_id
       join dimApplication a on a.dim_app_id = o.dim_app_id
       join dimRetailer r on r.dim_retailer_id = o.dim_retailer_id
       join dimPromo po on po.dim_promo_id = o.dim_promo_id
       join dimDestination d on d.dim_dest_id = o.dim_dest_id
       join dimVendor v on v.dim_vendor_id = o.dim_vendor_id
       join dimPayment py on py.dim_payment_id = o.dim_payment_id
       join dimDate dt on dt.dim_date_ID = o.checkoutdate_id
 where o.retailerID in (2,26,27,50,51,53) 
   and o.fact_id != 224811775
   and o.checkoutDateTime >= '2016-07-01'--'2014-09-01'
   and (o.isTest is null or o.isTest = 0)
   and (o.retailerID != 50 or isnull(o.isRIK,0) = 0)
   and (o.retailerID != 50 or a.appContextID != 11945004)
CREATE VIEW RETAIL_DATA.vOrdersSPLUS
as
select Id = o.fact_id,

       Units = o.quantity,
       Revenue = o.itemTotal,
       DiscountAmount = o.discountTotal,
       BaseRevenue = o.baseItemTotal,
       ShippingFee = o.allocatedShippingFee,
       PackSize = o.packSize,
       TotalPages = isnull(o.TotalPages, 0),
       ExtraPages = isnull(o.ExtraPages, 0), 
       NoOfOrderItems = isnull(o.NoOfOrderItems, 0),
       OrderID = o.orderID,
       SubOrderID = o.subOrderID,
       ExternalOrderID = isnull(o.ExternalOrderID, o.orderID),
       UserID = o.userID,

       RetailerID = o.retailerID,
       AppContextID = a.appContextID,
       AppType = a.appType,
       MobileOS = a.mobileOS,

       ItemName = p.retailerProductName,
       PNIProductSKU = p.SKU,
       PNIProductCategory = p.PNIProductTypeName,
       PNIProductType = p.PNIProductSubTypeName,

       RetailerProductCategory = p.RetailerProductTypeName,
       RetailerProductType = p.RetailerProductSubTypeName,
       RetailerProductName = p.RetailerProductBaseName,

       ProductCode = p.ProductCode,
       DesignCode = p.DesignCode,
       DesignerID = p.DesignerID,

       Size = p.Size,
       NoOfSurfaces = p.NoOfSurfaces,
       Orientation = p.Orientation,

       Tags = p.Tags,
       IsCreateYourOwn = p.IsCreateYourOwn,

       RetailerSKU = s.RetailerSKU,

       PromoCode = po.promoCode,
       PromoDesc = po.description,

       StoreID = d.retailerStoreID,
       Country = d.country_abbrev,
       State = d.state_abbrev,
       City = d.city,
       ZipCode = d.zip,

       PaymentMethod = py.PaymentMethod,
       ShippingType = sh.ShippingType,

       Date = dt.Date,

       CalendarYear = dt.Year,
       CalendarQuarter = dt.Quarter,
       CalendarMonth = dt.Month,
       CalendarWeek = dt.WeekOfYear,
       CalendarDayOfYear = dt.DayOfYear,

       DayOfWeek = left(dt.DayOfWeek,3),

       PNIYear = rd.RYear,
       PNIQuarter = rd.RQuarter,
       PNIPeriod = rd.RPeriod,
       PNIWeek = rd.RWeekOfYear,
       PNIDayOfYear = rd.RDayOfYear,

       RetailerYear = case when rd.RYear = 0 then dt.Year else rd.RYear end,
       RetailerQuarter = case when rd.RQuarter = 0 then dt.Quarter else rd.RQuarter end,
       RetailerPeriod = case when rd.RPeriod = 0 then dt.Month else rd.RPeriod end,
       RetailerWeek = case when rd.RWeekOfYear = 0 then dt.WeekOfYear else rd.RWeekOfYear end,
       RetailerDayOfYear = case when rd.RDayOfYear = 0 then dt.Day else rd.RDayOfYear end,

       RetailerName = r.retailerName

  from factOrder o with(nolock)
       join dimProduct p with(nolock) on p.dim_product_id = o.dim_product_id
       join dimApplication a with(nolock) on a.dim_app_id = o.dim_app_id
       join dimRetailer r with(nolock) on r.dim_retailer_id = o.dim_retailer_id
       join dimPromo po with(nolock) on po.dim_promo_id = o.dim_promo_id
       join dimDestination d with(nolock) on d.dim_dest_id = o.dim_dest_id
       join dimPayment py with(nolock) on py.dim_payment_id = o.dim_payment_id
       join dimDate dt with(nolock) on dt.dim_date_ID = o.checkoutdate_id
       join dimShipping sh with(nolock) on sh.dim_shipping_id = o.dim_shipping_id
       join dimSku s with(nolock) on s.dim_sku_id = isnull(o.dim_sku_id, -1)
       join dimRDate rd with(nolock) on rd.dim_date_id = dt.dim_date_id and rd.retailerID = o.retailerID

 where o.retailerID = 50
   and isnull(o.isTest, 0) = 0
   and isnull(o.isRIK, 0) = 0 
   and a.appContextID != 11945004
   and o.fact_id != 224811775  -- wrong one, exclude!
   and o.checkoutDateTime >= '2016-07-01'
CREATE VIEW RETAIL_DATA.vOrdersOthers
as
select Id = o.fact_id,

       Quantity = o.quantity,
       ItemTotal = o.itemTotal,
       DiscountTotal = o.discountTotal,
       BaseItemTotal = o.baseItemTotal,
       AllocatedShippingFee = o.allocatedShippingFee,
       AllocatedTax = o.allocatedTax,
       PackSize = o.packSize,
       CostPer = isnull(o.CostPer, 0),
       TotalPages = isnull(o.TotalPages, 0),
       ExtraPages = isnull(o.ExtraPages, 0), 
       NoOfOrderItems = isnull(o.NoOfOrderItems, 0),
       PrepaidTotal = isnull(o.prepaidTotal, 0), 
       OrderID = o.orderID,
       ExternalOrderID = isnull(o.ExternalOrderID, o.orderID) ,
       isResubmit = isnull(o.isResubmit, 0),

       RetailerID = o.retailerID,
       AppContextID = a.appContextID,
       AppType = a.appType,

       RetailerProductName = p.retailerProductName,
       SKU = p.SKU,
       PNIProductTypeName = p.PNIProductTypeName,
       PNIProductSubTypeName = p.PNIProductSubTypeName,
       RetailerProductTypeName = p.RetailerProductTypeName,
       RetailerProductSubTypeName = p.RetailerProductSubTypeName,
       RetailerProductBaseName = p.RetailerProductBaseName,

       ProductCode = p.ProductCode,
       DesignCode = p.DesignCode,
       ProductDesc = p.ProductDesc,
       Size = p.Size,
       NoOfSurfaces = p.NoOfSurfaces,
       Orientation = p.Orientation,
       Category = p.Category,
       Tags = p.Tags,
       IsCreateYourOwn = p.IsCreateYourOwn,

       RetailerSKU = s.RetailerSKU,

       PromoCode = po.promoCode,

       DestStore = d.retailerStoreID,
       DestCountry = d.country_abbrev,
       DestState = d.state_abbrev,
       DestCity = d.city,
       DestZip = d.zip,

       Vendor = v.vendor,

       PaymentProvider = py.provider,

       Date = dt.Date,
       CDay = dt.Day,
       CMonth = dt.Month,
       CYear = dt.Year,
       DayOfWeek = left(dt.DayOfWeek,3),
       RYear = case when rd.RYear = 0 then dt.Year else rd.RYear end,
       RQuarter = case when rd.RQuarter = 0 then dt.Quarter else rd.RQuarter end,
       RPeriod = case when rd.RPeriod = 0 then dt.Month else rd.RPeriod end,
       RWeekOfYear = case when rd.RWeekOfYear = 0 then dt.WeekOfYear else rd.RWeekOfYear end,
       RDay = case when rd.RDayOfYear = 0 then dt.Day else rd.RDayOfYear end


  from factOrder o
       join dimProduct p on p.dim_product_id = o.dim_product_id
       join dimApplication a on a.dim_app_id = o.dim_app_id
       join dimRetailer r on r.dim_retailer_id = o.dim_retailer_id
       join dimPromo po on po.dim_promo_id = o.dim_promo_id
       join dimDestination d on d.dim_dest_id = o.dim_dest_id
       join dimVendor v on v.dim_vendor_id = o.dim_vendor_id
       join dimPayment py on py.dim_payment_id = o.dim_payment_id
       join dimDate dt on dt.dim_date_ID = o.checkoutdate_id

       join dimSku s on s.dim_sku_id = isnull(o.dim_sku_id, -1)

       join dimRDate rd on rd.dim_date_id = dt.dim_date_id and rd.retailerID = o.retailerID

 where o.retailerID in (51,53)
   and isnull(o.isTest, 0) = 0
   --and isnull(o.isRIK, 0) = 0 
   --and a.appContextID != 11945004
   and o.fact_id != 224811775  -- wrong one
   and o.checkoutDateTime >= '2016-01-01'


CREATE view vFactOrder
as
select * from factOrder where retailerID in (2,26,27,36,50,51,53) and fact_id != 224811775
create view vFOrderGeneral
as
select f.retailerID, 
       f.orderID,
       f.checkoutDateTime,
       f.userID,
       f.quantity,
       f.itemTotal,
       f.discountTotal,
       f.packSize,

       a.appContextID,
       a.appType,

       p.PNIProductSubTypeName,
       p.PNIProductTypeName,
       p.retailerProductName,
       p.SKU,
       
       d.SYear,
       d.SQuarter,
       d.SWeekOfYear,
       d.SDayOfYear        
  from factOrder f
       join dimDate d on d.dim_date_ID = f.checkoutdate_id
       join dimApplication a on a.dim_app_id = f.dim_app_id  
       join dimProduct p on p.dim_product_id = f.dim_product_id

 where f.retailerID in (2,26,27,36,50,51,53) 
   and f.fact_id != 224811775 /*SPLUS fake record*/
CREATE view RETAIL_DATA.vFactOrderAll
as
select o.fact_id,
       o.retailerID,
       o.orderID,
       o.subOrderID,
       o.appContextID,
       o.checkoutDateTime,
       o.quantity,
       o.itemTotal,
       o.discountTotal,
       o.baseItemTotal,
       o.allocatedShippingFee,
       o.allocatedTax,
       o.userID,
       o.packSize,
       o.TotalPages,
       o.ExtraPages,

       p.retailerProductName,
       p.SKU,
       p.PNIProductTypeName,
       p.ProductDesign,
       p.ProductCode,
       p.ProductDesc,
       p.Size,
       p.NoOfSurfaces,
       p.Orientation,
       p.PNIProductSubTypeName,
       p.DesignCode,

       a.appVersionID,
       a.appVerNotes,
       a.appServerID,
       a.appServerDesc,
       a.consumerName,
       appDescription = a.Description,
       a.appType,

       r.retailerName,

       po.promoCode,

       d.retailerStoreID,
       d.country_abbrev,
       d.state_abbrev,
       d.city,
       d.zip,

       v.vendor,

       py.provider,

       dt.Day,
       dt.DayOfWeek,
       dt.DayOfYear,
       dt.WeekOfYear,
       dt.Month,
       dt.Quarter,
       dt.Year,

       dt.PNIYear,
       dt.PNIQuarter,

       dt.CostcoYear,
       dt.CostcoPeriod,
       dt.CostcoWeek,
       dt.CostcoWeekStartdt,
       dt.CostcoWeekEnddt,

       dt.SYear,
       dt.SQuarter,
       dt.SMonthOfYear,
       dt.SWeekOfYear,
       dt.SDayOfYear,

       dt.staplesDayOfYear,
       dt.staplesMonthOfYear,
       dt.staplesQuarter,
       dt.staplesWeekOfYear,
       dt.staplesYear,

       p.Theme,
       p.Cover,
       p.Category

  from factOrder o
       join dimProduct p on p.dim_product_id = o.dim_product_id
       join dimApplication a on a.dim_app_id = o.dim_app_id
       join dimRetailer r on r.dim_retailer_id = o.dim_retailer_id
       join dimPromo po on po.dim_promo_id = o.dim_promo_id
       join dimDestination d on d.dim_dest_id = o.dim_dest_id
       join dimVendor v on v.dim_vendor_id = o.dim_vendor_id
       join dimPayment py on py.dim_payment_id = o.dim_payment_id
       join dimDate dt on dt.dim_date_ID = o.checkoutdate_id
 where o.retailerID in (2,26,27,36,50,51,53) 
   and o.fact_id != 224811775


CREATE view RETAIL_DATA.vFactOrderByDay
as
 select Date = min(cast(o.checkoutDateTime as date)),
        retailerID,
        pricingID,
        appContextID,
        promoID,
        dim_product_id,
        dim_vendor_id,
        dim_dest_id,
        dim_user_id,
        dim_promo_id,
        dim_status_id,
        dim_delivery_id,
        dim_shipping_id,
        dim_payment_id,
        checkoutdate_id,
        dim_retailer_id,
        dim_app_id,
        packSize,

        quantity = sum(quantity),
        itemTotal = sum(itemTotal),
        discountTotal = sum(discountTotal),
        baseItemTotal = sum(baseItemTotal),
        allocatedShippingFee = sum(allocatedShippingFee),
        allocatedTax = sum(allocatedTax),
        orders = count(distinct OrderID),
        suborders = count(distinct subOrderID)

   from factOrder o
  where o.retailerID in (2,26,27,36,50,51,53) 
    and o.fact_id != 224811775
 group by 
        retailerID,
        pricingID,
        appContextID,
        promoID,
        dim_product_id,
        dim_vendor_id,
        dim_dest_id,
        dim_user_id,
        dim_promo_id,
        dim_status_id,
        dim_delivery_id,
        dim_shipping_id,
        dim_payment_id,
        checkoutdate_id,
        dim_retailer_id,
        dim_app_id,
        packSize

CREATE VIEW RETAIL_DATA.vPromoCOSUSv2 as

SELECT 
cal.Costco Week Name,
c.*,
pr.PGroup
FROM 
(SELECT      
	PNIProductSKU
      ,PNIProductCategory
      ,PNIProductType
      ,RetailerProductCategory
      ,RetailerProductType
      ,RetailerProductName
      ,CASE WHEN PromoCode = 'UNKN' THEN 'None' else PromoCode END AS PromoCode
      ,CASE WHEN PromoDesc = 'UNKN' THEN 'None' else PromoDesc END AS PromoDesc
      ,CONVERT(date,Date)as Date
      ,CalendarYear
      ,CalendarQuarter
      ,CalendarMonth
      ,CalendarWeek
      ,CalendarDayOfYear
      ,DayOfWeek
      ,PNIYear
      ,PNIQuarter
      ,PNIPeriod
      ,PNIWeek
      ,PNIDayOfYear
      ,RetailerYear
      ,RetailerQuarter
      ,RetailerPeriod
      ,RetailerWeek
      ,RetailerDayOfYear
      ,RetailerName
	  ,SUM(Revenue) AS  Revenue
      ,SUM(DiscountAmount) AS DiscountAmount
      ,SUM(BaseRevenue) AS BaseRevenue
	  ,SUM(NoOfOrderItems) AS NoOfOrderItems
	  ,COUNT(DISTINCT orderID) AS Orders
  FROM RETAIL_DATA.vOrdersCOSUS 
  WHERE RetailerYear in (2018,2019,2020)
  GROUP BY PNIProductSKU,PNIProductCategory,PNIProductType,RetailerProductCategory,RetailerProductType,RetailerProductName,PromoCode,PromoDesc,Date,CalendarYear,CalendarQuarter,CalendarMonth,CalendarWeek,CalendarDayOfYear,DayOfWeek,PNIYear
      ,PNIQuarter,PNIPeriod,PNIWeek,PNIDayOfYear,RetailerYear,RetailerQuarter,RetailerPeriod,RetailerWeek,RetailerDayOfYear,RetailerName 
) c

INNER JOIN RETAIL_DATA.Costco CAL REF 2020 cal 
ON c.Date=cal.Date
LEFT JOIN (SELECT DISTINCT promoCode, Pgroup FROM RETAIL_DATA.PromoRedemption20190903 ) PR  on pr.promoCode = c.promoCode
CREATE view RETAIL_DATA.vSPLUS3Years
as
select o.fact_id,
       o.retailerID,
       o.orderID,
       o.subOrderID,
       o.appContextID,
       o.checkoutDateTime,
       o.quantity,
       o.itemTotal,
       o.discountTotal,
       o.baseItemTotal,
       o.allocatedShippingFee,
       o.allocatedTax,
       o.userID,
       o.packSize,
       o.TotalPages,
       o.ExtraPages,
       o.NoOfOrderItems,

       p.retailerProductName,
       p.SKU,
       p.PNIProductTypeName,
       p.ProductDesign,
       p.ProductCode,
       p.ProductDesc,
       p.Size,
       p.NoOfSurfaces,
       p.Orientation,
       p.PNIProductSubTypeName,
       p.DesignCode,

       a.appVersionID,
       a.appVerNotes,
       a.appServerID,
       a.appServerDesc,
       a.consumerName,
       appDescription = a.Description,
       a.appType,

       r.retailerName,

       po.promoCode,

       d.retailerStoreID,
       d.country_abbrev,
       d.state_abbrev,
       d.city,
       d.zip,

       v.vendor,

       py.provider,

       dt.Day,
       dt.DayOfWeek,
       dt.DayOfYear,
       dt.WeekOfYear,
       dt.Month,
       dt.Quarter,
       dt.Year,

       dt.PNIYear,
       dt.PNIQuarter,

       dt.CostcoYear,
       dt.CostcoPeriod,
       dt.CostcoWeek,
       dt.CostcoWeekStartdt,
       dt.CostcoWeekEnddt,

       dt.SYear,
       dt.SQuarter,
       dt.SMonthOfYear,
       dt.SWeekOfYear,
       dt.SDayOfYear,

       dt.staplesDayOfYear,
       dt.staplesMonthOfYear,
       dt.staplesQuarter,
       dt.staplesWeekOfYear,
       dt.staplesYear,

       p.Theme,
       p.Cover,
       p.Category

  from factOrder o
       join dimProduct p on p.dim_product_id = o.dim_product_id
       join dimApplication a on a.dim_app_id = o.dim_app_id
       join dimRetailer r on r.dim_retailer_id = o.dim_retailer_id
       join dimPromo po on po.dim_promo_id = o.dim_promo_id
       join dimDestination d on d.dim_dest_id = o.dim_dest_id
       join dimVendor v on v.dim_vendor_id = o.dim_vendor_id
       join dimPayment py on py.dim_payment_id = o.dim_payment_id
       join dimDate dt on dt.dim_date_ID = o.checkoutdate_id
 where o.retailerID = 50
   and o.fact_id != 224811775
   and o.checkoutDateTime >= '2016-06-01'
   and (o.isTest is null or o.isTest = 0)
   and (o.retailerID != 50 or isnull(o.isRIK,0) = 0)
   and (o.retailerID != 50 or a.appContextID != 11945004)

CREATE view vFactOrderAllByDay
as
select o.Id,
       o.retailerID,
       o.appContextID,
       o.quantity,
       o.itemTotal,
       o.discountTotal,
       o.baseItemTotal,
       o.allocatedShippingFee,
       o.allocatedTax,
       o.packSize,
       o.orders,
       o.suborders,

       p.retailerProductName,
       p.SKU,
       p.PNIProductTypeName,
       p.ProductDesign,
       p.ProductCode,
       p.ProductDesc,
       p.Size,
       p.NoOfSurfaces,
       p.Orientation,
       p.PNIProductSubTypeName,
       p.DesignCode,

       a.appVersionID,
       a.appVerNotes,
       a.appServerID,
       a.appServerDesc,
       a.consumerName,
       appDescription = a.Description,
       a.appType,

       r.retailerName,

       po.promoCode,

       d.retailerStoreID,
       d.country_abbrev,
       d.state_abbrev,
       d.city,
       d.zip,

       v.vendor,

       py.provider,

       dt.Date,
       dt.Day,
       dt.DayOfWeek,
       dt.DayOfYear,
       dt.WeekOfYear,
       dt.Month,
       dt.Quarter,
       dt.Year,

       dt.PNIYear,
       dt.PNIQuarter,

       dt.SYear,
       dt.SQuarter,
       dt.SMonthOfYear,
       dt.SWeekOfYear,
       dt.SDayOfYear,

       dt.staplesYear,
       dt.staplesQuarter,
       dt.staplesMonthOfYear,
       dt.staplesWeekOfYear,
       dt.staplesDayOfYear,

       dt.costcoYear,
       dt.costcoQuarter,
       dt.costcoPeriod,
       dt.costcoWeek,
       dt.costcoDay

  from FactOrderDaily o
       join dimProduct p on p.dim_product_id = o.dim_product_id
       join dimApplication a on a.dim_app_id = o.dim_app_id
       join dimRetailer r on r.dim_retailer_id = o.dim_retailer_id
       join dimPromo po on po.dim_promo_id = o.dim_promo_id
       join dimDestination d on d.dim_dest_id = o.dim_dest_id
       join dimVendor v on v.dim_vendor_id = o.dim_vendor_id
       join dimPayment py on py.dim_payment_id = o.dim_payment_id
       join dimDate dt on dt.dim_date_ID = o.checkoutdate_id
