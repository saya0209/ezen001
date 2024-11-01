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
    image VARCHAR2(2000)
);

CREATE SEQUENCE notice_seq;

-- ���� ����
INSERT INTO notice (notice_no, writer_id, title, content, startDate, endDate, image) 
VALUES (notice_seq.NEXTVAL, 'admin', '����ǰ �׷��� ī�� �԰� �ȳ�', '�ֽ� �׷��� ī�尡 �԰�Ǿ����ϴ�! ���� ���Ÿ� �����մϴ�.', 
TO_DATE('2024-10-01', 'YYYY-MM-DD'), TO_DATE('2024-12-31', 'YYYY-MM-DD'), 'new_gpu.jpg');

-- ���� ����
INSERT INTO notice (notice_no, writer_id, title, content, startDate, endDate, image) 
VALUES (notice_seq.NEXTVAL, 'admin', '���� ���� �� ���� ���', 'CPU �� ���̽� �� ���� �̺�Ʈ�� ����Ǿ����ϴ�.', 
TO_DATE('2024-06-01', 'YYYY-MM-DD'), TO_DATE('2024-08-31', 'YYYY-MM-DD'), 'summer_cooler_sale.jpg');

-- ���� ����
INSERT INTO notice (notice_no, writer_id, title, content, startDate, endDate, image) 
VALUES (notice_seq.NEXTVAL, 'admin', '�� �����̵��� Ư�� ���', 'RAM�� SSD Ư�� ��簡 �����Ǿ� �ֽ��ϴ�. ��ġ�� ������!', 
TO_DATE('2024-11-20', 'YYYY-MM-DD'), TO_DATE('2024-11-30', 'YYYY-MM-DD'), 'black_friday_sale.jpg');

-- �ڡڡ� COMMUNITY, COMMUNITY_REPLY (SEQ O) (DROP, CREATE, INSERT, ����) ----------------------------------------------------------
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
    hit NUMBER DEFAULT 0, -- ����� �κ�
    updateDate DATE,
    image VARCHAR2(2000)
);

CREATE SEQUENCE community_seq;

CREATE TABLE community_reply (
    reply_no NUMBER PRIMARY KEY,  
    post_no NUMBER NOT NULL,
    parent_no NUMBER NULL,   
    id VARCHAR2(20) REFERENCES member(id) NOT NULL, -- ȸ���� ��밡��
    content VARCHAR2(600) NOT NULL,
    writeDate DATE DEFAULT sysdate,
    updateDate DATE DEFAULT sysdate,
    likeCnt NUMBER DEFAULT 0,
    dislikeCnt NUMBER DEFAULT 0,
    image VARCHAR2(2000) NULL  
);

CREATE SEQUENCE community_reply_seq;

-- ù ��° Ŀ�´�Ƽ �Խù�
INSERT INTO community (community_no, id, title, content, writeDate, start_date, endDate, hit, image) 
VALUES (community_seq.NEXTVAL, 'admin', '�ֽ� �׷��� ī�� ��õ', 
        '2024�� �ְ��� �׷��� ī�� ����Ʈ�� �����մϴ�. ���ɰ� ���ݴ�� �ְ��� ������ �����ϱ��?', 
        SYSDATE, NULL, NULL, 0, 'graphic_card.jpg');
        
-- �� ��° Ŀ�´�Ƽ �Խù�
INSERT INTO community (community_no, id, title, content, writeDate, start_date, endDate, hit, image) 
VALUES (community_seq.NEXTVAL, 'admin', '���� PC �ı�', 
        '�ֱٿ� ������ PC�� ���� �ı⸦ �����մϴ�. ��� �ı�� ���� �˰� ������ �е��� ��� �ּ���!', 
        SYSDATE, NULL, NULL, 0, 'pc_build_review.jpg');

-- ��� ������ ����
INSERT INTO community_reply(reply_no, post_no, parent_no, id, content, writeDate, updateDate, likeCnt, dislikeCnt, image) 
VALUES (community_reply_seq.nextval, 1, NULL, 'user1', '�� �׷��� ī���� ������ �ñ��մϴ�. � ���ӿ��� �׽�Ʈ�غó���?', sysdate, sysdate, 0, 0, NULL);

INSERT INTO community_reply(reply_no, post_no, parent_no, id, content, writeDate, updateDate, likeCnt, dislikeCnt, image) 
VALUES (community_reply_seq.nextval, 1, NULL, 'user2', '�ְ��� CPU ��õ ��Ź�帳�ϴ�. ������ ���� ��ǰ�� �ʿ��ؿ�.', sysdate, sysdate, 0, 0, NULL);

-- ���� ������ ����
INSERT INTO community_reply(reply_no, post_no, parent_no, id, content, writeDate, updateDate, likeCnt, dislikeCnt, image) 
VALUES (community_reply_seq.nextval, 1, 1, 'user2', '�� �׷��� ī���� ������ ���� �پ�ϴ�! �پ��� ���ӿ��� ������ �����ϴ�.', sysdate, sysdate, 0, 0, NULL);

