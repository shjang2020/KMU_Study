-- 1. 마당서점에 도서를 출고하는 출판사의 총 개수
SELECT COUNT(DISTINCT publisher) FROM Book;

-- 2. 도서의 가격(Book 테이블)과 판매가격(Orders 테이블)의 차이가 가장 많은 주문
SELECT orders.* 
	FROM orders, book 
    WHERE orders.bookid = book.bookid 
		AND price-saleprice =(SELECT MAX(price - saleprice) 
        FROM book, orders 
        WHERE orders.bookid = book.bookid);




-- 3. 도서의 판매액 평균보다 자신의 구매액 평균이 더 높은 고객의 이름
SELECT name
	FROM customer c1, orders o1 
    WHERE c1.custid = o1.custid 
    GROUP BY name 
    HAVING AVG(saleprice) > (SELECT AVG(o2.saleprice) FROM orders o2);


    

    
-- 4. 두 개 이상의 서로 다른 출판사에서 도서를 구매한 고객의 이름
SELECT name 
	FROM customer c1, orders o1, book b1 
    WHERE c1.custid = o1.custid AND b1.bookid = o1.bookid 
    GROUP BY name 
    HAVING COUNT(DISTINCT b1.publisher) >= 2;


-- 5. 전체 고객의 30% 이상이 구매한 도서
SELECT * 
	FROM book b1 
	WHERE ((SELECT COUNT(b2.bookid) 
		FROM book b2, orders o1 
        WHERE b2.bookid = b1.bookid AND b2.bookid = o1.bookid 
        GROUP BY b2.bookname) >= (SELECT COUNT(*) FROM customer) * 0.3);


        
select bookname

from book s1

where ((select count(t1.bookid)

        from book t1, orders t2

        where t1.bookid = t2.bookid

        and t1.bookid = s1.bookid) >= 0.3 * (select count(*) from customer));
        
-- 7. 의사테이블을 생성하는 SQL문을 작성하세요. 단, 소속 속성의 값을 입력하지 않으면 자동으로 내과가 지정되도록 하고, 근무연수는 1년 이상 40년 이하 범위의 값을 가지도록 지정하세요.
CREATE TABLE 의사테이블 (
의사번호 VARCHAR(20) PRIMARY KEY,
의사이름 VARCHAR(20),
소속 VARCHAR(20) DEFAULT '내과',
근무연수 INTEGER CHECK (1<=근무연수<=40));

-- 7-1. 그 안에 데이터를 채워넣으시오.
INSERT INTO 의사테이블(의사번호, 의사이름, 소속, 근무연수)
	VALUES ('D001', '정지영', '내과', 5);
INSERT INTO 의사테이블(의사번호, 의사이름, 소속, 근무연수)
	VALUES ('D002', '김선주', '피부과', 10);
INSERT INTO 의사테이블(의사번호, 의사이름, 소속, 근무연수)
	VALUES ('D003', '정성호', '정형외과', 15);
SELECT * FROM 의사테이블;

-- 6. 환자테이블을 생성하는 SQL문을 작성하세요. 단, 환자이름 속성은 NULL값이 허용되지 않도록 지정하고, 담당의사 속성을 의사 테이블의 의사번호 속성을 참조하는 외래키로 지정하세요.
CREATE TABLE 환자테이블 (
환자번호 VARCHAR(20) PRIMARY KEY,
환자이름 VARCHAR(20) NOT NULL,
나이 INTEGER,
담당의사 VARCHAR(20),
FOREIGN KEY (담당의사) REFERENCES 의사테이블(의사번호) ON DELETE CASCADE);


-- 6.1 그 안에 데이터를 채워넣으시오.
INSERT INTO 환자테이블(환자번호, 환자이름, 나이, 담당의사)
	VALUES ('P001', '오우진', 31, 'D002');
INSERT INTO 환자테이블(환자번호, 환자이름, 나이, 담당의사)
	VALUES ('P002', '채광주', 50, 'D001');
INSERT INTO 환자테이블(환자번호, 환자이름, 나이, 담당의사)
	VALUES ('P003', '김용욱', 43, 'D003');
    
