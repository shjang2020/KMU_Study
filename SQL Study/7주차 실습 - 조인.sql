-- 카디션곱 예제
SELECT * FROM Customer;
SELECT * FROM Orders;
SELECT * FROM Customer, Orders;

-- 질의 1: 고객과 고객의 주문에 대한 데이터를 모두 보이시오. #같은 속성을 남겨라 #INNER JOIN
SELECT * FROM Customer, Orders WHERE Customer.custid = Orders.custid;

-- 질의 2: 고객과 고객의 주문에 대한 데이터를 고객번호 순으로 정렬하세요.
SELECT * FROM Customer, Orders WHERE Customer.custid = Orders.custid ORDER BY Customer.custid;

-- 질의 3: 고객의 이름과 고객이 주문한 도서의 판매가격을 검색하세요.
SELECT name, saleprice FROM Customer, Orders WHERE  Customer.custid = Orders.custid;
SELECT Customer.name, Orders.saleprice FROM Customer, Orders WHERE  Customer.custid = Orders.custid;

-- 질의 4: 고객별로 주문한 모든 도서의 총 판매액을 구하고, 고객 이름 순으로 정렬하세요.
SELECT name, SUM(saleprice) AS "총판매액" FROM Customer, Orders WHERE Customer.custid=Orders.custid 
GROUP BY Customer.custid ORDER BY Customer.name;

-- 질의 5: 고객의 이름과 고객이 주문한 도서의 이름을 구하세요.
SELECT Customer.name, Book.bookname
FROM Customer, Orders, Book
WHERE customer.custid = Orders.custid AND Orders.bookid = Book.bookid;

-- 질의 6: 가격이 20,000원인 도서를 주문한 고객의 이름과 도서의 이름을 구하세요.
SELECT Customer.name, Book.bookname
FROM Customer, Orders, Book
WHERE Customer.custid = Orders.custid AND Book.bookid = Orders.bookid
	  AND Book.price=20000;
      
-- 질의 7: 셀프조인예제; 사원 "BLAKE"가 관리하는 부하 사원의 이름과 직급을 출력하세요.
SELECT STAFF.ename, STAFF.job FROM Emp AS STAFF, Emp AS MANAGER #테이블 이름에 별칭을 정할 때는 ""를 쓰지 않는다. -> 공백이 못들어가기때문에
WHERE STAFF.mgr = MANAGER.empno
	  AND MANAGER.ename LIKE 'BLAKE';

-- 질의 8: 도서를 구매하지 않은 고객을 포함하여 고객의 이름과 고객이 주문한 도서의 판매가격을 구하세요.
SELECT Customer.name, Orders.saleprice 
FROM Customer LEFT OUTER JOIN Orders 
	  ON Customer.custid = Orders.custid;
      # 도서를 구매한 고객만 포함할 경우, RIGHT OUTER JOIN.

SELECT * FROM Customer, Orders;