INSERT INTO community_reply(reply_no, post_no, parent_no, id, content, writeDate, updateDate, likeCnt, dislikeCnt, image) 
VALUES (community_reply_seq.nextval, 1, 2, 'user1', 'CPU�� ���� i5�� ������ �� �����ϴ�. ������ ���� ���ɵ� ����ؿ�.', sysdate, sysdate, 0, 0, NULL);
        
-- �ڡڡڡڡڡ� ANSWER, QNA (SEQ O) (DROP, CREATE, INSERT, ����) �ڡڡڡڡڡ� ----------------------------------------------------------        
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

-- �ڡڡڡڡڡ� PRODUCT, GOODS_IMAGE, GOODS_PRICE (SEQ O) (DROP, CREATE, INSERT, ����) �ڡڡڡڡڡ� ----------------------------------------------------------  

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
    FOREIGN KEY (goods_no) REFERENCES products(goods_no)  -- products ���̺���� �ܷ� Ű ���� ����
);

CREATE TABLE goods_images (
    goods_image_no NUMBER PRIMARY KEY,
    image_name VARCHAR2(300),
    goods_no NUMBER,
    FOREIGN KEY (goods_no) REFERENCES products(goods_no)  -- products ���̺���� �ܷ� Ű ���� ����
);

CREATE SEQUENCE products_SEQ;
CREATE SEQUENCE goods_images_SEQ;
CREATE SEQUENCE goods_price_SEQ;

-- ���� ������ �Է� (PRODUCT)
INSERT INTO products (goods_no, goods_name, cate_code1, cate_code2, cate_code3, cate_name, image_name, content, company, product_date) 
VALUES (1, '���� ��ǰ 1', 101, 202, 303, 'ī�װ� �̸�', 'image1.jpg', '��ǰ �����Դϴ�.', '�������', SYSDATE);

INSERT INTO products (goods_no, goods_name, cate_code1, cate_code2, cate_code3, cate_name, image_name, content, company, product_date) 
VALUES (2, '���� ��ǰ 2', 101, 202, 304, 'ī�װ� �̸�', 'image2.jpg', '��ǰ �����Դϴ�.', '�������', SYSDATE);

INSERT INTO products (goods_no, goods_name, cate_code1, cate_code2, cate_code3, cate_name, image_name, content, company, product_date) 
VALUES (3, '���� ��ǰ 3', 101, 203, 305, 'ī�װ� �̸�', 'image3.jpg', '��ǰ �����Դϴ�.', '�������', SYSDATE);

-- ���� ������ �Է� (GOODS_PRICE)
INSERT INTO goods_price (goods_price_no, price, discount, sale_price, delivery_charge, sale_start_date, sale_end_date, goods_no) 
VALUES (1, 100000, 10000, 90000, 3000, TO_DATE('2024-10-01', 'YYYY-MM-DD'), TO_DATE('2024-10-31', 'YYYY-MM-DD'), 1);

INSERT INTO goods_price (goods_price_no, price, discount, sale_price, delivery_charge, sale_start_date, sale_end_date, goods_no) 
VALUES (2, 150000, 15000, 135000, 3000, TO_DATE('2024-11-01', 'YYYY-MM-DD'), TO_DATE('2024-11-30', 'YYYY-MM-DD'), 2);

INSERT INTO goods_price (goods_price_no, price, discount, sale_price, delivery_charge, sale_start_date, sale_end_date, goods_no) 
VALUES (3, 200000, 20000, 180000, 3000, TO_DATE('2024-12-01', 'YYYY-MM-DD'), TO_DATE('2024-12-31', 'YYYY-MM-DD'), 3);

-- ���� ������ �Է� (GOODS_IMAGE)
INSERT INTO goods_images (goods_image_no, image_name, goods_no) 
VALUES (1, 'image1.jpg', 1);

INSERT INTO goods_images (goods_image_no, image_name, goods_no) 
VALUES (2, 'image2.jpg', 2);

INSERT INTO goods_images (goods_image_no, image_name, goods_no) 
VALUES (3, 'image3.jpg', 3);

-- �ڡڡڡڡڡ� CATEGORY, COMPONENT (SEQ X) (DROP, CREATE, INSERT, ����) �ڡڡڡڡڡ� ---------------------------------------------------------- 

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

-- ���� ������ ���� (CATEGORY)
INSERT INTO category (cate_code1, cate_code2, cate_code3, cate_name) 
VALUES (1, 1, 1, '��ǻ�� �ֿ� ��ǰ');

INSERT INTO category (cate_code1, cate_code2, cate_code3, cate_name) 
VALUES (1, 2, 1, '�ֺ����');


-- ���� ������ ���� (COMPONENT)
INSERT INTO component (cate_code1, cate_code2, cate_name) 
VALUES (1, 1, 'CPU');

