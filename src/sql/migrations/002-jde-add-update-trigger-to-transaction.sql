create trigger tx_upd
after update on transaction
for each row
begin
	if NEW.usbank_amt != OLD.usbank_amt OR NEW.commerce_amt != OLD.commerce_amt or NEW.clear_date != OLD.clear_date then 
		if NEW.clear_date < OLD.clear_date then
	        	call ReRollTransactions(NEW.clear_date);
		else
			call ReRollTransactions(OLD.clear_date);
		end if;
	end if;
end//

