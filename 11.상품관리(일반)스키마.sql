-- 상품관리 (일반적인사항) goods
-- 상품번호(PK), 상품명, 설명, 작성일, 제조일, 모델번호, 제조사, 이미지이름, 배송비

-- 1. 삭제 (기존 테이블 및 시퀀스 삭제)
drop table goods CASCADE CONSTRAINTS PURGE;
DROP TABLE goods_price CASCADE CONSTRAINTS PURGE;
drop sequence goods_seq;
DROP SEQUENCE goods_price_SEQ;

-- 2. 테이블 생성
create table goods (
    goods_no number UNIQUE,
    goods_name varchar2(300) not null,
    cate_code1 number,
    cate_code2 number,
    content varchar2(2000) not null,
    writeDate date default sysDate,
    product_Date date,
    company varchar2(30) not null,
    image_Name varchar2(200) not null,
    primary key (goods_no, cate_code1, cate_code2)  -- 복합키로 설정
);

CREATE TABLE goods_price (
    goods_price_no NUMBER PRIMARY KEY,
    price NUMBER(9),
    discount NUMBER(9),
    sale_price NUMBER(9) NOT NULL,
    delivery_charge NUMBER(6),
    goods_no NUMBER REFERENCES goods(goods_no)
);

-- 3. 시퀀스 생성
create SEQUENCE goods_seq;
CREATE SEQUENCE goods_price_SEQ;

-- 4. 샘플 데이터 입력
INSERT INTO goods (goods_no, goods_name, cate_code1, cate_code2, image_name, content, company, product_date)
VALUES (goods_seq.nextval, '예시 상품 1', 101, 202, 'image1.jpg', '상품 설명입니다.', '제조사명', SYSDATE);