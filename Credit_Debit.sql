use credit_debit_analysis;
Select * from banking_data;
-- Total Credit Transaction Amount
Select sum(Amount) as Total_Credit_Amount from banking_data where `Transaction Type`='Credit';
-- Total Debit Transaction Amount
Select sum(Amount) as Total_Debit_Amount from banking_data where `Transaction Type`='Debit';
-- Net Transaction Amount
Select (select sum(Amount) as Total_Credit_Amount from banking_data where `Transaction Type`='Credit')
- (select sum(Amount) as Total_Debit_Amount from banking_data where `Transaction Type`='Debit')
 as Net_Transaction_Amount;
 -- Credit Debit Ratio
 Select (select sum(Amount) as Total_Credit_Amount from banking_data where `Transaction Type`='Credit')
/ (select sum(Amount) as Total_Debit_Amount from banking_data where `Transaction Type`='Debit')
 as Net_Transaction_Amount;
 -- Total Transactions
 select count(*) as Total_Transactions from banking_data;
 -- Aeverage Transactions
-- select count(*) as Total_Transaction from banking_data;
-- select sum(amount) as Total_Amount from banking_data;
select (select count(*) as Total_Transaction from banking_data)*1.0/(select sum(amount) as Total_Amount from banking_data)
as Avrage_Transaction;
-- Transaction Amount by Branch
select Branch,sum(amount) as Total_Amount from banking_data group by branch order by sum(amount) desc;
-- Transaction Amount by Bank Name
select `Bank Name`,sum(amount) as Total_Amount from banking_data group by `Bank Name` order by sum(amount) desc;
-- Transaction Trends
select year(str_to_date(`Transaction Date`, '%d-%m-%Y')) as Year,
concat('Q', quarter(str_to_date(`Transaction Date`, '%d-%m-%Y'))) as Quarter,
month(str_to_date(`Transaction Date`, '%d-%m-%Y')) as Month_No,
monthname(str_to_date(`Transaction Date`, '%d-%m-%Y')) as Month_Name,
sum(`Amount`) as Transaction_Amount from banking_data
where `Transaction Date` is not null and `Transaction Type`="Debit"
group by 
year,
quarter,Month_No,Month_Name
order by 
year asc,
Month_No asc;

