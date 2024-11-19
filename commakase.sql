-- notice
DROP TABLE notice CASCADE CONSTRAINTS PURGE;
DROP SEQUENCE notice_seq;

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


-- grade
DROP TABLE grade CASCADE constraints purge;

create table grade (
    gradeNo number(1) primary key,
    gradeName varchar2(21) not null, unique (gradeName)
);

-- member sample data
insert into grade values (1, '�Ϲ�ȸ��');
insert into grade values (9, '������');

DROP TABLE member CASCADE constraints purge;

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

insert into member (id, pw, nicname, email, address, gradeNo) values('admin','admin','�����','mukgabi@naver.com','���� ������ ������ 10�� 4, �����������Ʈ 109�� 2202ȣ',9);
insert into member (id, pw, nicname, email, address, gradeNo) values('test1','test1','ȫ�浿','test1@naver.com','��� ����� ����12�� 3, �Ķ��� �빮 ��',1);
insert into member (id, pw, nicname, email, address, gradeNo) values('user1','user1','������','user1@gmail.com','���� ����� â���α� 2-1, 201ȣ',1);
insert into member (id, pw, nicname, email, address, gradeNo) values('user2','user2','������','user2@gmail.com','���� ���ؽ� ������� 38, ������������Ʈ 312�� 101ȣ',1);



-- ���� ���̺� ����
DROP TABLE cpu CASCADE CONSTRAINTS PURGE;
DROP TABLE memory CASCADE CONSTRAINTS PURGE;
DROP TABLE graphic_card CASCADE CONSTRAINTS PURGE;
DROP TABLE goods CASCADE CONSTRAINTS PURGE;

-- ������ ����
DROP SEQUENCE goods_SEQ;

-- CPU ���̺� ����
CREATE TABLE cpu (
    cpu_id NUMBER PRIMARY KEY,       -- CPU ������ȣ
    cpu_name VARCHAR2(100) UNIQUE,   -- CPU �̸� (��: 'Intel i3', 'Intel i5', 'Intel i7')
    cpu_price NUMBER(9)              -- CPU ����
);

-- Memory ���̺� ����
CREATE TABLE memory (
    memory_id NUMBER PRIMARY KEY,    -- �޸� ������ȣ
    memory_name VARCHAR2(100) UNIQUE, -- �޸� ũ�� (��: '4GB', '8GB', '12GB')
    memory_price NUMBER(9)           -- �޸� ����
);

-- �׷���ī�� ���̺� ����
CREATE TABLE graphic_card (
    graphic_card_id NUMBER PRIMARY KEY,       -- �׷���ī�� ������ȣ
    graphic_card_name VARCHAR2(100) UNIQUE,   -- �׷���ī�� �̸� (��: 'GTX1060', 'GTX2060', 'GTX3060')
    graphic_card_price NUMBER(9)              -- �׷���ī�� ����
);

-- Goods ���̺� ����
CREATE TABLE goods (
    goods_no NUMBER PRIMARY KEY,         -- ��ǰ ������ȣ        
    cpu_id NUMBER,                        -- CPU ��ȣ (foreign key)
    memory_id NUMBER,                     -- �޸� ��ȣ (foreign key)
    graphic_card_id NUMBER,               -- GPU ��ȣ (foreign key)
    cpu_name VARCHAR2(100),
    memory_name VARCHAR2(100),
    graphic_card_name VARCHAR2(100),
    total_price NUMBER(9),                -- �ش� ��ǰ�� ��ǰ�� ���� ���� (CPU + Memory + GPU ���� �ջ�)
    image_main VARCHAR2(255),
    image_files VARCHAR2(1000),
    FOREIGN KEY (cpu_id) REFERENCES cpu(cpu_id),                -- CPU �ܷ� Ű
    FOREIGN KEY (memory_id) REFERENCES memory(memory_id),       -- Memory �ܷ� Ű
    FOREIGN KEY (graphic_card_id) REFERENCES graphic_card(graphic_card_id) -- GPU �ܷ� Ű
);

