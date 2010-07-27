create or replace view transaction_view as select tx.*, txr.* from transaction tx, transaction_rollup txr where txr.tx_id = tx.id
