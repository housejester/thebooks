create trigger tx_del
after delete on transaction
for each row
begin
        call ReRollTransactions(OLD.clear_date);
end//
