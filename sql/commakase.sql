-- ★★★★★★ NOTICE (SEQ O) (DROP, CREATE, INSERT, 예시) ★★★★★★ ----------------------------------------------------------
drop table notice CASCADE CONSTRAINTS PURGE;
drop SEQUENCE notice_seq;

CREATE TABLE notice (
    notice_no NUMBER PRIMARY KEY,
    writer_id VARCHAR2(50) NOT NULL,
    title VARCHAR2(300) NOT NULL,
    content VARCHAR2(2000) NOT NUll,
    writeDate DATE DEFAULT sysDate,
    startDate DATE DEFAULT sysDate,
    endDate DATE DEFAULT sysDate,
    updateDate DATE DEFAULT sysDate,
    image VARCHAR2(2000)
);

CREATE SEQUENCE notice_seq;

-- 현재 공지
INSERT INTO notice (notice_no, writer_id, title, content, startDate, endDate, image) 
VALUES (notice_seq.NEXTVAL, 'admin', '신제품 그래픽 카드 입고 안내', '최신 그래픽 카드가 입고되었습니다! 빠른 구매를 권장합니다.', 
TO_DATE('2024-10-01', 'YYYY-MM-DD'), TO_DATE('2024-12-31', 'YYYY-MM-DD'), 'new_gpu.jpg');

-- 지난 공지
INSERT INTO notice (notice_no, writer_id, title, content, startDate, endDate, image) 
VALUES (notice_seq.NEXTVAL, 'admin', '여름 맞이 쿨러 할인 행사', 'CPU 및 케이스 쿨러 할인 이벤트가 종료되었습니다.', 
TO_DATE('2024-06-01', 'YYYY-MM-DD'), TO_DATE('2024-08-31', 'YYYY-MM-DD'), 'summer_cooler_sale.jpg');

-- 예정 공지
INSERT INTO notice (notice_no, writer_id, title, content, startDate, endDate, image) 
VALUES (notice_seq.NEXTVAL, 'admin', '블랙 프라이데이 특가 행사', 'RAM과 SSD 특가 행사가 예정되어 있습니다. 놓치지 마세요!', 
TO_DATE('2024-11-20', 'YYYY-MM-DD'), TO_DATE('2024-11-30', 'YYYY-MM-DD'), 'black_friday_sale.jpg');

-- ★★★ COMMUNITY, COMMUNITY_REPLY (SEQ O) (DROP, CREATE, INSERT, 예시) ----------------------------------------------------------
DROP TABLE community CASCADE CONSTRAINTS PURGE;
DROP SEQUENCE community_seq;
DROP TABLE community_reply CASCADE CONSTRAINTS PURGE;
DROP SEQUENCE community_reply_seq;

CREATE TABLE community (
    community_no NUMBER PRIMARY KEY,
    id VARCHAR2(50) NOT NULL, FOREIGN KEY (id) REFERENCES member(id),
    title VARCHAR2(300) NOT NULL,
    content VARCHAR2(2000) NOT NULL,
    writeDate DATE DEFAULT Sysdate,
    start_date DATE,
    endDate DATE,
    hit NUMBER DEFAULT 0, -- 변경된 부분
    updateDate DATE,
    image VARCHAR2(2000)
);

CREATE SEQUENCE community_seq;

CREATE TABLE community_reply (
    reply_no NUMBER PRIMARY KEY,  
    post_no NUMBER NOT NULL,
    parent_no NUMBER NULL,   
    id VARCHAR2(20) REFERENCES member(id) NOT NULL, -- 회원만 사용가능
    content VARCHAR2(600) NOT NULL,
    writeDate DATE DEFAULT sysdate,
    updateDate DATE DEFAULT sysdate,
    likeCnt NUMBER DEFAULT 0,
    dislikeCnt NUMBER DEFAULT 0,
    image VARCHAR2(2000) NULL  
);

CREATE SEQUENCE community_reply_seq;

-- 첫 번째 커뮤니티 게시물
INSERT INTO community (community_no, id, title, content, writeDate, start_date, endDate, hit, image) 
VALUES (community_seq.NEXTVAL, 'admin', '최신 그래픽 카드 추천', 
        '2024년 최고의 그래픽 카드 리스트를 공유합니다. 성능과 가격대비 최고의 선택은 무엇일까요?', 
        SYSDATE, NULL, NULL, 0, 'graphic_card.jpg');
        
