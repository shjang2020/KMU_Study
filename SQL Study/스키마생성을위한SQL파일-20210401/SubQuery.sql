-- 질의 1: 가장 비싼 도서의 이름을 검색하세요.
SELECT bookname, price FROM BOOK WHERE price =(SELECT MAX(price) FROM BOOK);

-- 질의 2: 도서를 구매한 적이 있는 고객의 이름을 검색하세요.
SELECT name FROM CUSTOMER WHERE custid IN (SELECT DISTINCT custid FROM ORDERS); 

-- 질의 3: 대한미디어에서 출판한 도서를 구매한 고객의 이름을 검색하세요.
SELECT bookid FROM BOOK WHERE publisher LIKE '대한미디어';
SELECT custid FROM ORDERS WHERE bookid IN (SELECT bookid FROM BOOK WHERE publisher LIKE '대한미디어');
-- >
SELECT name FROM CUSTOMER WHERE custid 
IN (SELECT custid FROM ORDERS WHERE bookid IN (SELECT bookid FROM BOOK WHERE publisher LIKE '대한미디어'));
-- ------join 을 하면 실행 속도가 느리다 부속질의를 쓰는게 좋긴 하다.
SELECT CUSTOMER.name FROM CUSTOMER, ORDERS, BOOK 
WHERE CUSTOMER.custid=ORDERS.custid AND ORDERS.bookid=BOOK.bookid AND BOOK.publisher LIKE '대한미디어';

-- 질의 4: 출판사별로 출판사의 평균 도서 가격보다 비싼 도서를 구하세요.
SELECT publisher, AVG(price) FROM BOOK GROUP BY publisher;
SELECT bookname FROM BOOK b1 WHERE b1.price >(SELECT AVG(b2.price) FROM BOOK b2 WHERE b1.publisher=b2.publisher);
-- 순서를 b1의 publisher를 하나씩 보고 그 놈과 같은 애들의 가격평균을 먼저 낸다. 그리고 그게 그publisher인 책의 가격과 비교하여 추출
