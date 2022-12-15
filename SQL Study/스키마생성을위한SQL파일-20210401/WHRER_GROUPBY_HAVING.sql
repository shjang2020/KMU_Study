-- 질의 1: 고객이 주문한 도서의 총 판매액을 구하시오.
SELECT * FROM orders;
SELECT SUM(saleprice) FROM orders;
SELECT AVG(saleprice) FROM orders;
SELECT SUM(saleprice) AS '총 매출' FROM orders;

-- 질의 2: 2번 김연아고객이 주문한 도서의 총판매액을 구하시오.
SELECT SUM(saleprice) AS '총매출' FROM orders WHERE (custid=2);

-- 질의 3: 고객이 주문한 도서의 총판매액, 평균값, 최고가, 최저가를 구하시오.
SELECT SUM(saleprice) AS '총판매액',
	   AVG(saleprice) AS '평균값', 
       MAX(saleprice) AS '최고가', 
       MIN(saleprice) AS '최저가' 
FROM orders;

-- 질의 4: 마당서점의 도서 판매 건수를 구하시오.
SELECT COUNT(*) AS '판매 건수' FROM orders;

-- 질의 5: 고객별로 주문한 도서의 총 수량과 총 판매액을 구하시오.
SELECT custid, 
	   COUNT(*) AS '도서 수량', 
       SUM(saleprice) AS '총판매액' 
FROM orders 
GROUP BY custid; 

-- 질의 6: 가격이 8000원 이상인 도서를 구매한 고객에 대하여 고객별 주문도서의 총 수량을 구하시오. 단 두권이상 구매한 고객만 구한다.
SELECT custid, COUNT(*) AS '도서수량' 
FROM orders 
WHERE saleprice >=8000
GROUP BY custid
HAVING COUNT(*) >=2
ORDER BY custid ASC;
-- WHERE 절로 먼저 필터링 하고 그 다음에 GROUP BY로 묶고, 그 다음 HAVING 을 쓰는 것이 표준이다.
-- HAVING 은 GROUP BY 한 테이블에 대해서 조건을 걸어주는 것만 다루는 것이기 때문에 땔 수 없는 관계이다. 

-- 도서번호가 1인 도서의 이름
SELECT * FROM BOOK;
SELECT bookname FROM BOOK WHERE bookid=1;

-- 2014년 7월 4일~ 7월7일 사이에 주문 받은 도서의 주문번호
SELECT * FROM ORDERS;
SELECT orderid, orderdate FROM ORDERS WHERE orderdate >='2014-07-04' AND orderdate <='2014-07-07';
SELECT orderid, orderdate FROM ORDERS WHERE orderdate BETWEEN '2014-07-04' AND '2014-07-07';

-- 주문 금액의 총액과 주문의 평균 금액
SELECT * FROM ORDERS;
SELECT SUM(saleprice) AS '총액',
	   AVG(saleprice) AS '평균 금액'
FROM ORDERS;

-- 질의 7: 