-- �ڡڡڡڡڡ� NOTICE (SEQ O) (DROP, CREATE, INSERT, ����) �ڡڡڡڡڡ� ----------------------------------------------------------
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
    files VARCHAR2(2000)
);

CREATE SEQUENCE notice_seq;

-- ���� ����
INSERT INTO notice (notice_no, writer_id, title, content, startDate, endDate, files) 
VALUES (notice_seq.NEXTVAL, 'admin', '����ǰ �׷��� ī�� �԰� �ȳ�', '�ֽ� �׷��� ī�尡 �԰�Ǿ����ϴ�! ���� ���Ÿ� �����մϴ�.', 
TO_DATE('2024-10-01', 'YYYY-MM-DD'), TO_DATE('2024-12-31', 'YYYY-MM-DD'), 'new_gpu.jpg');

-- ���� ����
INSERT INTO notice (notice_no, writer_id, title, content, startDate, endDate, files) 
VALUES (notice_seq.NEXTVAL, 'admin', '���� ���� �� ���� ���', 'CPU �� ���̽� �� ���� �̺�Ʈ�� ����Ǿ����ϴ�.', 
TO_DATE('2024-06-01', 'YYYY-MM-DD'), TO_DATE('2024-08-31', 'YYYY-MM-DD'), 'summer_cooler_sale.jpg');

-- ���� ����
INSERT INTO notice (notice_no, writer_id, title, content, startDate, endDate, files) 
VALUES (notice_seq.NEXTVAL, 'admin', '�� �����̵��� Ư�� ���', 'RAM�� SSD Ư�� ��簡 �����Ǿ� �ֽ��ϴ�. ��ġ�� ������!', 
TO_DATE('2024-11-20', 'YYYY-MM-DD'), TO_DATE('2024-11-30', 'YYYY-MM-DD'), 'black_friday_sale.jpg');

-- �ڡڡ� COMMUNITY, COMMUNITY_REPLY (SEQ O) (DROP, CREATE, INSERT, ����) ----------------------------------------------------------
DROP TABLE community CASCADE CONSTRAINTS PURGE;
DROP SEQUENCE community_seq;
DROP TABLE community_reply CASCADE CONSTRAINTS PURGE;
DROP SEQUENCE community_reply_seq;

CREATE TABLE community (
    community_no NUMBER PRIMARY KEY,
    id VARCHAR2(50) NOT NULL, 
    FOREIGN KEY (id) REFERENCES member(id),
    title VARCHAR2(300) NOT NULL,
    content VARCHAR2(2000) NOT NULL,
    writeDate DATE DEFAULT sysdate,
    hit NUMBER DEFAULT 0,  -- ����� �κ�
    updateDate DATE DEFAULT sysDate,
    likeCnt NUMBER DEFAULT 0,
    dislikeCnt NUMBER DEFAULT 0,
    image VARCHAR2(2000)
);

CREATE SEQUENCE community_seq;

CREATE TABLE community_reply (
    rno NUMBER PRIMARY KEY,  
    post_no NUMBER NOT NULL,
    parent_no NUMBER NULL,   
    id VARCHAR2(20) REFERENCES member(id) NOT NULL, -- �α��� ȸ���� ��� ����
    content VARCHAR2(600) NOT NULL,
    writeDate DATE DEFAULT sysdate,
    updateDate DATE DEFAULT sysdate,
    likeCnt NUMBER DEFAULT 0,
    dislikeCnt NUMBER DEFAULT 0,
    image VARCHAR2(2000) NULL  
);

CREATE SEQUENCE community_reply_seq;

-- ù ��° Ŀ�´�Ƽ �Խù�
INSERT INTO community (community_no, id, title, content, writeDate, hit, likeCnt, dislikeCnt, image) 
VALUES (community_seq.NEXTVAL, 'admin', '�ֽ� �׷��� ī�� ��õ', 
        '2024�� �ְ��� �׷��� ī�� ����Ʈ�� �����մϴ�. ���ɰ� ���ݴ�� �ְ��� ������ �����ϱ��?', 
        SYSDATE, 0, 0, 0, 'graphic_card.jpg');
        