-- 두 번째 커뮤니티 게시물
INSERT INTO community (community_no, id, title, content, writeDate, start_date, endDate, hit, image) 
VALUES (community_seq.NEXTVAL, 'admin', '조립 PC 후기', 
        '최근에 조립한 PC에 대한 후기를 공유합니다. 사용 후기와 팁을 알고 싶으신 분들은 댓글 주세요!', 
        SYSDATE, NULL, NULL, 0, 'pc_build_review.jpg');

-- 댓글 데이터 삽입
INSERT INTO community_reply(reply_no, post_no, parent_no, id, content, writeDate, updateDate, likeCnt, dislikeCnt, image) 
VALUES (community_reply_seq.nextval, 1, NULL, 'user1', '이 그래픽 카드의 성능이 궁금합니다. 어떤 게임에서 테스트해봤나요?', sysdate, sysdate, 0, 0, NULL);

INSERT INTO community_reply(reply_no, post_no, parent_no, id, content, writeDate, updateDate, likeCnt, dislikeCnt, image) 
VALUES (community_reply_seq.nextval, 1, NULL, 'user2', '최고의 CPU 추천 부탁드립니다. 가성비 좋은 제품이 필요해요.', sysdate, sysdate, 0, 0, NULL);

-- 대댓글 데이터 삽입
INSERT INTO community_reply(reply_no, post_no, parent_no, id, content, writeDate, updateDate, likeCnt, dislikeCnt, image) 
VALUES (community_reply_seq.nextval, 1, 1, 'user2', '이 그래픽 카드의 성능은 정말 뛰어납니다! 다양한 게임에서 성능이 좋습니다.', sysdate, sysdate, 0, 0, NULL);

INSERT INTO community_reply(reply_no, post_no, parent_no, id, content, writeDate, updateDate, likeCnt, dislikeCnt, image) 
VALUES (community_reply_seq.nextval, 1, 2, 'user1', 'CPU는 인텔 i5가 괜찮은 것 같습니다. 가성비가 좋고 성능도 우수해요.', sysdate, sysdate, 0, 0, NULL);
        
-- ★★★★★★ ANSWER, QNA (SEQ O) (DROP, CREATE, INSERT, 예시) ★★★★★★ ----------------------------------------------------------        
DROP TABLE answer CASCADE CONSTRAINTS PURGE;
DROP TABLE qna CASCADE CONSTRAINTS PURGE;
DROP SEQUENCE answer_seq;
DROP SEQUENCE qna_seq;

CREATE TABLE qna (
    qna_no NUMBER PRIMARY KEY,
    id VARCHAR2(50) not null, FOREIGN KEY (id) REFERENCES member(id),
    title VARCHAR2(300) NOT NULL,
    content VARCHAR2(2000) NOT NULL,
    writeDate DATE DEFAULT sysdate,
    category VARCHAR2(50) NOT NULL
);

CREATE TABLE answer (
    answer_no NUMBER PRIMARY KEY,
    id varchar2(50) not null, FOREIGN KEY (id) REFERENCES member(id),
    answer_title VARCHAR2(300) NOT NULL,
    answer_content VARCHAR2(2000) NOT NULL,
    answerDate DATE DEFAULT sysdate,
    refNo NUMBER REFERENCES answer(answer_no),
    ordNo NUMBER,
    levNo NUMBER,
    parentNo NUMBER REFERENCES answer(answer_no) ON DELETE CASCADE
);

CREATE SEQUENCE qna_seq START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE answer_seq START WITH 1 INCREMENT BY 1;

-- QnA 샘플 데이터 
INSERT INTO qna (qna_no, id, title, content, writeDate, category)
VALUES (1, 'test1', '배송은 어떻게 하나요?', '배송 관련 질문입니다. 언제 받을 수 있나요?', sysdate, '배송');

INSERT INTO qna (qna_no, id, title, content, writeDate, category)
VALUES (2, 'test1', '환불 정책은 무엇인가요?', '환불 절차와 소요 시간에 대해 알고 싶습니다.', sysdate, '환불');

