/* 질의 1: NewBook 테이블을 생성
		  - bookid(도서번호) : INTEGER
          - bookname(도서이름) : VARCHAR(20)
          - publisher(출판사) : VARCHAR(20)
          - price(가격) : INTEGER */

CREATE TABLE NewBook (
	bookid		INTEGER,
    bookname	VARCHAR(20),
    publisher	VARCHAR(20),
    price		INTEGER);

SELECT * FROM NewBook;

/* 질의2: NewCustomer 테이블을 생성
	- custid(고객번호) : INTEGER, 기본키
    - name(이름) : VARCHAR(40)
    - address(주소) : VARCHAR(40)
    - phone(전화번호) : VARCHAR(30) */

CREATE TABLE NewCustomer (
	custid	INTEGER,
    name	VARCHAR(40),
    address VARCHAR(40),
    phone	VARCHAR(30),
    PRIMARY KEY (custid));

/* 질의3: NewOrders 테이블을 생성
	- orderid(주문번호) : INTEGER, 기본키
    - custid(고객번호) : INTEGER, NOT NULL 제약조건, 외래키(NewCustomer, custid, CASCADE)
    - bookid(도서번호) : INTEGER, NOT NULL 제약조건
	- saleprice(판매가격) : INTEGER
    - orderdate(판매일자) : DATE */

CREATE TABLE NewOrders(
	orderid 	INTEGER,
    custid		INTEGER		NOT NULL,
    bookid		INTEGER		NOT NULL,
    saleprice	INTEGER,
    orderdate	DATE,
    PRIMARY KEY (orderid),
    FOREIGN KEY (custid) REFERENCES NewCustomer(custid) ON DELETE CASCADE);

-- 질의 4: NewBook 테이블에 VARCHAR(13)의 자료형을 가진 isbn속성을 추가하세요.
ALTER TABLE NewBook ADD isbn VARCHAR(13); #기존 데이터의 결측치를 해결한 후에 NOT NULL

-- 질의 5: NewBook 테이블의 isbn 속성의 데이터타입을 INTEGER로 변경하세요.
ALTER TABLE NewBook MODIFY isbn INTEGER;

-- 질의 6: NewBook 테이블의 isbn 속성을 삭제하세요.
ALTER TABLE NewBook DROP COLUMN isbn; #당연히 속성에 속해져있던 데이터도 다 삭제됨.

-- 질의 7: NewBook 테이블의 bookid 속성에 NOT NULL 제약조건을 적용하세요.
ALTER TABLE NewBook MODIFY bookid INTEGER NOT NULL; #기존 데이터의 결측치가 테이블 생성시 이미 해결되어 있음.

-- 질의 8: NewBook 테이블의 bookid 속성을 기본키로 변경하세요.
ALTER TABLE NewBook ADD PRIMARY KEY(bookid); #(기본키 설정방법1)
ALTER TABLE NewBook DROP PRIMARY KEY; #기본키는 한번 지정하면 변경이 안되기 때문에 삭제한 후
ALTER TABLE NewBook MODIFY bookid INTEGER PRIMARY KEY; #기본키를 다시 설정해야한다. (기본키 설정방법2)

-- 질의 9: NewBook 테이블을 삭제
DROP TABLE NewBook;

-- 질의 10: NewCustomer 테이블을 삭제
DROP TABLE NewCustomer; #NewOrders 테이블에서 참고하고 있기 때문에, 관계를 끊기 전에는 삭제가 불가능하다.







