-- 질의1 : 대한민국에서 거주하는 고객의 이름과 도서를 주문한 고객의 이름을 검색하세요.
SELECT name FROM Customer WHERE address LIKE '대한민국%'
UNION #UNION ALL을 하면 겹치는 것을 제거하지않고 모두 보여준다.
SELECT name FROM Customer WHERE custid IN (SELECT custid FROM Orders);

-- 질의2 : 대한민국에서 거주하는 고객의 이름에서 도서를 주문한 고객의 이름을 빼고 검색하세요.
SELECT name FROM Customer WHERE address LIKE '대한민국%'
								AND name NOT IN (SELECT name 
												 FROM Customer 
                                                 WHERE custid IN (SELECT custid FROM Orders));
                                                 
-- 질의3 : 대한민국에서 거주하는 고객 중 도서를 주문한 고객의 이름을 검색하세요.
SELECT name FROM Customer WHERE address LIKE '대한민국%'
								AND name IN (SELECT name 
											 FROM Customer 
											 WHERE custid IN (SELECT custid FROM Orders));
                                             
 -- 질의4 : 주문이 있는 고객의 이름과 주소를 검색하세요.
 SELECT name, address FROM Customer WHERE custid IN (SELECT custid FROM Orders);
 SELECT name, address FROM Customer cs WHERE EXISTS (SELECT * FROM Orders od
													 WHERE cs.custid = od.custid);
                                                     
-- 질의4-1 : 주문이 없는 고객의 이름과 주소를 검색하세요.
 SELECT name, address FROM Customer cs WHERE NOT EXISTS (SELECT * FROM Orders od
													 WHERE cs.custid = od.custid);
                                                     