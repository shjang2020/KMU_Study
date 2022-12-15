-- 질의1: -78과 78의 절댓값을 구하세요.
SELECT ABS(-78), ABS(78);
SELECT ABS(-78), ABS(78) FROM Dual;

-- 질의2: 4.875를 소수점 둘째자리에서 반올림한 값을 구하세요.
SELECT ROUND(4.875,1) AS '반올림값';

-- 질의3: 고객별 평균 주문 금액을 백원단위로 반올림한 값을 구하세요.
SELECT custid AS '고객번호', ROUND(AVG(saleprice),-2) AS '평균주문금액' FROM Orders GROUP BY custid;

-- 질의4: 도서제목에 야구가 포함된 도서를 농구로 변경한 후에 도서 목록을 검색하세요.
SELECT bookid, REPLACE(bookname, '야구', '농구') FROM Book;

-- 질의5: 굿스포츠에서 출판한 도서의 제목과 제목의 글자수를 확인하세요.
SELECT bookname AS '도서제목', CHAR_LENGTH(bookname) AS '문자수', LENGTH(bookname) AS '바이트수' FROM Book WHERE publisher LIKE '%굿스포츠%';
SELECT bookname AS '도서제목', CHAR_LENGTH(bookname) AS '문자수', LENGTH(bookname) AS '바이트수' FROM Book;

-- 질의6: 마당서점의 고객중에서 같은 성을 가진 사람이 몇명이나 되는지 성씨별 인원수를 구하세요.
SELECT SUBSTR(name,1,1) AS '성씨', COUNT(*) AS '인원' FROM Customer GROUP BY SUBSTR(name,1,1);

-- 질의7: 마당서점이 2014년 7월 7일에 주문받은 도서의 주문번호, 고객번호, 도서번호, 주문일을 보이세요.(단, 주문일은 '%Y-%m-%d' 형태로 표시하세요.)
SELECT orderid, custid, bookid, orderdate
FROM Orders WHERE orderdate=STR_TO_DATE('2014년 7월 7일', '%Y년 %m월 %d일');

SELECT orderid, custid, bookid, orderdate, DATE_FORMAT(orderdate, '%j일')
FROM Orders WHERE orderdate=STR_TO_DATE('2014년 7월 7일', '%Y년 %m월 %d일');

SELECT orderid, custid, bookid, orderdate, DATE_FORMAT(orderdate, '%Y년 %W')
FROM Orders WHERE orderdate=STR_TO_DATE('2014년 7월 7일', '%Y년 %m월 %d일');

-- 질의8: 마당서점은 주문일로부터 25일후에 매출을 확정한다. 각 주문의 확정일자를 구하세요.
SELECT orderid AS '주문번호', orderdate AS '주문일', ADDDATE(orderdate, INTERVAL 25 DAY) AS '확정일자' FROM Orders;

SELECT orderid AS '주문번호', orderdate AS '주문일', ADDDATE(orderdate, INTERVAL 1 MONTH) AS '확정일자' FROM Orders;

-- 질의9: 날짜 차이 계산하기
SELECT DATEDIFF(STR_TO_DATE('2021-01-01','%Y-%m-%d'), STR_TO_DATE('2021-05-05','%Y-%m-%d'));
SELECT DATEDIFF('2021-01-01', '2021-05-05'); #MySQL에서는 '2021-01-01', '20210101' 모두 날짜형으로 받음.

-- 질의10: NULL값 처리
SELECT price + 100 FROM Book WHERE bookid=2;
SELECT price + 100 FROM Book WHERE bookid=15;
SELECT SUM(price), AVG(price), COUNT(*), COUNT(price) FROM Book;
SELECT SUM(price), AVG(price), COUNT(*), COUNT(price) FROM Book WHERE bookid=15;

SELECT * FROM Customer;
SELECT * FROM Customer WHERE phone IS NULL;
SELECT * FROM Customer WHERE phone IS  NOT NULL;

-- 질의11: 이름, 전화번호가 포함된 고객 목록을 보이세요. 단, 전화번호가 없는 고객은 '연락처없음'으로 표시하세요.
SELECT name AS '이름', IFNULL(phone, '연락처없음') AS '전화번호' FROM Customer;

-- 질의12: 고객 목록에서 고객번호, 이름, 전화번호를 앞의 두 명만 보이세요.
SELECT custid, name, phone FROM Customer;
SET @seq:=0;
SELECT (@seq:=@seq+1) as '순번', custid, name, phone FROM Customer WHERE @seq<2;
SELECT @seq;

-- 질의13: saleprice가 10,000원 이상인 주문을 출력하세요. 단, 앞의 두건만 검색하세요.
SET @seq:=0;
SELECT (@seq:=@seq+1), orderid FROM Orders WHERE saleprice>=10000 AND @seq<2;

select orderid, custid, saleprice from orders o1 where saleprice >(select avg(saleprice) from orders o2 where o1.custid=o2.custid);
select orderid, custid, saleprice from orders o1 where saleprice >(select avg(saleprice) from orders o2 where o1.custid=o2.custid group by o2.custid);