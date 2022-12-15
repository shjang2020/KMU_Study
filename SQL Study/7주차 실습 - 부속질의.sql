-- 질의 1: 가장 비싼 도서의 이름을 검색하세요.
SELECT Max(price) FROM BOOK; #단일행-단일열 =

SELECT bookname
FROM Book
WHERE price = (SELECT MAX(price) FROM Book);

-- 질의 2: 도서를 구매한 적이 있는 고객의 이름을 검색하세요. #다중행-단일열 IN
SELECT name FROM Customer WHERE custid IN (SELECT DISTINCT custid FROM Orders); 

-- 질의 3: 대한미디어에서 출판한 도서를 구매한 고객의 이름을 보이시오.
SELECT name FROM Customer WHERE custid IN
							(SELECT custid FROM Orders WHERE bookid IN 
																	(SELECT bookid FROM Book WHERE publisher = "대한미디어"));
# 조인을 사용해서 풀음(부속질의보다 속도가 오래걸림)
SELECT name FROM Book, Orders, Customer WHERE Book.bookid=Orders.bookid AND Customer.custid=Orders.custid
										AND Book.publisher ='대한미디어';
                                        
-- 질의 4: 출판사별로 출판사의 평균 도서 가격보다 비싼 도서를 구하세요.(상관 부속질의)
SELECT publisher, AVG(price) FROM Book GROUP BY publisher;
SELECT bookname, publisher FROM Book b1 WHERE b1.price<(SELECT AVG(b2.price) FROM Book b2 WHERE b1.publisher = b2.publisher);