-- Answer 샘플 데이터
INSERT INTO answer (answer_no, id, answer_title, answer_content, answerDate, refNo, ordNo, levNo, parentNo)
VALUES (1, 'admin', '배송 안내', '배송은 3일 이내에 가능합니다.', sysdate, NULL, 1, 0, 1);

INSERT INTO answer (answer_no, id, answer_title, answer_content, answerDate, refNo, ordNo, levNo, parentNo)
VALUES (2, 'admin', '환불 안내', '환불은 요청 후 5일 이내에 처리됩니다.', sysdate, NULL, 1, 0, 2);

-- ★★★★★★ PRODUCT, GOODS_IMAGE, GOODS_PRICE (SEQ O) (DROP, CREATE, INSERT, 예시) ★★★★★★ ----------------------------------------------------------  

DROP TABLE products CASCADE CONSTRAINTS PURGE;
DROP TABLE goods_images CASCADE CONSTRAINTS PURGE;
DROP TABLE goods_price CASCADE CONSTRAINTS PURGE;

DROP SEQUENCE products_SEQ;
DROP SEQUENCE goods_images_SEQ;
DROP SEQUENCE goods_price_SEQ;

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

CREATE TABLE goods_images (
    goods_image_no NUMBER PRIMARY KEY,
    image_name VARCHAR2(300),
    goods_no NUMBER,
    FOREIGN KEY (goods_no) REFERENCES products(goods_no)  -- products 테이블과의 외래 키 관계 설정
);

CREATE SEQUENCE products_SEQ;
CREATE SEQUENCE goods_images_SEQ;
CREATE SEQUENCE goods_price_SEQ;

-- 샘플 데이터 입력 (PRODUCT)
INSERT INTO products (goods_no, goods_name, cate_code1, cate_code2, cate_code3, cate_name, image_name, content, company, product_date) 
VALUES (1, '예시 상품 1', 101, 202, 303, '카테고리 이름', 'image1.jpg', '상품 설명입니다.', '제조사명', SYSDATE);

INSERT INTO products (goods_no, goods_name, cate_code1, cate_code2, cate_code3, cate_name, image_name, content, company, product_date) 
VALUES (2, '예시 상품 2', 101, 202, 304, '카테고리 이름', 'image2.jpg', '상품 설명입니다.', '제조사명', SYSDATE);

INSERT INTO products (goods_no, goods_name, cate_code1, cate_code2, cate_code3, cate_name, image_name, content, company, product_date) 
VALUES (3, '예시 상품 3', 101, 203, 305, '카테고리 이름', 'image3.jpg', '상품 설명입니다.', '제조사명', SYSDATE);

-- 샘플 데이터 입력 (GOODS_PRICE)
INSERT INTO goods_price (goods_price_no, price, discount, sale_price, delivery_charge, sale_start_date, sale_end_date, goods_no) 
VALUES (1, 100000, 10000, 90000, 3000, TO_DATE('2024-10-01', 'YYYY-MM-DD'), TO_DATE('2024-10-31', 'YYYY-MM-DD'), 1);

INSERT INTO goods_price (goods_price_no, price, discount, sale_price, delivery_charge, sale_start_date, sale_end_date, goods_no) 
VALUES (2, 150000, 15000, 135000, 3000, TO_DATE('2024-11-01', 'YYYY-MM-DD'), TO_DATE('2024-11-30', 'YYYY-MM-DD'), 2);

INSERT INTO goods_price (goods_price_no, price, discount, sale_price, delivery_charge, sale_start_date, sale_end_date, goods_no) 
VALUES (3, 200000, 20000, 180000, 3000, TO_DATE('2024-12-01', 'YYYY-MM-DD'), TO_DATE('2024-12-31', 'YYYY-MM-DD'), 3);

-- 샘플 데이터 입력 (GOODS_IMAGE)
INSERT INTO goods_images (goods_image_no, image_name, goods_no) 
VALUES (1, 'image1.jpg', 1);

INSERT INTO goods_images (goods_image_no, image_name, goods_no) 
VALUES (2, 'image2.jpg', 2);

