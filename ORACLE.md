# ORACLE 명령어 모음집

## 시작

- sysdba 권한 접속

  ```
  sqlplus "/as sysdba"
  ```

- DB 인스턴스 생성 및 시작

  ```
  startup;
  ```

- 계정 확인

  ```
  show user
  ```

- 다른 계정으로 넘어가기

  ```
  //이름/비번@디비명
  conn testuser/testuser@coreDB;
  ```

- 계정 조회

  ```
  select username from dba_users;
  ```

- 접속한 계정의 테이블 목록 보기

  ```
  select * from tabs;
  ```

- 컬럼 목록 조회하기

  ```
  select column_name from user_tab_columns where table_name = 'POSTS'; 
  ```

  

## 계정 관련

- 계정 생성

  ```
  CREATE USER testuser IDENTIFIED BY "testpwd";
  ```

- 계정 삭제

  ```
  DROP USER testuser CASCADE;
  ```

- 계정 비번 변경

  ```
  ALTER USER testuser IDENTIFIED BY "chagepwd";
  ```

  ​

## 기타

- DB명 확인

  ```
  SELECT NAME, DB_UNIQUE_NAME FROM v$database;
  ```

- SID 확인

  ```
  SELECT INSTANCE FROM v$thread;
  ```



## PROCEDURE

- ###### 정의

  ```sql
  CREATE OR REPLACE PROCEDURE myproc (id IN NUMBER, name OUT VARCHAR2) AS 
  BEGIN 
  	SELECT last_name INTO name FROM employees WHERE employee_id = id; 
  END;
  ```

  

- 사용

  ```typescript
  connection.execute(
    "BEGIN myproc(:id, :name); END;",
    {  // bind variables
      id:   159,
      name: { dir: oracledb.BIND_OUT, type: oracledb.STRING, maxSize: 40 },
    },
    function (err, result) {
      if (err) { console.error(err.message); return; }
      console.log(result.outBinds);
    });
  ```

