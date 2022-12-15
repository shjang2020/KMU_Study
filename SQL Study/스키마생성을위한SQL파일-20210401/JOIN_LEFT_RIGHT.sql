-- 카티션곱 예제
SELECT * FROM customer;
SELECT * FROM orders;
SELECT * FROM customer, orders;

-- 질의 1: 고객과 고객의 주문에 대한 데이터를 모두 보이시오.
SELECT * FROM CUSTOMER, ORDERS WHERE CUSTOMER.custid = ORDERS.custid;
SELECT * FROM CUSTOMER  INNER JOIN ORDERS ON CUSTOMER.custid = ORDERS.custid;

-- 질의 2: 고객과 고객의 주문에 대한 데이터를 고객번호 순으로 정렬하세요.
SELECT * FROM CUSTOMER, ORDERS WHERE CUSTOMER.custid = ORDERS.custid ORDER BY CUSTOMER.custid ASC;
SELECT * FROM CUSTOMER  INNER JOIN ORDERS ON CUSTOMER.custid = ORDERS.custid ORDER BY CUSTOMER.custid ASC;

-- 질의 3: 고객의 이름과 고객이 주문한 도서의 판매가격을 검색하세요.
SELECT * FROM CUSTOMER;
SELECT * FROM ORDERS;
SELECT name, saleprice FROM CUSTOMER, ORDERS WHERE CUSTOMER.custid = ORDERS.custid;

-- 질의 4: 고객별로 주문한 모든 도서의 총 판매액을 구하고 고객 이름 순으로 정렬하세요.
SELECT name, SUM(saleprice) AS '총판매액' FROM CUSTOMER, ORDERS WHERE CUSTOMER.custid = ORDERS.custid 
GROUP BY name ORDER BY name ASC;

-- 질의 5: 고객의 이름과 고객이 주문한 도서의 이름을 구하시오.
SELECT CUSTOMER.name, BOOK.bookname FROM CUSTOMER, ORDERS, BOOK 
WHERE CUSTOMER.custid=ORDERS.custid AND BOOK.bookid=ORDERS.bookid;

-- 질의 6: 가격이 20000원인 도서를 주문한 고객의 이름과 도서의 이름을 구하시오.
SELECT * FROM BOOK;
SELECT CUSTOMER.name, BOOK.bookname FROM CUSTOMER, ORDERS, BOOK
WHERE CUSTOMER.custid=ORDERS.custid AND ORDERS.bookid=BOOK.bookid AND BOOK.price >=20000;

-- 질의 7: 셀프조인 에제; 사원'BLAKE'가 관리하는 부하 사원의 이름과 직급을 출력하시오.
-- (TABLE 의 이름을 지정해줄 때(AS)는 따움표 못쓴다.)
SELECT * FROM EMP;
SELECT STAFF.ename, STAFF.job FROM EMP AS STAFF, EMP AS MANAGER 
WHERE STAFF.mgr=MANAGER.empno 
	  AND MANAGER.ename LIKE 'BLAKE';

-- 질의 8: 도서를 구매하지 않은 고객을 포함하여 고객의 이름과 고객이 주문한 도서의 판매가격을 구하세요.
SELECT * FROM CUSTOMER;
SELECT * FROM ORDERS;
SELECT CUSTOMER.name, ORDERS.saleprice 
FROM CUSTOMER LEFT JOIN ORDERS ON CUSTOMER.custid=ORDERS.custid;
