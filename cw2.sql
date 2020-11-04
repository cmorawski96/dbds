ALTER TABLE <nazwa> DROP CONSTRAINT <nazwa klucza obcego>
--^ dla wszystkich tabel

drop table COUNTRIES;
drop table DEPARTMENTS;
drop table EMPLOYEES;
drop table JOB_HISTORY;
drop table JOBS;
drop table LOCATIONS;
drop table REGIONS;

----------------------------------------------------------------- KOD KOPIOWANIA TABELI Z USERA HR
declare
  l_sql varchar2(32767);
  c_tab_comment varchar2(32767);
  procedure run(p_sql varchar2) as
  begin 
     execute immediate p_sql;
     
  end; 
begin
run('create table "MORAWSKI".COUNTRIES as select * from "HR"."COUNTRIES" where '||11||' = 11');
  begin
  select comments into c_tab_comment from sys.all_TAB_comments where owner = 'HR' and table_name = 'COUNTRIES' and comments is not null;
  run('comment on table MORAWSKI.COUNTRIES is '||''''||REPLACE(c_tab_comment, q'[']', q'['']')||'''');

  for tc in (select column_name from sys.all_tab_cols where owner = 'HR' and table_name = 'COUNTRIES')
      loop
     for c in (select comments from sys.all_col_comments where owner = 'HR' and table_name = 'COUNTRIES' and column_name=tc.column_name) 
     loop 
     run ('comment on column MORAWSKI.COUNTRIES.'||tc.column_name||' is '||''''||REPLACE(c.comments, q'[']', q'['']')||'''');
   end loop;
  end loop;
  EXCEPTION
    WHEN OTHERS THEN NULL; 
  end;
end;
				