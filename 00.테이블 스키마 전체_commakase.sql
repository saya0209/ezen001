-- ===== ESTIMSTE(����) SQL =================================================
DROP TABLE estimate_answer CASCADE CONSTRAINTS PURGE;
DROP TABLE estimate_request CASCADE CONSTRAINTS PURGE;
DROP SEQUENCE estimate_answer_seq;
DROP SEQUENCE estimate_request_seq;

CREATE TABLE estimate_request (
    request_no NUMBER PRIMARY KEY,
    id VARCHAR2(50) NOT NULL,
    title VARCHAR2(300) NOT NULL,
    content VARCHAR2(2000) NOT NULL,
    category VARCHAR2(50) NOT NULL,
    budget NUMBER,
    request_date DATE DEFAULT sysdate,
    status VARCHAR2(20) DEFAULT 'waiting' NOT NULL
);
CREATE TABLE estimate_answer (
    answer_no NUMBER PRIMARY KEY,
    id VARCHAR2(50) NOT NULL,
    title VARCHAR2(300) NOT NULL,
    content VARCHAR2(2000) NOT NULL,
    total_price NUMBER,
    answer_date DATE DEFAULT sysdate,
    reNo NUMBER,
    ordNo NUMBER,
    levNo NUMBER,
    parentNo NUMBER REFERENCES estimate_request(request_no) ON DELETE CASCADE
);
CREATE SEQUENCE estimate_request_seq START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE estimate_answer_seq START WITH 1 INCREMENT BY 1;

-- ���� �亯 ���� ������ ���� (������ ����)
INSERT INTO estimate_request (request_no, id, title, content, category, budget, request_date, status)
VALUES (estimate_request_seq.NEXTVAL, 'user1', '���̹� PC ���� ��û', '���� ���̹� PC�� ���մϴ�. �ֽ� ������ �ְ� �������� ������ �� �ִ� ��� ��Ź�帳�ϴ�.', '���̹�', 2500000, sysdate, 'waiting');
INSERT INTO estimate_request (request_no, id, title, content, category, budget, request_date, status)
VALUES (estimate_request_seq.NEXTVAL, 'user2', '�繫�� PC ���� ��û', '������ ���� �۾��� �⺻���� ��Ƽ�½�ŷ�� ������ PC�� ã�� �ֽ��ϴ�.', '�繫��', 1000000, sysdate, 'waiting');

INSERT INTO estimate_answer (answer_no, id, title, content, total_price, answer_date, reNo, ordNo, levNo, parentNo)
VALUES (estimate_answer_seq.NEXTVAL, 'admin', '���̹� PC ����', 
'CPU : AMD Ryzen 7 5800X (599,000��)
�޸� : G.Skill Ripjaws V 32GB (DDR4/3600MHz) (159,000��)
�׷���ī�� : NVIDIA GeForce RTX 3080 (1,200,000��)', 
2500000, sysdate, NULL, 1, 0, 1);

INSERT INTO estimate_answer (answer_no, id, title, content, total_price, answer_date, reNo, ordNo, levNo, parentNo)
VALUES (estimate_answer_seq.NEXTVAL, 'admin', '�繫�� PC ����', 
'CPU : Intel Core i5-11400 (259,000��)
�޸� : Samsung DDR4 16GB (89,000��)
�׷���ī�� : Intel UHD Graphics 750 (����׷���)', 
1000000, sysdate, NULL, 1, 0, 2);


-- ���� ������Ʈ
UPDATE estimate_request SET status = 'completed' WHERE request_no = 1;
UPDATE estimate_request SET status = 'completed' WHERE request_no = 2;

-- ===== EVENT(�̺�Ʈ) SQL =================================================
drop table event CASCADE CONSTRAINTS PURGE;
drop SEQUENCE event_seq;

-- 2. ��ü ����drop SEQUENCE notice_seq;
CREATE TABLE event (
    event_no NUMBER PRIMARY KEY, 
    id VARCHAR2(50) NOT NULL,
    title VARCHAR2(300) NOT NULL,
    content VARCHAR2(2000) NOT NULL,
    writeDate DATE DEFAULT sysDate,
    startDate DATE DEFAULT sysDate,
    endDate DATE DEFAULT sysDate,
    updateDate DATE DEFAULT sysDate,
    files VARCHAR2(2000),
    status VARCHAR2(20) DEFAULT 'UPCOMING',
    category VARCHAR2(50) DEFAULT 'PROMOTION'
);
CREATE SEQUENCE event_seq;