INSERT INTO component (cate_code1, cate_code2, cate_name) 
VALUES (1, 2, '�׷��� ī��');

-- �ڡڡڡڡڡ� GOODS_REPLY, CART, PAYMENT (SEQ O) (DROP, CREATE, INSERT) �ڡڡڡڡڡ� ----------------------------------------------------------

drop table goods_reply CASCADE CONSTRAINTS;
drop table cart CASCADE CONSTRAINTS;
drop table payment CASCADE CONSTRAINTS;

DROP SEQUENCE goods_reply_seq;
DROP SEQUENCE cart_seq;
DROP SEQUENCE payment_seq;

-- 2. ��ü ����
    -- 2-1. ����
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

    -- 2-1. ��ٱ���
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
        
    -- 2-1. ����
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

-- ���õ����� �߰�
     -- ���� ������ 1
    INSERT INTO cart (id, goods_no, goods_name, image_name, price, quantity, goods_total_price, 
                   selected_goods_price, delivery_charge, cart_no, discount, total_discount, 
                   totalAmount, selected, item_no)
    VALUES (1, 1001, '����Ʈ��', 'smartphone.jpg', 500000, 1, 500000, 
        0, 3000, 1, 0, 0, 503000, 0, cart_seq.NEXTVAL);

    -- ���� ������ 2
    INSERT INTO cart (id, goods_no, goods_name, image_name, price, quantity, goods_total_price, 
                   selected_goods_price, delivery_charge, cart_no, discount, total_discount, 
                   totalAmount, selected, item_no)
    VALUES (1, 1002, '��Ʈ��', 'laptop.jpg', 1200000, 1, 1200000, 
        0, 5000, 1, 100000, 0, 1100000, 1, cart_seq.NEXTVAL);

    -- ���� ������ 3
    INSERT INTO cart (id, goods_no, goods_name, image_name, price, quantity, goods_total_price, 
                   selected_goods_price, delivery_charge, cart_no, discount, total_discount, 
                   totalAmount, selected, item_no)
    VALUES (1, 1003, '�����', 'headphones.jpg', 150000, 2, 300000, 
        0, 0, 1, 0, 0, 300000, 0, cart_seq.NEXTVAL);
        
         -- ���� ������ 1
    INSERT INTO cart (id, goods_no, goods_name, image_name, price, quantity, goods_total_price, 
                   selected_goods_price, delivery_charge, cart_no, discount, total_discount, 
                   totalAmount, selected, item_no)
    VALUES (2, 1001, '����Ʈ��', 'smartphone.jpg', 500000, 1, 500000, 
        0, 3000, 1, 0, 0, 503000, 0, cart_seq.NEXTVAL);

    -- ���� ������ 2
    INSERT INTO cart (id, goods_no, goods_name, image_name, price, quantity, goods_total_price, 
                   selected_goods_price, delivery_charge, cart_no, discount, total_discount, 
                   totalAmount, selected, item_no)
    VALUES (2, 1002, '��Ʈ��', 'laptop.jpg', 1200000, 1, 1200000, 
        0, 5000, 1, 100000, 0, 1100000, 1, cart_seq.NEXTVAL);

    -- ���� ������ 3
    INSERT INTO cart (id, goods_no, goods_name, image_name, price, quantity, goods_total_price, 
                   selected_goods_price, delivery_charge, cart_no, discount, total_discount, 
                   totalAmount, selected, item_no)
    VALUES (2, 1003, '�����', 'headphones.jpg', 150000, 2, 300000, 
        0, 0, 1, 0, 0, 300000, 0, cart_seq.NEXTVAL);
commit;

-- �ڡڡڡڡڡ� MEMBER, GRADE (SEQ O) (DROP, CREATE, INSERT, ����) �ڡڡڡڡڡ� ----------------------------------------------------------
drop table member cascade constraints purge;
drop table grade cascade constraints purge;

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

insert into grade values (1, '�Ϲ�ȸ��');
insert into grade values (9, '������');
commit;

insert into member (id, pw, nicname, email, address, gradeNo) values('admin','admin','�����','mukgabi@naver.com','���� ������ ������ 10�� 4, �����������Ʈ 109�� 2202ȣ',9);
insert into member (id, pw, nicname, email, address, gradeNo) values('test1','test1','ȫ�浿','test1@naver.com','��� ����� ����12�� 3, �Ķ��� �빮 ��',1);
insert into member (id, pw, nicname, email, address, gradeNo) values('user1','user1','������','user1@gmail.com','���� ����� â���α� 2-1, 201ȣ',1);
insert into member (id, pw, nicname, email, address, gradeNo) values('user2','user2','������','user2@gmail.com','���� ���ؽ� ������� 38, ������������Ʈ 312�� 101ȣ',1);
commit;

SELECT goods_no, COUNT(*) FROM cart GROUP BY goods_no HAVING COUNT(*) > 1;
