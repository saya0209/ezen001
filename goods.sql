DROP TABLE goods CASCADE CONSTRAINTS PURGE;

CREATE TABLE goods (
    goods_no NUMBER PRIMARY KEY,    -- 상품 고유 번호
    goods_name VARCHAR2(255),       -- 상품명
    company VARCHAR2(255),          -- 제조사
    price NUMBER,                   -- 가격
    discount NUMBER,                -- 할인금액
    pro_code1 NUMBER,          
    pro_code2 NUMBER,       
    image_name VARCHAR2(255)        -- 이미지 파일명
);

INSERT INTO goods(goods_no, goods_name, company, price, discount, pro_code1, pro_code2, image_name) 
VALUES (1, 'computer', 'Hosun', 300000, 90000, '1', '3', 'computer');

commit;