-- ���� ������ ����
-- 1. ������ �̺�Ʈ (UPCOMING)
INSERT INTO event (event_no, id, title, content, startDate, endDate, files, status, category) 
VALUES (event_seq.NEXTVAL, 'admin', 'ũ�������� Ư�� ����', 
'��� ������ǰ 30% ����! ��ġ�� ������!', 
TO_DATE('2024-12-20', 'YYYY-MM-DD'), TO_DATE('2024-12-25', 'YYYY-MM-DD'), 
'christmas_sale.jpg', 'UPCOMING', 'PROMOTION');
-- 2. ���� ���� �̺�Ʈ (ONGOING)
INSERT INTO event (event_no, id, title, content, startDate, endDate, files, status, category) 
VALUES (event_seq.NEXTVAL, 'admin', '�� �����̵��� ����', 
'SSD�� RAM �ִ� 50% ����!', 
TO_DATE('2024-11-15', 'YYYY-MM-DD'), TO_DATE('2024-11-30', 'YYYY-MM-DD'), 
'black_friday_sale.jpg', 'ONGOING', 'PROMOTION');
-- 3. ����� �̺�Ʈ (COMPLETED)
INSERT INTO event (event_no, id, title, content, startDate, endDate, files, status, category) 
VALUES (event_seq.NEXTVAL, 'admin', '���� ���� ���� �̺�Ʈ', 
'���� ���� �м� ������ ������ ����Ǿ����ϴ�.', 
TO_DATE('2024-09-01', 'YYYY-MM-DD'), TO_DATE('2024-10-31', 'YYYY-MM-DD'), 
'fall_sale.jpg', 'COMPLETED', 'EVENT');

-- ===== COMMUNITY/COMMUNITY_REPLY(Ŀ�´�Ƽ/���) SQL =================================================
DROP TABLE community CASCADE CONSTRAINTS PURGE;
DROP SEQUENCE community_seq;
DROP TABLE community_reply CASCADE CONSTRAINTS PURGE;
DROP SEQUENCE community_reply_seq;
DROP TABLE community_reaction CASCADE CONSTRAINTS PURGE;

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
CREATE SEQUENCE community_seq;
CREATE SEQUENCE community_reply_seq;
-- ���ƿ�/�Ⱦ��
CREATE TABLE community_reaction (
    community_no NUMBER,
    id VARCHAR2(50),
    reaction_type VARCHAR2(10), -- 'like' �Ǵ� 'dislike'
    PRIMARY KEY (community_no, id),
    FOREIGN KEY (community_no) REFERENCES community(community_no),
    FOREIGN KEY (id) REFERENCES member(id)
);

-- ����
INSERT INTO community (community_no, id, title, content, writeDate, hit, likeCnt, dislikeCnt, image) 
VALUES (community_seq.NEXTVAL, 'admin', '�ֽ� �׷��� ī�� ��õ', 
        '2024�� �ְ��� �׷��� ī�� ����Ʈ�� �����մϴ�. ���ɰ� ���ݴ�� �ְ��� ������ �����ϱ��?', 
        SYSDATE, 0, 0, 0, 'graphic_card.jpg'); 
INSERT INTO community (community_no, id, title, content, writeDate, hit, likeCnt, dislikeCnt, image) 
VALUES (community_seq.NEXTVAL, 'admin', '���� PC �ı�', 
        '�ֱٿ� ������ PC�� ���� �ı⸦ �����մϴ�. ��� �ı�� ���� �˰� ������ �е��� ��� �ּ���!', 
        SYSDATE, 0, 0, 0, 'pc_build_review.jpg');
INSERT INTO community (community_no, id, title, content, writeDate, hit, likeCnt, dislikeCnt, image) 
VALUES (community_seq.NEXTVAL, 'admin', '�ֽ� �׷���ī��', 
        '���� ��δ�', 
        SYSDATE, 0, 0, 0, NULL);

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

