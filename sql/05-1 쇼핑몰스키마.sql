-- 1. 객체 제거
DROP TABLE goods_images CASCADE CONSTRAINTS PURGE;
DROP TABLE goods_price CASCADE CONSTRAINTS PURGE;
DROP TABLE products CASCADE CONSTRAINTS PURGE;

-- 2. 제품 테이블 생성
CREATE TABLE products (
    goods_no NUMBER PRIMARY KEY,
    goods_name VARCHAR2(300) NOT NULL,
    cate_code1 NUMBER(3) NOT NULL,
    cate_code2 NUMBER(3) NOT NULL,
    cate_code3 NUMBER(3) NOT NULL,
    cate_name VARCHAR2(30) NOT NULL,
    image_name VARCHAR2(300),
    content VARCHAR2(2000),
    company VARCHAR2(60) NOT NULL,
    product_date DATE NOT NULL
);

-- 샘플 데이터 입력 (예시)
INSERT INTO products (goods_no, goods_name, cate_code1, cate_code2, cate_code3, cate_name, image_name, content, company, product_date) 
VALUES (1, '예시 상품 1', 101, 202, 303, '카테고리 이름', 'image1.jpg', '상품 설명입니다.', '제조사명', SYSDATE);

INSERT INTO products (goods_no, goods_name, cate_code1, cate_code2, cate_code3, cate_name, image_name, content, company, product_date) 
VALUES (2, '예시 상품 2', 101, 202, 304, '카테고리 이름', 'image2.jpg', '상품 설명입니다.', '제조사명', SYSDATE);

INSERT INTO products (goods_no, goods_name, cate_code1, cate_code2, cate_code3, cate_name, image_name, content, company, product_date) 
VALUES (3, '예시 상품 3', 101, 203, 305, '카테고리 이름', 'image3.jpg', '상품 설명입니다.', '제조사명', SYSDATE);

-- 3. 상품 가격 테이블 생성
CREATE TABLE goods_price (
    goods_price_no NUMBER PRIMARY KEY,
    price NUMBER(9),
    discount NUMBER(9),
    sale_price NUMBER(9) NOT NULL,
    delivery_charge NUMBER(6),
    sale_start_date DATE NOT NULL,
    sale_end_date DATE NOT NULL,
    goods_no NUMBER,
    FOREIGN KEY (goods_no) REFERENCES products(goods_no)  -- products 테이블과의 외래 키 관계 설정
);

-- 샘플 데이터 입력 (예시)
INSERT INTO goods_price (goods_price_no, price, discount, sale_price, delivery_charge, sale_start_date, sale_end_date, goods_no) 
VALUES (1, 100000, 10000, 90000, 3000, TO_DATE('2024-10-01', 'YYYY-MM-DD'), TO_DATE('2024-10-31', 'YYYY-MM-DD'), 1);

INSERT INTO goods_price (goods_price_no, price, discount, sale_price, delivery_charge, sale_start_date, sale_end_date, goods_no) 
VALUES (2, 150000, 15000, 135000, 3000, TO_DATE('2024-11-01', 'YYYY-MM-DD'), TO_DATE('2024-11-30', 'YYYY-MM-DD'), 2);

INSERT INTO goods_price (goods_price_no, price, discount, sale_price, delivery_charge, sale_start_date, sale_end_date, goods_no) 
VALUES (3, 200000, 20000, 180000, 3000, TO_DATE('2024-12-01', 'YYYY-MM-DD'), TO_DATE('2024-12-31', 'YYYY-MM-DD'), 3);

-- 4. 상품 이미지 테이블 생성
CREATE TABLE goods_images (
    goods_image_no NUMBER PRIMARY KEY,
    image_name VARCHAR2(300),
    goods_no NUMBER,
    FOREIGN KEY (goods_no) REFERENCES products(goods_no)  -- products 테이블과의 외래 키 관계 설정
);

-- 샘플 데이터 입력 (예시)
INSERT INTO goods_images (goods_image_no, image_name, goods_no) 
VALUES (1, 'image1.jpg', 1);

INSERT INTO goods_images (goods_image_no, image_name, goods_no) 
VALUES (2, 'image2.jpg', 2);

INSERT INTO goods_images (goods_image_no, image_name, goods_no) 
VALUES (3, 'image3.jpg', 3);

-- 5. 데이터 조회 예시
SELECT p.*, gp.*, gi.*
FROM products p
JOIN goods_price gp ON p.goods_no = gp.goods_no
JOIN goods_images gi ON p.goods_no = gi.goods_no;