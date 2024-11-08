DROP TABLE goods_price CASCADE CONSTRAINTS PURGE;



-- 3. 상품 가격 테이블 생성
CREATE TABLE goods_price (
    goods_price_no NUMBER PRIMARY KEY,
    price NUMBER(9),
    discount NUMBER(9),
    sale_price NUMBER(9) NOT NULL,
    delivery_charge NUMBER(6),
    goods_no NUMBER,
    FOREIGN KEY (goods_no) REFERENCES products(goods_no)  -- products 테이블과의 외래 키 관계 설정
);

-- 샘플 데이터 입력 (예시)
INSERT INTO goods_price (goods_price_no, price, discount, sale_price, delivery_charge, goods_no) 
VALUES (1, 100000, 10000, 90000, 3000, 1);