-- ===== QnA/answer(����/���) SQL =================================================
DROP TABLE answer CASCADE CONSTRAINTS PURGE;
DROP TABLE qna CASCADE CONSTRAINTS PURGE;
DROP SEQUENCE answer_seq;
DROP SEQUENCE qna_seq;

-- ����
CREATE TABLE qna (
    qna_no NUMBER PRIMARY KEY,
    id VARCHAR2(50) NOT NULL,
    title VARCHAR2(300) NOT NULL,
    content VARCHAR2(2000) NOT NULL,
    writeDate DATE DEFAULT sysdate,
    category VARCHAR2(50) NOT NULL,
    status VARCHAR2(20) DEFAULT 'waiting' NOT NULL
);
 -- �亯
CREATE TABLE answer (
    answer_no NUMBER PRIMARY KEY,
    id VARCHAR2(50) NOT NULL,
    answer_title VARCHAR2(300) NOT NULL,
    answer_content VARCHAR2(2000) NOT NULL,
    answerDate DATE DEFAULT sysdate,
    refNo NUMBER REFERENCES answer(answer_no),
    ordNo NUMBER,
    levNo NUMBER,
    parentNo NUMBER REFERENCES qna(qna_no) ON DELETE CASCADE
);

CREATE SEQUENCE qna_seq START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE answer_seq START WITH 1 INCREMENT BY 1;

-- QnA/Answer ���� ������ 
INSERT INTO qna (qna_no, id, title, content, writeDate, category, status)
VALUES (1, 'test1', '����� ��� �ϳ���?', '��� ���� �����Դϴ�. ���� ���� �� �ֳ���?', sysdate, '���', 'waiting');
INSERT INTO qna (qna_no, id, title, content, writeDate, category, status)
VALUES (2, 'test1', 'ȯ�� ��å�� �����ΰ���?', 'ȯ�� ������ �ҿ� �ð��� ���� �˰� �ͽ��ϴ�.', sysdate, 'ȯ��', 'waiting');

INSERT INTO answer (answer_no, id, answer_title, answer_content, answerDate, refNo, ordNo, levNo, parentNo)
VALUES (1, 'admin', '��� �ȳ�', '����� 3�� �̳��� �����մϴ�.', sysdate, NULL, 1, 0, 1);
INSERT INTO answer (answer_no, id, answer_title, answer_content, answerDate, refNo, ordNo, levNo, parentNo)
VALUES (2, 'admin', 'ȯ�� �ȳ�', 'ȯ���� ��û �� 5�� �̳��� ó���˴ϴ�.', sysdate, NULL, 1, 0, 2);
-- �亯�� ��ϵ� �� ���� ������Ʈ
UPDATE qna SET status = 'completed' WHERE qna_no = 1;
UPDATE qna SET status = 'completed' WHERE qna_no = 2;

-- ===== GRADE SQL =================================================
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

-- ===== GOODS SQL =================================================
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
    category VARCHAR2(50),
    delivery_charge NUMBER,
    discount NUMBER,
    hit NUMBER DEFAULT 0,
    image_name VARCHAR2(300),
    image_files VARCHAR2(1000),
    FOREIGN KEY (cpu_id) REFERENCES cpu(cpu_id),                -- CPU �ܷ� Ű
    FOREIGN KEY (memory_id) REFERENCES memory(memory_id),       -- Memory �ܷ� Ű
    FOREIGN KEY (graphic_card_id) REFERENCES graphic_card(graphic_card_id) -- GPU �ܷ� Ű
);

-- ������ ����
CREATE SEQUENCE goods_SEQ;

