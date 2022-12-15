-- 질의1 : 고객이 주문한 도서의 총 판매액을 구하세요.
SELECT * From Orders;
SELECT SUM(saleprice) FROM Orders;
SELECT SUM(saleprice) AS "총매출" FROM Orders;
SELECT SUM(saleprice) "총매출" FROM Orders; -- 최근 버전의 DBMS에서는 AS 생략도 가능하지만 AS 사용을 권장함.

-- 질의2 : 2번 김연아 고객이 주문한 도서의 총 판매액을 구하세오.
SELECT * FROM Orders;
SELECT SUM(saleprice) AS "총매출" FROM Orders WHERE custid=2;

-- 질의3 : 고객이 주문한 도서의 총판매액, 평균값, 최저가, 최고가를 구하세요.
SELECT SUM(saleprice) AS "총판매액", 
       AVG(saleprice) AS "평균값",
       MIN(saleprice) AS "최저가",
       MAX(saleprice) AS "최고가"
FROM Orders;

-- 질의4: 마당서점의 도서 판매 건수를 구하세요.
SELECT COUNT(*) FROM Orders;

-- 질의5: 고객별로 주문한 도서의 총 수량과 총 판매액을 구하세요.
SELECT custid, COUNT(*) AS "도서수량", SUM(saleprice) AS "총판매액"
FROM Orders
GROUP BY custid;

-- 질의6: 가격이 8,000원 이상인 도서를 구매한 고객에 대하여 고객별 주문 도서의 총 수량을 구하세요. 단, 두권이상 구매한 고객만 구한다. 
SELECT custid, COUNT(*) AS "도서수량" 
FROM Orders
WHERE saleprice>=8000
GROUP BY custid
HAVING COUNT(*)>=2;

-- 연습문제1 : 도서번호가 1인 도서의 이름
SELECT bookname FROM BOOK WHERE bookid=1;

-- 연습문제2 : 2014년 7월 4일 ~ 7월 7일 사이에 주문 받은 도서의 주문번호
SELECT * FROM Orders;
SELECT bookid, orderdate FROM Orders WHERE (orderdate >= '2014-07-04') AND (orderdate <= '2014-07-07');
SELECT bookid, orderdate FROM Orders WHERE orderdate BETWEEN '2014-07-04' AND '2014-07-07';

-- 연습문제3 : 주문 금액의 총액과 주문의 평균 금액
SELECT SUM(saleprice), AVG(saleprice) FROM Orders;