-- 8. 소속별로 의사의 수와 평균 근무연수를 검색하는 SQL문을 작성하세요.
SELECT 소속, COUNT(의사번호) AS 의사의수 , AVG(근무연수) AS 평균근무연수 
	FROM 의사테이블 
    GROUP BY 소속;

-- 9. 김용욱 환자를 담당하는 의사의 의사이름과 소속, 근무연수를 검색하는 SQL문을 작성하세요.
SELECT 의사이름, 소속, 근무연수 
	FROM 의사테이블,환자테이블 
    WHERE 의사테이블.의사번호 = 환자테이블.담당의사 and 환자테이블.담당의사 =(SELECT 담당의사 FROM 환자테이블 WHERE 환자이름 LIKE '김용욱');
    
-- 10. 본인의 이름으로 의사 테이블에 새로운 레코드를 추가하는 SQL문을 작성하세요. 단, 소속과 근무연수는 자유롭게 지정하세요.
INSERT INTO 의사테이블(의사번호, 의사이름, 소속, 근무연수)
	VALUES ('D004','김동훈', '정형외과', 15);
SELECT * FROM 의사테이블;

-- 11. 방지호 고객의 주문수량을 10% 증가시키는 SQL문을 작성하세요.
SELECT 이름, 주문수량 + (주문수량 * 0.1) 
	FROM 주문, 고객 
    WHERE 주문.고객번호 = 고객.고객번호 AND 고객.이름 LIKE '방지호';

-- 12. 가격이 가장 최소인 제품의 제품명을 중복 없이 검색하는 SQL문을 작성하세요.
SELECT DISTINCT 제품명
	FROM 제품 
    WHERE 가격 = (SELECT MIN(가격) FROM 제품);

-- 13. 재고량이 100개 이하인 제품을 모두 삭제하는 SQL문을 작성하세요.
DELETE 
	FROM 제품 
    WHERE 재고량 <= 100;
SELECT * FROM 제품;

-- 14.주문수량의 총계가 300개 이상인 고객에 대해 고객별 주문횟수와 주문수량의 총계를 검색하는 SQL문을 작성하세요.
SELECT 이름, COUNT(*) AS 주문횟수 , SUM(o1.주문수량) AS 주문수량총계 
	FROM 고객 c2, 주문 o1 
    WHERE ((SELECT SUM(o2.주문수량) 
		FROM 주문 o2, 고객 c1 
		WHERE c1.고객번호 = o2.고객번호 AND c1.고객번호 = c2.고객번호 AND o2.고객번호 = o1.고객번호 
        GROUP BY o2.고객번호) >= 300) GROUP BY c2.이름;
-- 15. 제품명에 ‘위’가 포함된 제품을 주문한 고객의 이름을 검색하는 SQL문을 작성하세요.
SELECT 이름 
	FROM 고객 
    WHERE 고객번호 IN (SELECT 고객번호 FROM 주문 WHERE 제품번호 IN (SELECT 제품번호 FROM 제품 WHERE 제품명 LIKE '%위%'));




SELECT 고객번호 FROM 주문 WHERE 제품번호 IN (SELECT 제품번호 FROM 제품 WHERE 제품명 LIKE '%위%');
SELECT p2.제품번호 FROM 제품 p2 WHERE p2.제품명 LIKE '%위%';
SELECT * FROM 주문;
SELECT * FROM 제품;
INSERT INTO 제품(제품번호, 제품명, 재고량, 가격)
	VALUES ('J005', '위로', 200, 3000);
SELECT * FROM 주문;
INSERT INTO 주문(주문번호, 고객번호, 제품번호, 판매자번호, 주문수량)
	VALUES ('O006', 'P003', 'J004', 'S001', 50);
INSERT INTO 제품(제품번호, 제품명, 재고량, 가격)
	VALUES ('J006', '위로', 50, 3000);
INSERT INTO 제품(제품번호, 제품명, 재고량, 가격)
	VALUES ('J003', '우액', 70, 3000);
INSERT INTO 주문(주문번호,고객번호,제품번호,판매자번호,주문수량)
VALUES ('O004','P001','J002','S001',200);
INSERT INTO 주문(주문번호,고객번호,제품번호,판매자번호,주문수량)
VALUES ('O003','P002','J004','S001',400);