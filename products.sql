DROP TABLE products CASCADE CONSTRAINTS PURGE;

CREATE TABLE products (
    goods_no NUMBER PRIMARY KEY,
    goods_name VARCHAR2(300) NOT NULL,
    pro_code1 NUMBER(3) NOT NULL,
    pro_code2 NUMBER(3) NOT NULL,
    image_name VARCHAR2(300),
    company VARCHAR2(60) NOT NULL,
    price NUMBER(10) NOT NULL
);

INSERT INTO products (goods_no, goods_name, pro_code1, pro_code2, image_name, company, price) 
VALUES (1, '예시 상품 1', 101, 202, 'image1.jpg', '제조사명', 100000);