--创建一个临时表，用于提供序列号
CREATE GLOBAL TEMPORARY table t_sequence_num
(
  sequenceNum number(8) not null
)
ON COMMIT PRESERVE ROWS;

--开始插入数据，先生成1万个序号
begin
delete from t_sequence_num;
for i in 0..9999 loop
insert into t_sequence_num(sequenceNum) values(i);
end loop;
end;

truncate table OMS_STATUS_TASK;
--使用APPEND提示，每次1万条，进行数据插入
begin
for i in 1..3000 loop
insert /*+ append */ into OMS_STATUS_TASK (DEVICE_ID, DEVICE_TYPE, RESULT, TASK_SEQ, PROCESS_S_TV, PROCESS_E_TV, UPDATE_TV, CREATE_TV)
select
t_sequence_num.sequencenum, 2001, 0,
1577836800 + i * 10000 + t_sequence_num.sequencenum as MSISDN,
1577836800 + i * 10000 + t_sequence_num.sequencenum as MSISDN,
1577836800 + i * 10000 + t_sequence_num.sequencenum as MSISDN,
1577836800 + i * 10000 + t_sequence_num.sequencenum as MSISDN,
1577836800 + i * 10000 + t_sequence_num.sequencenum as MSISDN
from t_sequence_num;
commit;--每批次必须要提交一次
end loop;
end;

select count(*) from OMS_STATUS_TASK;
select count(*) from OMS_STATUS_TASK partition(OMS_STATUS_TASK201912);
select count(*) from OMS_STATUS_TASK partition(OMS_STATUS_TASK202001);
select count(*) from OMS_STATUS_TASK partition(OMS_STATUS_TASK202002);
select count(*) from OMS_STATUS_TASK partition(OMS_STATUS_TASK202011);
select count(*) from OMS_STATUS_TASK partition(OMS_STATUS_TASK202012);
select count(*) from OMS_STATUS_TASK partition(OMS_STATUS_TASK99981212);

select * from OMS_STATUS_TASK where CREATE_TV = 1606780800;
select * from OMS_STATUS_TASK where CREATE_TV = 1606780800 and DEVICE_ID = 4000;
select * from OMS_STATUS_TASK where DEVICE_ID = 4000 and CREATE_TV = 1606780800;

select * from OMS_STATUS_TASK where UPDATE_TV = 1606780800;
select * from OMS_STATUS_TASK where UPDATE_TV = 1606780800 and CREATE_TV = 1606780800;
select * from OMS_STATUS_TASK where CREATE_TV = 1606780800 and UPDATE_TV = 1606780800;