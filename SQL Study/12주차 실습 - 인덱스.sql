-- 질의1: bookname 열을 대상으로 ix_book 인덱스를 생성
CREATE INDEX ix_book ON Book(bookname);

-- 질의2: publisher, price 열을 대상으로 ix_book2 인덱스를 생성
SELECT * FROM Book WHERE publisher='대한미디어' AND price>=3000; #Full Table을 Scan해서 조건을 탐색함. 1.45초 걸렸음.

CREATE INDEX ix_book2 ON Book(publisher, price);
SELECT * FROM Book WHERE publisher='대한미디어' AND price>=3000; #Index Range를 Scan해서 조건을 탐색함.(2개의 로우만 탐색할 수 있음.) 1.16초 걸렸음.

-- 질의3: Book테이블의 인덱스를 최적화
Analyze TABLE Book;

-- 질의4: ix_book, ix_book2를 삭제하세요. #2개의 인덱스를 한번에 삭제할 수 없다. 각각 삭제해야함. 
DROP INDEX ix_book ON Book;
DROP INDEX ix_book2 ON Book;