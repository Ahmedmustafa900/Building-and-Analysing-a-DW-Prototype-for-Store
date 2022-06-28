/*Dimension Tables*/
drop table Fact_Transactions;
drop table Dim_Product;
drop table Dim_Customer;
drop table Dim_Supplier;
drop table Dim_StoreLocation;
drop table DIM_DATE;


CREATE TABLE Dim_Product  
( Product_Id Varchar2(6) NOT NULL,  
  Product_Name Varchar2(30) NOT NULL, 
  Price Number(5,2) NOT NULL,
  CONSTRAINT product_pk PRIMARY KEY (Product_Id)  
);  


CREATE TABLE Dim_Customer  
( Customer_Id Varchar2(4) NOT NULL,  
  Customer_Name Varchar2(30) NOT NULL, 
  CONSTRAINT customers_pk PRIMARY KEY (Customer_Id)  
);

CREATE TABLE Dim_Supplier 
( Supplier_Id Varchar2(5) NOT NULL,  
  Supplier_Name Varchar2(30) NOT NULL, 
  CONSTRAINT supplier_pk PRIMARY KEY (Supplier_Id)  
);


CREATE TABLE Dim_StoreLocation  
( Store_Id Varchar2(4) NOT NULL,  
  Store_Name Varchar2(20) NOT NULL, 
  CONSTRAINT store_pk PRIMARY KEY (Store_Id)  
);

/*
CREATE TABLE Dim_Date  
( Transaction_Date DATE NOT NULL,  
  /*Quarter Varchar2(20) NOT NULL, 
  Date_Year DATE_FORMAT [YY]
  CONSTRAINT Date_pk PRIMARY KEY (Transaction_Date)  
);
*/


CREATE TABLE DIM_DATE AS
	SELECT
	TO_CHAR(n) AS DATE_ID,
	TO_DATE('01/01/2016','DD/MM/YYYY') + NUMTODSINTERVAL(n,'day') AS COLUMN_DATE,
	TO_CHAR(TO_DATE('01/01/2016','DD/MM/YYYY') + NUMTODSINTERVAL(n,'day'),'DD') AS COLUMN_DAY,
	TO_CHAR(TO_DATE('01/01/2016','DD/MM/YYYY') + NUMTODSINTERVAL(n,'day'),'MM') AS COLUMN_MONTH,
	TO_CHAR(TO_DATE('01/01/2016','DD/MM/YYYY') + NUMTODSINTERVAL(n,'day'),'YYYY') AS COLUMN_YEAR
	FROM (
	select level n
	from dual
	connect by level <= 365
	);










/* Fact Table*/
CREATE TABLE Fact_Transactions
( Transaction_Id Number(8,0) NOT NULL PRIMARY KEY,
  Quantity Number(3,0) NOT NULL,
  Product_Key Varchar2(6),
  Customer_Key Varchar2(4),
  Supplier_Key Varchar2(5),
  Store_Key Varchar2(4),  
  /*Transaction_Date_Key Date,
  
  /* Foreign Keys */
  CONSTRAINT fk_product FOREIGN KEY (Product_Key) REFERENCES Dim_Product(Product_Id),
  CONSTRAINT fk_customer FOREIGN KEY (Customer_Key) REFERENCES Dim_Customer(Customer_Id),
  CONSTRAINT fk_supplier FOREIGN KEY (Supplier_Key) REFERENCES Dim_Supplier(Supplier_Id),
  CONSTRAINT fk_store FOREIGN KEY (Store_Key) REFERENCES Dim_StoreLocation(Store_Id)
  /*CONSTRAINT fk_tdate FOREIGN KEY (Transaction_Date_Key) REFERENCES Dim_Date(Transaction_Date)*/
);