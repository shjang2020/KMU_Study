-- 질의1: 주소에 대한민국을 포함하는 고객들로 구성된 뷰를 만드세요. 뷰의 이름은 vw_Customer
CREATE VIEW vw_Customer
AS SELECT * FROM Customer WHERE address LIKE '%대한민국%';

SELECT * FROM vw_Customer;

-- 질의2: Orders 테이블에 고객이름과 도서이름을 바로 확인할 수 있는 뷰를 생성하세요.
CREATE VIEW vw_Orders (orderid, custid, name, bookid, bookname, saleprice, orderdate)
AS SELECT od.orderid, od.custid, cs.name, od.bookid, bk.bookname, od.saleprice, od.orderdate
FROM Orders od, Customer cs, Book bk
WHERE od.custid=cs.custid AND od.bookid=bk.bookid;

SELECT * FROM vw_Orders;
SELECT orderid, bookname, saleprice FROM vw_Orders WHERE name='김연아';

-- 질의3: vw_Customer를 영국을 주소로 가진 고객으로 변경, phone은 제외
SELECT * FROM vw_Customer;
CREATE OR REPLACE VIEW vw_Customer (custid, name, address)
AS SELECT custid, name, address FROM Customer WHERE address LIKE '%영국%';

SELECT * FROM vw_Customer;

-- 질의4: vw_Customer를 삭제하세요.
DROP VIEW vw_Customer;
#테이블만큼은 아니지만 뷰도 공간을 차지하긴 함.

-- 시스템뷰
SELECT * FROM INFORMATION_SCHEMA.TABLES; #전체
SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE table_schema LIKE '%madang%'; #'마당'테이블과 관련된 정보

SHOW TABLES;