INSERT INTO goods_images (goods_image_no, image_name, goods_no) 
VALUES (3, 'image3.jpg', 3);

-- ★★★★★★ CATEGORY, COMPONENT (SEQ X) (DROP, CREATE, INSERT, 예시) ★★★★★★ ---------------------------------------------------------- 

DROP TABLE category CASCADE CONSTRAINTS PURGE;
DROP TABLE component CASCADE CONSTRAINTS PURGE;

CREATE TABLE category (
    cate_code1 NUMBER(3),
    cate_code2 NUMBER(3),
    cate_code3 NUMBER(3),
    cate_name VARCHAR2(30) NOT NULL,
    PRIMARY KEY (cate_code1, cate_code2, cate_code3) 
);

CREATE TABLE component (
    cate_code1 NUMBER(3),
    cate_code2 NUMBER(3),
    cate_name VARCHAR2(30) NOT NULL,
    PRIMARY KEY (cate_code1, cate_code2)
);

-- 샘플 데이터 삽입 (CATEGORY)
INSERT INTO category (cate_code1, cate_code2, cate_code3, cate_name) 
VALUES (1, 1, 1, '컴퓨터 주요 부품');

INSERT INTO category (cate_code1, cate_code2, cate_code3, cate_name) 
VALUES (1, 2, 1, '주변기기');


-- 샘플 데이터 삽입 (COMPONENT)
INSERT INTO component (cate_code1, cate_code2, cate_name) 
VALUES (1, 1, 'CPU');

INSERT INTO component (cate_code1, cate_code2, cate_name) 
VALUES (1, 2, '그래픽 카드');

-- ★★★★★★ GOODS_REPLY, CART, PAYMENT (SEQ O) (DROP, CREATE, INSERT) ★★★★★★ ----------------------------------------------------------

drop table goods_reply CASCADE CONSTRAINTS;
drop table cart CASCADE CONSTRAINTS;
drop table payment CASCADE CONSTRAINTS;

DROP SEQUENCE goods_reply_seq;
DROP SEQUENCE cart_seq;
DROP SEQUENCE payment_seq;

-- 2. 객체 생성
    -- 2-1. 리뷰
    CREATE TABLE goods_reply (
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
        id VARCHAR2(50) not null,
        goods_no NUMBER NOT NULL,
        goods_name VARCHAR2(300) NOT NULL,
        image_name VARCHAR2(300),
        price NUMBER NOT NULL,
        quantity NUMBER NOT NULL,
        goods_total_price NUMBER NOT NULL, 
        selected_goods_price NUMBER NOT NULL,
        delivery_charge NUMBER,
        cart_no NUMBER NOT NULL,
        item_no NUMBER NOT NULL,
        discount NUMBER,
        total_discount NUMBER,
        totalAmount NUMBER,
        selected NUMBER(1) DEFAULT 0 NOT NULL -- 0: false, 1: true    
        );
        
    -- 2-1. 결제
    CREATE TABLE payment (  
        goods_no NUMBER NOT NULL,
        goods_name VARCHAR2(300) NOT NULL,
        image_name VARCHAR2(300),
        price NUMBER NOT NULL,
        quantity NUMBER NOT NULL,
        goods_total_price NUMBER NOT NULL, 
        delivery_charge NUMBER,
        cart_no NUMBER NOT NULL,
        total_discount NUMBER,
        totalAmount NUMBER,
        delivery_place VARCHAR2(300),
        payment_id NUMBER,
        created_at DATE,
        payment_status NUMBER
        );
    
CREATE SEQUENCE goods_reply_seq;
CREATE SEQUENCE cart_seq;
CREATE SEQUENCE payment_seq;

