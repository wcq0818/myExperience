-- check if partitioned
SELECT partitioned FROM ALL_TABLES WHERE TABLE_NAME = 'RD_ELEC_CODE';

-- seach data from partition
select * from RD_ELEC_CODE partition(RD_ELEC_CODE99981212);

-- create partition
alter table RD_ELEC_CODE add partition RD_ELEC_CODE201905 VALUES LESS THAN (1559318400);  1556640000