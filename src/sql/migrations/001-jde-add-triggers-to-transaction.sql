delimiter //
create trigger tx_ins
after insert on transaction
for each row
begin
	call ReRollTransactions(NEW.clear_date);
end//
delimiter ;
