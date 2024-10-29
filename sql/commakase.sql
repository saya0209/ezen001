-- 1. 객체 삭제
-- 리뷰 테이블 삭제
drop table reply CASCADE CONSTRAINTS;
-- 장바구니 테이블 삭제
drop table cart CASCADE CONSTRAINTS;
-- 결제 테이블 삭제
drop table payment CASCADE CONSTRAINTS;

-- 시퀀스 삭제
DROP SEQUENCE reply_seq;
DROP SEQUENCE cart_seq;
DROP SEQUENCE payment_seq;

-- 2. 객체 생성
    -- 2-1. 리뷰
    CREATE TABLE reply (
    ID VARCHAR2(30),
    PW VARCHAR2(60),
    write_date DATE,
    content VARCHAR2(300),
    star_point NUMBER(5),
    image_name VARCHAR2(300),
    good_point NUMBER(10),
    reply_no NUMBER PRIMARY KEY,
    goods_no NUMBER,
    goods_name VARCHAR2(300)
);

    -- 2-1. 장바구니
    CREATE TABLE cart (
        goods_no NUMBER NOT NULL,
        goods_name VARCHAR2(300) NOT NULL,
        image_name VARCHAR2(300),
        price NUMBER NOT NULL,
        goods_cnt NUMBER NOT NULL,
        goods_total_price NUMBER NOT NULL, 
        selected_goods_price NUMBER NOT NULL,
        delivery_charge NUMBER,
        cart_no NUMBER PRIMARY KEY NOT NULL,
        discount NUMBER,
        total_discount NUMBER,
        final_price NUMBER,
        selected NUMBER(1) DEFAULT 0 NOT NULL -- 0: false, 1: true    
        );
        
    -- 2-1. 결제
    CREATE TABLE payment (
        goods_no NUMBER NOT NULL,
        goods_name VARCHAR2(300) NOT NULL,
        image_name VARCHAR2(300),
        price NUMBER NOT NULL,
        goods_cnt NUMBER NOT NULL,
        goods_total_price NUMBER NOT NULL, 
        delivery_charge NUMBER,
        cart_no NUMBER NOT NULL,
        total_discount NUMBER,
        final_price NUMBER,
        delivery_place VARCHAR2(300),
        payment_id NUMBER,
        created_at DATE,
        payment_status NUMBER
        );
    
    CREATE SEQUENCE reply_seq;
    CREATE SEQUENCE cart_seq;
    CREATE SEQUENCE payment_seq;