-- ������ ����
CREATE SEQUENCE goods_SEQ;

-- ������ ����
INSERT INTO cpu (cpu_id, cpu_name, cpu_price) VALUES (1, 'Intel i3', 100000);
INSERT INTO cpu (cpu_id, cpu_name, cpu_price) VALUES (2, 'Intel i5', 150000);
INSERT INTO cpu (cpu_id, cpu_name, cpu_price) VALUES (3, 'Intel i7', 200000);

INSERT INTO memory (memory_id, memory_name, memory_price) VALUES (1, '4GB', 30000);
INSERT INTO memory (memory_id, memory_name, memory_price) VALUES (2, '8GB', 60000);
INSERT INTO memory (memory_id, memory_name, memory_price) VALUES (3, '16GB', 120000);

INSERT INTO graphic_card (graphic_card_id, graphic_card_name, graphic_card_price) VALUES (1, 'GTX1060', 200000);
INSERT INTO graphic_card (graphic_card_id, graphic_card_name, graphic_card_price) VALUES (2, 'GTX2060', 300000);
INSERT INTO graphic_card (graphic_card_id, graphic_card_name, graphic_card_price) VALUES (3, 'GTX3060', 400000);




-- community
DROP TABLE community CASCADE CONSTRAINTS PURGE;
DROP SEQUENCE community_seq;

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

-- ù ��° Ŀ�´�Ƽ �Խù�
INSERT INTO community (community_no, id, title, content, writeDate, hit, likeCnt, dislikeCnt, image) 
VALUES (community_seq.NEXTVAL, 'admin', '�ֽ� �׷��� ī�� ��õ', 
        '2024�� �ְ��� �׷��� ī�� ����Ʈ�� �����մϴ�. ���ɰ� ���ݴ�� �ְ��� ������ �����ϱ��?', 
        SYSDATE, 0, 0, 0, 'graphic_card.jpg');
        
-- �� ��° Ŀ�´�Ƽ �Խù�
INSERT INTO community (community_no, id, title, content, writeDate, hit, likeCnt, dislikeCnt, image) 
VALUES (community_seq.NEXTVAL, 'user1', '���� PC �ı�', 
        '�ֱٿ� ������ PC�� ���� �ı⸦ �����մϴ�. ��� �ı�� ���� �˰� ������ �е��� ��� �ּ���!', 
        SYSDATE, 0, 0, 0, 'pc_build_review.jpg');
        
-- 3 Ŀ�´�Ƽ �Խù�
INSERT INTO community (community_no, id, title, content, writeDate, hit, likeCnt, dislikeCnt, image) 
VALUES (community_seq.NEXTVAL, 'user2', '�ֽ� �׷���ī��', 
        '���� ��δ�', 
        SYSDATE, 0, 0, 0, NULL);

-- community_reply
DROP TABLE community_reply CASCADE CONSTRAINTS PURGE;
DROP SEQUENCE community_reply_seq;

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

-- qna
DROP TABLE qna CASCADE CONSTRAINTS PURGE;
DROP SEQUENCE qna_seq;

CREATE TABLE qna (
    qna_no NUMBER PRIMARY KEY,
    id VARCHAR2(50) not null, FOREIGN KEY (id) REFERENCES member(id),
    title VARCHAR2(300) NOT NULL,
    content VARCHAR2(2000) NOT NULL,
    writeDate DATE DEFAULT sysdate,
    category VARCHAR2(50) NOT NULL
);
CREATE SEQUENCE qna_seq START WITH 1 INCREMENT BY 1;

-- QnA ���� ������ 
INSERT INTO qna (qna_no, id, title, content, writeDate, category)
VALUES (1, 'test1', '����� ��� �ϳ���?', '��� ���� �����Դϴ�. ���� ���� �� �ֳ���?', sysdate, '���');

