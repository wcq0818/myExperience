--����һ����ʱ�������ṩ���к�
CREATE GLOBAL TEMPORARY table t_sequence_num
(
  sequenceNum number(8) not null
)
ON COMMIT PRESERVE ROWS;

--��ʼ�������ݣ�������1������
begin
delete from t_sequence_num;
for i in 0..9999 loop
insert into t_sequence_num(sequenceNum) values(i);
end loop;
end;

truncate table OMS_STATUS_TASK;
--ʹ��APPEND��ʾ��ÿ��1�������������ݲ���
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
commit;--ÿ���α���Ҫ�ύһ��
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