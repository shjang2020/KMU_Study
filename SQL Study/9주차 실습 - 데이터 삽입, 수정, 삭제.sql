-- 질의1 : Book 테이블에 스포츠의학 도서를 삽입. 한솔의학서적에서 출간. 가격은 90,000원
SELECT * FROM Book;
INSERT INTO Book(bookid, bookname, publisher, price)
		VALUE (11, '스포츠의학', '한솔의학서적', 90000); #기본키를 쓰는 bookid가 중복되면 삽입이 안된다. 
SELECT * FROM Book;
INSERT INTO Book(bookid, bookname, publisher, price)
		VALUE (12, '스포츠의학', '한솔의학서적', 90000); #도메인제약에 맞지않아도 삽입이 안된다.
INSERT INTO Book(bookname, publisher, price, bookid)
		VALUE ('스포츠의학', '한솔의학서적', 90000, 13);
        
-- 질의2 : Book 테이블에 '스포츠의학'을 삽입. 출판사는 한솔의학서적. 가격은 미정
INSERT INTO Book(publisher, bookname)
		VALUES ('한솔의학서적', '스포츠의학'); #기본키가 없기 때문에 삽입이 안된다.
INSERT INTO Book(publisher, bookname, bookid)
		VALUES ('한솔의학서적', '스포츠의학', 14); #입력되지 않은 price는 결측치로 들어감.
SELECT * FROM Book;

-- 질의3 : Imported_Book을 Book테이블에 삽입
SELECT * FROM Imported_Book;

INSERT INTO Book(bookid, bookname, publisher, price)
	SELECT bookid, bookname, publisher, price FROM Imported_Book;
SELECT *  FROM Book;

-- 질의4 : Customer 테이블에서 고객번호가 5인 고객의 주소를 '대한민국 부산'으로 변경하세요.
SET SQL_SAFE_UPDATES=0; -- SAFE UPDATES 옵션을 임시로 해제
SELECT * FROM Customer;

UPDATE Customer SET address='대한민국 부산' WHERE custid = 5;


-- 질의5 : Book 테이블에서 14번 '스포츠의학'의 출판사를 Imported_Book 테이블의 21번 책의 출판사와 동일하게 변경
SELECT publisher FROM Imported_Book WHERE bookid=21;
SELECT * FROM Book;
UPDATE Book SET publisher=(SELECT publisher FROM Imported_Book WHERE bookid=21) WHERE bookid=14;
SELECT * FROM Book;

-- 질의6 : Book 테이블에서 도서번호가 11, 12, 13, 14인 도서를 삭제하시오.
DELETE FROM Book WHERE bookid ='11';
SELECT * FROM Book WHERE bookid IN (11, 12, 13, 14); #지우기전에 조건을 셀렉트문에 입력해서 한번 보자.
DELETE FROM Book WHERE bookid IN (11, 12, 13, 14);