INSERT INTO qna (qna_no, id, title, content, writeDate, category)
VALUES (2, 'test1', 'ȯ�� ��å�� �����ΰ���?', 'ȯ�� ������ �ҿ� �ð��� ���� �˰� �ͽ��ϴ�.', sysdate, 'ȯ��');

-- answer
DROP TABLE answer CASCADE CONSTRAINTS PURGE;
DROP SEQUENCE answer_seq;

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
CREATE SEQUENCE answer_seq START WITH 1 INCREMENT BY 1;

-- Answer ���� ������
INSERT INTO answer (answer_no, id, answer_title, answer_content, answerDate, refNo, ordNo, levNo, parentNo)
VALUES (1, 'admin', '��� �ȳ�', '����� 3�� �̳��� �����մϴ�.', sysdate, NULL, 1, 0, 1);

INSERT INTO answer (answer_no, id, answer_title, answer_content, answerDate, refNo, ordNo, levNo, parentNo)
VALUES (2, 'admin', 'ȯ�� �ȳ�', 'ȯ���� ��û �� 5�� �̳��� ó���˴ϴ�.', sysdate, NULL, 1, 0, 2);


DROP TABLE goods_reply CASCADE CONSTRAINTS;
DROP SEQUENCE goods_reply_seq;

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
CREATE SEQUENCE goods_reply_seq;

-- cart
DROP TABLE cart CASCADE CONSTRAINTS;
DROP SEQUENCE cart_seq;

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
CREATE SEQUENCE cart_seq;

-- ���� ������ ���� (cart :test1)
INSERT INTO cart (id, goods_no, goods_name, image_name, price, quantity, goods_total_price, selected_goods_price, delivery_charge, cart_no, discount, total_discount, final_price, selected)
VALUES ('test1', 1001, '����Ʈ��', 'smartphone.jpg', 500000, 2, 1000000, 1000000, 0, 1, 50000, 50000, 950000, 0);

INSERT INTO cart (id, goods_no, goods_name, image_name, price, quantity, goods_total_price, selected_goods_price, delivery_charge, cart_no, discount, total_discount, final_price, selected)
VALUES ('test1', 1002, '��Ʈ��', 'laptop.jpg', 1200000, 1, 1200000, 1200000, 3000, 2, 100000, 100000, 1100000, 0);

INSERT INTO cart (id, goods_no, goods_name, image_name, price, quantity, goods_total_price, selected_goods_price, delivery_charge, cart_no, discount, total_discount, final_price, selected)
VALUES ('test1', 1003, '�����', 'headphones.jpg', 30000, 3, 90000, 90000, 2000, 3, 0, 0, 92000, 0);

-- payment
DROP TABLE payment CASCADE CONSTRAINTS;
DROP SEQUENCE payment_seq;

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
CREATE SEQUENCE payment_seq;

-- payment_history
DROP TABLE payment_history CASCADE CONSTRAINTS;
DROP SEQUENCE payment_history_seq;

CREATE TABLE payment_history (
    orderNumber VARCHAR2(300),
    id VARCHAR2(30),
    paymentDate DATE,
    totalAmount NUMBER,
    status VARCHAR2(30) NOT NULL -- 0: �����Ϸ�, 1: ���� ����
);
CREATE SEQUENCE payment_history_seq;

-- payment_Detail
DROP TABLE payment_detail CASCADE CONSTRAINTS;
DROP SEQUENCE payment_detail_seq;

CREATE TABLE payment_detail (
    id VARCHAR2(30),
    orderNumber VARCHAR2(300),
    goods_no NUMBER NOT NULL,
    goods_name VARCHAR2(300) NOT NULL,
    price NUMBER NOT NULL,
    quantity NUMBER NOT NULL,
    goods_total_price NUMBER NOT NULL
);
CREATE SEQUENCE payment_detail_seq;