-- �� ��° Ŀ�´�Ƽ �Խù�
INSERT INTO community (community_no, id, title, content, writeDate, hit, likeCnt, dislikeCnt, image) 
VALUES (community_seq.NEXTVAL, 'admin', '���� PC �ı�', 
        '�ֱٿ� ������ PC�� ���� �ı⸦ �����մϴ�. ��� �ı�� ���� �˰� ������ �е��� ��� �ּ���!', 
        SYSDATE, 0, 0, 0, 'pc_build_review.jpg');
        
-- 3 Ŀ�´�Ƽ �Խù�
INSERT INTO community (community_no, id, title, content, writeDate, hit, likeCnt, dislikeCnt, image) 
VALUES (community_seq.NEXTVAL, 'admin', '�ֽ� �׷���ī��', 
        '���� ��δ�', 
        SYSDATE, 0, 0, 0, 'NULL');

-- ��� ������ ����
INSERT INTO community_reply(rno, post_no, parent_no, id, content, writeDate, updateDate, likeCnt, dislikeCnt, image) 
VALUES (community_reply_seq.nextval, 1, NULL, 'user1', '�� �׷��� ī���� ������ �ñ��մϴ�. � ���ӿ��� �׽�Ʈ�غó���?', sysdate, sysdate, 0, 0, NULL);

INSERT INTO community_reply(rno, post_no, parent_no, id, content, writeDate, updateDate, likeCnt, dislikeCnt, image) 
VALUES (community_reply_seq.nextval, 1, NULL, 'user2', '�ְ��� CPU ��õ ��Ź�帳�ϴ�. ������ ���� ��ǰ�� �ʿ��ؿ�.', sysdate, sysdate, 0, 0, NULL);

-- ���� ������ ����
INSERT INTO community_reply(rno, post_no, parent_no, id, content, writeDate, updateDate, likeCnt, dislikeCnt, image) 
VALUES (community_reply_seq.nextval, 1, 1, 'user2', '�� �׷��� ī���� ������ ���� �پ�ϴ�! �پ��� ���ӿ��� ������ �����ϴ�.', sysdate, sysdate, 0, 0, NULL);

INSERT INTO community_reply(rno, post_no, parent_no, id, content, writeDate, updateDate, likeCnt, dislikeCnt, image) 
VALUES (community_reply_seq.nextval, 1, 2, 'user1', 'CPU�� ���� i5�� ������ �� �����ϴ�. ������ ���� ���ɵ� ����ؿ�.', sysdate, sysdate, 0, 0, NULL);
         



-- DROP ALL
-- DROP TABLE
DROP TABLE answer CASCADE CONSTRAINTS PURGE;
DROP TABLE qna CASCADE CONSTRAINTS PURGE;
DROP TABLE products CASCADE CONSTRAINTS PURGE;
DROP TABLE goods_images CASCADE CONSTRAINTS PURGE;
DROP TABLE goods_price CASCADE CONSTRAINTS PURGE;
DROP TABLE category CASCADE CONSTRAINTS PURGE;
DROP TABLE component CASCADE CONSTRAINTS PURGE;
DROP TABLE goods_reply CASCADE CONSTRAINTS;
DROP TABLE cart CASCADE CONSTRAINTS;
DROP TABLE payment CASCADE CONSTRAINTS;
DROP TABLE member CASCADE constraints purge;
DROP TABLE grade CASCADE constraints purge;
DROP TABLE goods CASCADE CONSTRAINTS PURGE;

--SELECT table_name 
--FROM user_tables;
-- DROP SEQUENCE
DROP SEQUENCE answer_seq;
DROP SEQUENCE qna_seq;
DROP SEQUENCE products_SEQ;
DROP SEQUENCE goods_images_SEQ;
DROP SEQUENCE goods_price_SEQ;
DROP SEQUENCE goods_reply_seq;
DROP SEQUENCE cart_seq;
DROP SEQUENCE payment_seq;

-- TABLE ����
create table grade (
    gradeNo number(1) primary key,
    gradeName varchar2(21) not null, unique (gradeName)
);

