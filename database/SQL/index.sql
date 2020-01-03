create table t_index_test as select rownum ROW_ID,to_char(round(rownum/3,2)) DESC_TEXT from xmltable('1 to 10000');--1万笔数据
create table t_index_test_10w as select rownum ROW_ID,to_char(round(rownum/3,2)) DESC_TEXT from xmltable('1 to 100000');--10万笔数据
create table t_index_test_100w as select rownum ROW_ID,to_char(round(rownum/3,2)) DESC_TEXT from xmltable('1 to 1000000');--10万笔数据
create table t_index_test_1000w as select rownum ROW_ID,to_char(round(rownum/3,2)) DESC_TEXT from xmltable('1 to 10000000');--1000万笔数据
create table t_index_test_10000w as select rownum ROW_ID,to_char(round(rownum/3,2)) DESC_TEXT from xmltable('1 to 100000000');--1亿笔数据

create index idx_1w on t_index_test (row_id);
create index idx_10w on t_index_test_10w (row_id);
create index idx_100w on t_index_test_100w (row_id);
create index idx_1000w on t_index_test_1000w (row_id);
create index idx_10000w on t_index_test_10000w (row_id);