-- 샘플데이터 추가
     -- 샘플 데이터 1
    INSERT INTO cart (id, goods_no, goods_name, image_name, price, quantity, goods_total_price, 
                   selected_goods_price, delivery_charge, cart_no, discount, total_discount, 
                   totalAmount, selected, item_no)
    VALUES (1, 1001, '스마트폰', 'smartphone.jpg', 500000, 1, 500000, 
        0, 3000, 1, 0, 0, 503000, 0, cart_seq.NEXTVAL);

    -- 샘플 데이터 2
    INSERT INTO cart (id, goods_no, goods_name, image_name, price, quantity, goods_total_price, 
                   selected_goods_price, delivery_charge, cart_no, discount, total_discount, 
                   totalAmount, selected, item_no)
    VALUES (1, 1002, '노트북', 'laptop.jpg', 1200000, 1, 1200000, 
        0, 5000, 1, 100000, 0, 1100000, 1, cart_seq.NEXTVAL);

    -- 샘플 데이터 3
    INSERT INTO cart (id, goods_no, goods_name, image_name, price, quantity, goods_total_price, 
                   selected_goods_price, delivery_charge, cart_no, discount, total_discount, 
                   totalAmount, selected, item_no)
    VALUES (1, 1003, '헤드폰', 'headphones.jpg', 150000, 2, 300000, 
        0, 0, 1, 0, 0, 300000, 0, cart_seq.NEXTVAL);
        
         -- 샘플 데이터 1
    INSERT INTO cart (id, goods_no, goods_name, image_name, price, quantity, goods_total_price, 
                   selected_goods_price, delivery_charge, cart_no, discount, total_discount, 
                   totalAmount, selected, item_no)
    VALUES (2, 1001, '스마트폰', 'smartphone.jpg', 500000, 1, 500000, 
        0, 3000, 1, 0, 0, 503000, 0, cart_seq.NEXTVAL);

    -- 샘플 데이터 2
    INSERT INTO cart (id, goods_no, goods_name, image_name, price, quantity, goods_total_price, 
                   selected_goods_price, delivery_charge, cart_no, discount, total_discount, 
                   totalAmount, selected, item_no)
    VALUES (2, 1002, '노트북', 'laptop.jpg', 1200000, 1, 1200000, 
        0, 5000, 1, 100000, 0, 1100000, 1, cart_seq.NEXTVAL);

    -- 샘플 데이터 3
    INSERT INTO cart (id, goods_no, goods_name, image_name, price, quantity, goods_total_price, 
                   selected_goods_price, delivery_charge, cart_no, discount, total_discount, 
                   totalAmount, selected, item_no)
    VALUES (2, 1003, '헤드폰', 'headphones.jpg', 150000, 2, 300000, 
        0, 0, 1, 0, 0, 300000, 0, cart_seq.NEXTVAL);
commit;

-- ★★★★★★ MEMBER, GRADE (SEQ O) (DROP, CREATE, INSERT, 예시) ★★★★★★ ----------------------------------------------------------
drop table member cascade constraints purge;
drop table grade cascade constraints purge;

create table grade (
    gradeNo number(1) primary key,
    gradeName varchar2(21) not null, unique (gradeName)
);

create table member(
    gradeno  number(1) default 1 references grade(gradeNo),
    gradeName varchar2(21) default '일반회원' references grade(gradeName),
    status  varchar2(6) default '정상',
    id varchar2(20) primary key,
    pw varchar2(20) not null,
    nicname varchar2(30) not null,
    tel  varchar2(13),
    email varchar2(50) not null,
    address varchar2(100) not null,
    regDate date default sysDate,
    conDate date default sysDate,
    grade_image  varchar2(100)
);

insert into grade values (1, '일반회원');
insert into grade values (9, '관리자');
commit;

insert into member (id, pw, nicname, email, address, gradeNo) values('admin','admin','김관리','mukgabi@naver.com','서울 강남구 도산대로 10길 4, 새빛나라아파트 109동 2202호',9);
insert into member (id, pw, nicname, email, address, gradeNo) values('test1','test1','홍길동','test1@naver.com','경기 시흥시 광명12길 3, 파란색 대문 앞',1);
insert into member (id, pw, nicname, email, address, gradeNo) values('user1','user1','김유저','user1@gmail.com','서울 노원구 창석로길 2-1, 201호',1);
insert into member (id, pw, nicname, email, address, gradeNo) values('user2','user2','박유저','user2@gmail.com','강원 동해시 낙수대로 38, 낙수힐스테이트 312동 101호',1);
commit;

SELECT goods_no, COUNT(*) FROM cart GROUP BY goods_no HAVING COUNT(*) > 1;
