drop procedure ReRollTransactions//
create procedure ReRollTransactions(IN fromDate Date)
begin
	DECLARE reUpDate DATE default STR_TO_DATE('01/01/1970', '%m/%d/%Y');
	DECLARE commerceBalance int default 0;
	DECLARE usbankBalance int default 0;
	DECLARE bal int default 0;
	DECLARE reup_count int default 0;
	IF fromDate IS NULL THEN
delete from transaction_rollup;
	ELSE
delete from transaction_rollup where tx_clear_date >= fromDate;
set reUpDate = fromDate;
select commerce_balance from transaction_rollup order by tx_clear_date desc, id desc limit 1 into commerceBalance;
select usbank_balance from transaction_rollup order by tx_clear_date desc, id desc limit 1 into usbankBalance;
select balance from transaction_rollup order by tx_clear_date desc, id desc limit 1 into bal;
	END IF;
set @commerceBalance = commerceBalance;
set @usbankBalance = usbankBalance;
set @bal = bal;
set @reUpDate = reUpDate;

select count(*) from transaction where clear_date > @reUpDate into reup_count;

insert into transaction_rollup(tx_id,tx_clear_date,commerce_balance,usbank_balance,balance) select id, clear_date,@commerceBalance:=@commerceBalance+commerce_amt, @usbankBalance:=@usbankBalance+usbank_amt, @bal:=@bal+usbank_amt+commerce_amt from transaction where clear_date >= @reUpDate order by clear_date,id;
end//