create table member(
    gradeno  number(1) default 1 references grade(gradeNo),
    gradeName varchar2(21) default '�Ϲ�ȸ��' references grade(gradeName),
    status  varchar2(6) default '����',
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

--goods 
CREATE TABLE goods (
    goods_no NUMBER PRIMARY KEY,    -- ��ǰ ���� ��ȣ
    goods_name VARCHAR2(255),       -- ��ǰ��
    company VARCHAR2(255),          -- ������
    price NUMBER,                   -- ����
    discount NUMBER,                -- ���αݾ�
    pro_code1 NUMBER,          
    pro_code2 NUMBER,       
    image_name VARCHAR2(255)        -- �̹��� ���ϸ�
);

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

CREATE TABLE products (
    goods_no NUMBER PRIMARY KEY,
    goods_name VARCHAR2(300) NOT NULL,
    pro_code1 NUMBER(3) NOT NULL,
    pro_code2 NUMBER(3) NOT NULL,
    image_name VARCHAR2(300),
    company VARCHAR2(60) NOT NULL,
    price NUMBER(10) NOT NULL
);

-- 3. ��ǰ ���� ���̺� ����
CREATE TABLE goods_price (
    goods_price_no NUMBER PRIMARY KEY,
    price NUMBER(9),
    discount NUMBER(9),
    sale_price NUMBER(9) NOT NULL,
    delivery_charge NUMBER(6),
    goods_no NUMBER,
    FOREIGN KEY (goods_no) REFERENCES products(goods_no)  -- products ���̺���� �ܷ� Ű ���� ����
);


CREATE TABLE goods_images (
    goods_image_no NUMBER PRIMARY KEY,
    image_name VARCHAR2(300),
    goods_no NUMBER,
    FOREIGN KEY (goods_no) REFERENCES products(goods_no)  -- products ���̺���� �ܷ� Ű ���� ����
);

CREATE TABLE category (
    cate_code1 NUMBER(3),
    cate_code2 NUMBER(3),
    cate_name VARCHAR2(30) NOT NULL,
    PRIMARY KEY (cate_code1, cate_code2) 
);

CREATE TABLE component (
    cate_code1 NUMBER(3),
    cate_code2 NUMBER(3),
    cate_name VARCHAR2(30) NOT NULL,
    PRIMARY KEY (cate_code1, cate_code2)
);

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

CREATE TABLE cart (
    id varchar2(50) not null,
    goods_no NUMBER NOT NULL,
    goods_name VARCHAR2(300) NOT NULL,
    image_name VARCHAR2(300),
    price NUMBER NOT NULL,
    quantity NUMBER NOT NULL,
    goods_total_price NUMBER NOT NULL, 
    selected_goods_price NUMBER NOT NULL,
    delivery_charge NUMBER,
    cart_no NUMBER PRIMARY KEY NOT NULL,
    discount NUMBER,
    total_discount NUMBER,
    final_price NUMBER,
    selected NUMBER(1) DEFAULT 0 NOT NULL -- 0: false, 1: true    
);

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



-- SEQUENCE ����
CREATE SEQUENCE qna_seq START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE answer_seq START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE products_SEQ;
CREATE SEQUENCE goods_images_SEQ;
CREATE SEQUENCE goods_price_SEQ;
CREATE SEQUENCE goods_reply_seq;
CREATE SEQUENCE cart_seq;
CREATE SEQUENCE payment_seq;


-- ���� ������ ����
-- member sample data
insert into grade values (1, '�Ϲ�ȸ��');
insert into grade values (9, '������');

insert into member (id, pw, nicname, email, address, gradeNo) values('admin','admin','�����','mukgabi@naver.com','���� ������ ������ 10�� 4, �����������Ʈ 109�� 2202ȣ',9);
insert into member (id, pw, nicname, email, address, gradeNo) values('test1','test1','ȫ�浿','test1@naver.com','��� ����� ����12�� 3, �Ķ��� �빮 ��',1);
insert into member (id, pw, nicname, email, address, gradeNo) values('user1','user1','������','user1@gmail.com','���� ����� â���α� 2-1, 201ȣ',1);
insert into member (id, pw, nicname, email, address, gradeNo) values('user2','user2','������','user2@gmail.com','���� ���ؽ� ������� 38, ������������Ʈ 312�� 101ȣ',1);

-- QnA ���� ������ 
INSERT INTO qna (qna_no, id, title, content, writeDate, category)
VALUES (1, 'test1', '����� ��� �ϳ���?', '��� ���� �����Դϴ�. ���� ���� �� �ֳ���?', sysdate, '���');

INSERT INTO qna (qna_no, id, title, content, writeDate, category)
VALUES (2, 'test1', 'ȯ�� ��å�� �����ΰ���?', 'ȯ�� ������ �ҿ� �ð��� ���� �˰� �ͽ��ϴ�.', sysdate, 'ȯ��');

-- Answer ���� ������
INSERT INTO answer (answer_no, id, answer_title, answer_content, answerDate, refNo, ordNo, levNo, parentNo)
VALUES (1, 'admin', '��� �ȳ�', '����� 3�� �̳��� �����մϴ�.', sysdate, NULL, 1, 0, 1);

INSERT INTO answer (answer_no, id, answer_title, answer_content, answerDate, refNo, ordNo, levNo, parentNo)
VALUES (2, 'admin', 'ȯ�� �ȳ�', 'ȯ���� ��û �� 5�� �̳��� ó���˴ϴ�.', sysdate, NULL, 1, 0, 2);

-- ���� ������ �Է� (PRODUCT)
INSERT INTO products (goods_no, goods_name, pro_code1, pro_code2, image_name, company, price) 
VALUES (1, '���� ��ǰ 1', 101, 201, 'image1.jpg','�������', 100000);

INSERT INTO products (goods_no, goods_name, pro_code1, pro_code2, image_name, company, price) 
VALUES (2, '���� ��ǰ 2', 101, 202, 'image2.jpg', '�������', 200000);

INSERT INTO products (goods_no, goods_name, pro_code1, pro_code2, image_name, company, price) 
VALUES (3, '���� ��ǰ 3', 101, 203, 'image3.jpg', '�������', 300000);

-- ���� ������ �Է� (GOODS_PRICE)
INSERT INTO goods_price (goods_price_no, price, discount, sale_price, delivery_charge, goods_no) 
VALUES (1, 100000, 10000, 90000, 3000, 1);

INSERT INTO goods_price (goods_price_no, price, discount, sale_price, delivery_charge, goods_no) 
VALUES (2, 150000, 15000, 135000, 3000, 2);

INSERT INTO goods_price (goods_price_no, price, discount, sale_price, delivery_charge, goods_no) 
VALUES (3, 200000, 20000, 180000, 3000, 3);

-- ���� ������ �Է� (GOODS_IMAGE)
INSERT INTO goods_images (goods_image_no, image_name, goods_no) 
VALUES (1, 'image1.jpg', 1);

INSERT INTO goods_images (goods_image_no, image_name, goods_no) 
VALUES (2, 'image2.jpg', 2);

INSERT INTO goods_images (goods_image_no, image_name, goods_no) 
VALUES (3, 'image3.jpg', 3);

-- ���� ������ ���� (CATEGORY)
INSERT INTO category (cate_code1, cate_code2, cate_name) 
VALUES (1, 1, '��ǻ�� �ֿ� ��ǰ');

INSERT INTO category (cate_code1, cate_code2, cate_name) 
VALUES (1, 2, '�ֺ����');


-- ���� ������ ���� (COMPONENT)
INSERT INTO component (cate_code1, cate_code2, cate_name) 
VALUES (1, 1, 'CPU');

INSERT INTO component (cate_code1, cate_code2, cate_name) 
VALUES (1, 2, '�׷��� ī��');

-- ���� ������ ���� (cart :test1)
INSERT INTO cart (id, goods_no, goods_name, image_name, price, quantity, goods_total_price, selected_goods_price, delivery_charge, cart_no, discount, total_discount, final_price, selected)
VALUES ('test1', 1001, '����Ʈ��', 'smartphone.jpg', 500000, 2, 1000000, 1000000, 0, 1, 50000, 50000, 950000, 0);

INSERT INTO cart (id, goods_no, goods_name, image_name, price, quantity, goods_total_price, selected_goods_price, delivery_charge, cart_no, discount, total_discount, final_price, selected)
VALUES ('test1', 1002, '��Ʈ��', 'laptop.jpg', 1200000, 1, 1200000, 1200000, 3000, 2, 100000, 100000, 1100000, 0);

INSERT INTO cart (id, goods_no, goods_name, image_name, price, quantity, goods_total_price, selected_goods_price, delivery_charge, cart_no, discount, total_discount, final_price, selected)
VALUES ('test1', 1003, '�����', 'headphones.jpg', 30000, 3, 90000, 90000, 2000, 3, 0, 0, 92000, 0);

-- ���� ������ ���� (goods)
INSERT INTO goods(goods_no, goods_name, company, price, discount, pro_code1, pro_code2, image_name) 
VALUES (1, 'computer', 'Hosun', 300000, 90000, '1', '3', 'computer');

commit;