-- ������ ����
INSERT INTO cpu (cpu_id, cpu_name, cpu_price) VALUES (1, 'Intel i3 12100F', 100000);
INSERT INTO cpu (cpu_id, cpu_name, cpu_price) VALUES (2, 'Intel i3 13100F', 110000);
INSERT INTO cpu (cpu_id, cpu_name, cpu_price) VALUES (3, 'Intel i3 14100F', 120000);
INSERT INTO cpu (cpu_id, cpu_name, cpu_price) VALUES (4, 'Intel i5 12400F', 150000);
INSERT INTO cpu (cpu_id, cpu_name, cpu_price) VALUES (5, 'Intel i5 13400F', 200000);
INSERT INTO cpu (cpu_id, cpu_name, cpu_price) VALUES (6, 'Intel i5 14400F', 250000);
INSERT INTO cpu (cpu_id, cpu_name, cpu_price) VALUES (7, 'Intel i7 12700K', 500000);
INSERT INTO cpu (cpu_id, cpu_name, cpu_price) VALUES (8, 'Intel i7 13700K', 600000);
INSERT INTO cpu (cpu_id, cpu_name, cpu_price) VALUES (9, 'Intel i7 14700K', 700000);

INSERT INTO memory (memory_id, memory_name, memory_price) VALUES (1, '4GB', 30000);
INSERT INTO memory (memory_id, memory_name, memory_price) VALUES (2, '8GB', 60000);
INSERT INTO memory (memory_id, memory_name, memory_price) VALUES (3, '16GB', 120000);
INSERT INTO memory (memory_id, memory_name, memory_price) VALUES (4, '32GB', 200000);

INSERT INTO graphic_card (graphic_card_id, graphic_card_name, graphic_card_price) VALUES (1, 'GTX760', 40000);
INSERT INTO graphic_card (graphic_card_id, graphic_card_name, graphic_card_price) VALUES (2, 'GTX860', 60000);
INSERT INTO graphic_card (graphic_card_id, graphic_card_name, graphic_card_price) VALUES (3, 'GTX960', 80000);
INSERT INTO graphic_card (graphic_card_id, graphic_card_name, graphic_card_price) VALUES (4, 'GTX1060', 100000);
INSERT INTO graphic_card (graphic_card_id, graphic_card_name, graphic_card_price) VALUES (5, 'GTX1080', 150000);
INSERT INTO graphic_card (graphic_card_id, graphic_card_name, graphic_card_price) VALUES (6, 'GTX2060', 300000);
INSERT INTO graphic_card (graphic_card_id, graphic_card_name, graphic_card_price) VALUES (7, 'GTX2080', 350000);
INSERT INTO graphic_card (graphic_card_id, graphic_card_name, graphic_card_price) VALUES (8, 'GTX3060', 400000);
INSERT INTO graphic_card (graphic_card_id, graphic_card_name, graphic_card_price) VALUES (9, 'GTX3080', 1000000);

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

-- ===== CART SQL =================================================
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
    cart_no NUMBER,
    discount NUMBER,
    total_discount NUMBER,
    final_price NUMBER,
    selected NUMBER(1) DEFAULT 0 NOT NULL -- 0: false, 1: true    
);

ALTER TABLE cart ADD cpu_id NUMBER;
ALTER TABLE cart ADD memory_id NUMBER;
ALTER TABLE cart ADD graphic_card_id NUMBER;

-- �ܷ� Ű �߰�
ALTER TABLE cart ADD CONSTRAINT fk_cpu FOREIGN KEY (cpu_id) REFERENCES cpu(cpu_id);
ALTER TABLE cart ADD CONSTRAINT fk_memory FOREIGN KEY (memory_id) REFERENCES memory(memory_id);
ALTER TABLE cart ADD CONSTRAINT fk_graphic_card FOREIGN KEY (graphic_card_id) REFERENCES graphic_card(graphic_card_id);

CREATE SEQUENCE cart_seq;

-- cart
DROP TABLE buy CASCADE CONSTRAINTS;
DROP SEQUENCE buy_seq;

CREATE TABLE buy (
    id varchar2(50) not null,
    goods_no NUMBER NOT NULL,
    goods_name VARCHAR2(300) NOT NULL,
    image_name VARCHAR2(300),
    price NUMBER NOT NULL,
    quantity NUMBER NOT NULL,
    goods_total_price NUMBER NOT NULL, 
    selected_goods_price NUMBER NOT NULL,
    delivery_charge NUMBER,
    cart_no NUMBER,
    discount NUMBER,
    total_discount NUMBER,
    final_price NUMBER  
);

CREATE SEQUENCE buy_seq;

-- ===== PAYMENT SQL =================================================
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