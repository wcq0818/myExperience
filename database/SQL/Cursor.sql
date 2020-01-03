DECLARE	
CURSOR cur_dt is SELECT PK_ID, ADD_DATE_TIME FROM t_test;
v_PK_ID t_test.PK_ID%type;
v_ADD_DATE_TIME t_test.ADD_DATE_TIME%type;
BEGIN
 OPEN cur_dt;
  LOOP
    FETCH cur_dt
      INTO v_PK_ID, v_ADD_DATE_TIME;
    EXIT WHEN cur_dt%NOTFOUND;
    insert into t_test_max (PK_ID, ADD_DATE_TIME) values (v_PK_ID, v_ADD_DATE_TIME);
  END LOOP;
  COMMIT;
  CLOSE cur_dt;
END;

BEGIN
 FOR my_cur IN (SELECT * FROM t_test) LOOP
    INSERT INTO t_test_max VALUES my_cur;
 END LOOP;
END;

DECLARE
CURSOR cur_dt is SELECT * FROM t_test;
BEGIN
 FOR my_cur IN cur_dt LOOP
    INSERT INTO t_test_max VALUES my_cur;
 END LOOP;
END;

truncate table t_test_max;