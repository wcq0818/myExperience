select round(BYTES/1024/1024,2)||'M' from user_segments where segment_name='T_TEST';
create table t_test_maxvalue
(
  pk_id number(30) not null,
  add_date_time Date,
  constraint PK_T_TEST_MAXVALUE primary key (pk_id)
)
partition by range (add_date_time)
(
  partition t_test_2013_less values less than (to_date('2013-01-01 00:00:00', 'yyyy-mm-ddhh24:mi:ss')) tablespace hes,
  partition t_test_2014_less values less than (to_date('2014-01-01 00:00:00', 'yyyy-mm-ddhh24:mi:ss')) tablespace hes,
  partition t_test_2015_less values less than (to_date('2015-01-01 00:00:00', 'yyyy-mm-ddhh24:mi:ss')) tablespace hes,
  partition t_test_max values less than (MAXVALUE)
);
select table_name, partition_name, high_value from dba_tab_partitions where table_name='T_TEST_MAXVALUE';

alter table t_test_maxvalue split partition t_test_2013_less at(to_date('2012-01-01 00:00:00', 'yyyy-mm-ddhh24:mi:ss')) into (partition t_test_2012_less, partition t_test_2013_less);
alter table t_test_maxvalue split partition t_test_2015_less at(to_date('2014-01-01 00:00:00', 'yyyy-mm-ddhh24:mi:ss')) into (partition t_test_2014_less, partition t_test_2015_less);
alter table t_test_maxvalue split partition t_test_2016_less at(to_date('2015-01-01 00:00:00', 'yyyy-mm-ddhh24:mi:ss')) into (partition t_test_2015_less, partition t_test_2016_less);
alter table t_test_maxvalue split partition t_test_max at(to_date('2016-01-01 00:00:00', 'yyyy-mm-ddhh24:mi:ss')) into (partition t_test_2016_less, partition t_test_max);
alter table t_test_max split partition t_test_max at(to_date('2017-01-01 00:00:00', 'yyyy-mm-ddhh24:mi:ss')) into (partition t_test_2017_less, partition t_test_max);

alter table t_test_maxvalue drop partition T_TEST_2014_TO_2015;

alter table t_test_maxvalue merge partitions t_test_2014_less,t_test_2015_less into partition t_test_2014_to_2015;

select count(*) from t_test_maxvalue;

select count(*) from t_test partition(T_TEST_2013_LESS);

insert into t_test values(0, to_date('2015-01-01 00:00:00','yyyy-mm-dd hh24:mi:ss'));

select * from t_test where pk_id = 0;
select * from t_test partition(T_TEST_2016_LESS) where pk_id = 0;
delete t_test where pk_id = 0;
delete t_test partition(T_TEST_2016_LESS) where pk_id = 0;

insert into t_test values(0, to_date('2012-01-14 12:00:00','yyyy-mm-dd hh24:mi:ss'));

create table t_new
(
  pk_id number(30) not null,
  add_date_time Date,
  constraint PK_T_NEW primary key (pk_id)
)
insert into t_new select pk_id, add_date_time from t_test;
rename t_test to t_test_old;
rename t_new to t_test;

drop table OMS_STATUS_TASK;
rename OMS_STATUS_TASK_OLD to OMS_STATUS_TASK;
alter index OMS_STATUS_TASK_OLD_PK rename to OMS_STATUS_TASK_PK;
alter table OMS_STATUS_TASK rename constraint OMS_STATUS_TASK_OLD_PK to OMS_STATUS_TASK_PK;

alter table OMS_STATUS_TASK split partition OMS_STATUS_TASK99981212 at (1575158400) into (partition OMS_STATUS_TASK201911, partition OMS_STATUS_TASK99981212);
alter table OMS_STATUS_TASK split partition OMS_STATUS_TASK99981212 at (1577836800) into (partition OMS_STATUS_TASK201912, partition OMS_STATUS_TASK99981212);

alter table OMS_STATUS_TASK split partition OMS_STATUS_TASK99981212 at (1580515200) into (partition OMS_STATUS_TASK202001, partition OMS_STATUS_TASK99981212);
alter table OMS_STATUS_TASK split partition OMS_STATUS_TASK99981212 at (1583020800) into (partition OMS_STATUS_TASK202002, partition OMS_STATUS_TASK99981212);
alter table OMS_STATUS_TASK split partition OMS_STATUS_TASK99981212 at (1585699200) into (partition OMS_STATUS_TASK202003, partition OMS_STATUS_TASK99981212);
alter table OMS_STATUS_TASK split partition OMS_STATUS_TASK99981212 at (1588291200) into (partition OMS_STATUS_TASK202004, partition OMS_STATUS_TASK99981212);
alter table OMS_STATUS_TASK split partition OMS_STATUS_TASK99981212 at (1590969600) into (partition OMS_STATUS_TASK202005, partition OMS_STATUS_TASK99981212);
alter table OMS_STATUS_TASK split partition OMS_STATUS_TASK99981212 at (1593561600) into (partition OMS_STATUS_TASK202006, partition OMS_STATUS_TASK99981212);
alter table OMS_STATUS_TASK split partition OMS_STATUS_TASK99981212 at (1596240000) into (partition OMS_STATUS_TASK202007, partition OMS_STATUS_TASK99981212);
alter table OMS_STATUS_TASK split partition OMS_STATUS_TASK99981212 at (1598918400) into (partition OMS_STATUS_TASK202008, partition OMS_STATUS_TASK99981212);
alter table OMS_STATUS_TASK split partition OMS_STATUS_TASK99981212 at (1601510400) into (partition OMS_STATUS_TASK202009, partition OMS_STATUS_TASK99981212);
alter table OMS_STATUS_TASK split partition OMS_STATUS_TASK99981212 at (1604188800) into (partition OMS_STATUS_TASK202010, partition OMS_STATUS_TASK99981212);
alter table OMS_STATUS_TASK split partition OMS_STATUS_TASK99981212 at (1606780800) into (partition OMS_STATUS_TASK202011, partition OMS_STATUS_TASK99981212);
alter table OMS_STATUS_TASK split partition OMS_STATUS_TASK99981212 at (1609459200) into (partition OMS_STATUS_TASK202012, partition OMS_STATUS_TASK99981212);

select count(*) from OMS_STATUS_TASK partition(OMS_STATUS_TASK201911);