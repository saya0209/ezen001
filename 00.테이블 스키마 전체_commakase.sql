-- ===== ESTIMSTE(견적) SQL =================================================
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

-- 견적 답변 샘플 데이터 삽입 (수정된 버전)
INSERT INTO estimate_request (request_no, id, title, content, category, budget, request_date, status)
VALUES (estimate_request_seq.NEXTVAL, 'user1', '게이밍 PC 견적 요청', '고성능 게이밍 PC를 원합니다. 최신 게임을 최고 설정으로 구동할 수 있는 사양 부탁드립니다.', '게이밍', 2500000, sysdate, 'waiting');
INSERT INTO estimate_request (request_no, id, title, content, category, budget, request_date, status)
VALUES (estimate_request_seq.NEXTVAL, 'user2', '사무용 PC 견적 요청', '업무용 문서 작업과 기본적인 멀티태스킹에 적합한 PC를 찾고 있습니다.', '사무용', 1000000, sysdate, 'waiting');

INSERT INTO estimate_answer (answer_no, id, title, content, total_price, answer_date, reNo, ordNo, levNo, parentNo)
VALUES (estimate_answer_seq.NEXTVAL, 'admin', '게이밍 PC 견적', 
'CPU : AMD Ryzen 7 5800X (599,000원)
메모리 : G.Skill Ripjaws V 32GB (DDR4/3600MHz) (159,000원)
그래픽카드 : NVIDIA GeForce RTX 3080 (1,200,000원)', 
2500000, sysdate, NULL, 1, 0, 1);

INSERT INTO estimate_answer (answer_no, id, title, content, total_price, answer_date, reNo, ordNo, levNo, parentNo)
VALUES (estimate_answer_seq.NEXTVAL, 'admin', '사무용 PC 견적', 
'CPU : Intel Core i5-11400 (259,000원)
메모리 : Samsung DDR4 16GB (89,000원)
그래픽카드 : Intel UHD Graphics 750 (내장그래픽)', 
1000000, sysdate, NULL, 1, 0, 2);


-- 상태 업데이트
UPDATE estimate_request SET status = 'completed' WHERE request_no = 1;
UPDATE estimate_request SET status = 'completed' WHERE request_no = 2;

-- ===== EVENT(이벤트) SQL =================================================
drop table event CASCADE CONSTRAINTS PURGE;
drop SEQUENCE event_seq;

-- 2. 객체 생성drop SEQUENCE notice_seq;
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

-- 샘플 데이터 삽입
-- 1. 예정된 이벤트 (UPCOMING)
INSERT INTO event (event_no, id, title, content, startDate, endDate, files, status, category) 
VALUES (event_seq.NEXTVAL, 'admin', '크리스마스 특별 세일', 
'모든 전자제품 30% 할인! 놓치지 마세요!', 
TO_DATE('2024-12-20', 'YYYY-MM-DD'), TO_DATE('2024-12-25', 'YYYY-MM-DD'), 
'christmas_sale.jpg', 'UPCOMING', 'PROMOTION');
-- 2. 진행 중인 이벤트 (ONGOING)
INSERT INTO event (event_no, id, title, content, startDate, endDate, files, status, category) 
VALUES (event_seq.NEXTVAL, 'admin', '블랙 프라이데이 세일', 
'SSD와 RAM 최대 50% 할인!', 
TO_DATE('2024-11-15', 'YYYY-MM-DD'), TO_DATE('2024-11-30', 'YYYY-MM-DD'), 
'black_friday_sale.jpg', 'ONGOING', 'PROMOTION');
-- 3. 종료된 이벤트 (COMPLETED)
INSERT INTO event (event_no, id, title, content, startDate, endDate, files, status, category) 
VALUES (event_seq.NEXTVAL, 'admin', '가을 맞이 할인 이벤트', 
'가을 한정 패션 아이템 세일이 종료되었습니다.', 
TO_DATE('2024-09-01', 'YYYY-MM-DD'), TO_DATE('2024-10-31', 'YYYY-MM-DD'), 
'fall_sale.jpg', 'COMPLETED', 'EVENT');

-- ===== COMMUNITY/COMMUNITY_REPLY(커뮤니티/댓글) SQL =================================================
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
    hit NUMBER DEFAULT 0,  -- 변경된 부분
    updateDate DATE DEFAULT sysDate,
    likeCnt NUMBER DEFAULT 0,
    dislikeCnt NUMBER DEFAULT 0,
    image VARCHAR2(2000)
);
CREATE TABLE community_reply (
    rno NUMBER PRIMARY KEY,  
    post_no NUMBER NOT NULL,
    parent_no NUMBER NULL,   
    id VARCHAR2(20) REFERENCES member(id) NOT NULL, -- 로그인 회원만 사용 가능
    content VARCHAR2(600) NOT NULL,
    writeDate DATE DEFAULT sysdate,
    updateDate DATE DEFAULT sysdate,
    likeCnt NUMBER DEFAULT 0,
    dislikeCnt NUMBER DEFAULT 0,
    image VARCHAR2(2000) NULL  
);
CREATE SEQUENCE community_seq;
CREATE SEQUENCE community_reply_seq;
-- 좋아요/싫어요
CREATE TABLE community_reaction (
    community_no NUMBER,
    id VARCHAR2(50),
    reaction_type VARCHAR2(10), -- 'like' 또는 'dislike'
    PRIMARY KEY (community_no, id),
    FOREIGN KEY (community_no) REFERENCES community(community_no),
    FOREIGN KEY (id) REFERENCES member(id)
);

-- 샘플
INSERT INTO community (community_no, id, title, content, writeDate, hit, likeCnt, dislikeCnt, image) 
VALUES (community_seq.NEXTVAL, 'admin', '최신 그래픽 카드 추천', 
        '2024년 최고의 그래픽 카드 리스트를 공유합니다. 성능과 가격대비 최고의 선택은 무엇일까요?', 
        SYSDATE, 0, 0, 0, 'graphic_card.jpg'); 
INSERT INTO community (community_no, id, title, content, writeDate, hit, likeCnt, dislikeCnt, image) 
VALUES (community_seq.NEXTVAL, 'admin', '조립 PC 후기', 
        '최근에 조립한 PC에 대한 후기를 공유합니다. 사용 후기와 팁을 알고 싶으신 분들은 댓글 주세요!', 
        SYSDATE, 0, 0, 0, 'pc_build_review.jpg');
INSERT INTO community (community_no, id, title, content, writeDate, hit, likeCnt, dislikeCnt, image) 
VALUES (community_seq.NEXTVAL, 'admin', '최신 그래픽카드', 
        '많이 비싸다', 
        SYSDATE, 0, 0, 0, NULL);

-- 댓글 데이터 삽입
INSERT INTO community_reply(rno, post_no, parent_no, id, content, writeDate, updateDate, likeCnt, dislikeCnt, image) 
VALUES (community_reply_seq.nextval, 1, NULL, 'user1', '이 그래픽 카드의 성능이 궁금합니다. 어떤 게임에서 테스트해봤나요?', sysdate, sysdate, 0, 0, NULL);
INSERT INTO community_reply(rno, post_no, parent_no, id, content, writeDate, updateDate, likeCnt, dislikeCnt, image) 
VALUES (community_reply_seq.nextval, 1, NULL, 'user2', '최고의 CPU 추천 부탁드립니다. 가성비 좋은 제품이 필요해요.', sysdate, sysdate, 0, 0, NULL);

-- 대댓글 데이터 삽입
INSERT INTO community_reply(rno, post_no, parent_no, id, content, writeDate, updateDate, likeCnt, dislikeCnt, image) 
VALUES (community_reply_seq.nextval, 1, 1, 'user2', '이 그래픽 카드의 성능은 정말 뛰어납니다! 다양한 게임에서 성능이 좋습니다.', sysdate, sysdate, 0, 0, NULL);
INSERT INTO community_reply(rno, post_no, parent_no, id, content, writeDate, updateDate, likeCnt, dislikeCnt, image) 
VALUES (community_reply_seq.nextval, 1, 2, 'user1', 'CPU는 인텔 i5가 괜찮은 것 같습니다. 가성비가 좋고 성능도 우수해요.', sysdate, sysdate, 0, 0, NULL);   

-- ===== QnA/answer(질문/댓글) SQL =================================================
DROP TABLE answer CASCADE CONSTRAINTS PURGE;
DROP TABLE qna CASCADE CONSTRAINTS PURGE;
DROP SEQUENCE answer_seq;
DROP SEQUENCE qna_seq;

-- 질문
CREATE TABLE qna (
    qna_no NUMBER PRIMARY KEY,
    id VARCHAR2(50) NOT NULL,
    title VARCHAR2(300) NOT NULL,
    content VARCHAR2(2000) NOT NULL,
    writeDate DATE DEFAULT sysdate,
    category VARCHAR2(50) NOT NULL,
    status VARCHAR2(20) DEFAULT 'waiting' NOT NULL
);
 -- 답변
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

-- QnA/Answer 샘플 데이터 
INSERT INTO qna (qna_no, id, title, content, writeDate, category, status)
VALUES (1, 'test1', '배송은 어떻게 하나요?', '배송 관련 질문입니다. 언제 받을 수 있나요?', sysdate, '배송', 'waiting');
INSERT INTO qna (qna_no, id, title, content, writeDate, category, status)
VALUES (2, 'test1', '환불 정책은 무엇인가요?', '환불 절차와 소요 시간에 대해 알고 싶습니다.', sysdate, '환불', 'waiting');

INSERT INTO answer (answer_no, id, answer_title, answer_content, answerDate, refNo, ordNo, levNo, parentNo)
VALUES (1, 'admin', '배송 안내', '배송은 3일 이내에 가능합니다.', sysdate, NULL, 1, 0, 1);
INSERT INTO answer (answer_no, id, answer_title, answer_content, answerDate, refNo, ordNo, levNo, parentNo)
VALUES (2, 'admin', '환불 안내', '환불은 요청 후 5일 이내에 처리됩니다.', sysdate, NULL, 1, 0, 2);
-- 답변이 등록된 후 상태 업데이트
UPDATE qna SET status = 'completed' WHERE qna_no = 1;
UPDATE qna SET status = 'completed' WHERE qna_no = 2;

-- ===== GRADE SQL =================================================
DROP TABLE grade CASCADE constraints purge;

create table grade (
    gradeNo number(1) primary key,
    gradeName varchar2(21) not null, unique (gradeName)
);

-- member sample data
insert into grade values (1, '일반회원');
insert into grade values (9, '관리자');

DROP TABLE member CASCADE constraints purge;

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

insert into member (id, pw, nicname, email, address, gradeNo) values('admin','admin','김관리','mukgabi@naver.com','서울 강남구 도산대로 10길 4, 새빛나라아파트 109동 2202호',9);
insert into member (id, pw, nicname, email, address, gradeNo) values('test1','test1','홍길동','test1@naver.com','경기 시흥시 광명12길 3, 파란색 대문 앞',1);
insert into member (id, pw, nicname, email, address, gradeNo) values('user1','user1','김유저','user1@gmail.com','서울 노원구 창석로길 2-1, 201호',1);
insert into member (id, pw, nicname, email, address, gradeNo) values('user2','user2','박유저','user2@gmail.com','강원 동해시 낙수대로 38, 낙수힐스테이트 312동 101호',1);

-- ===== GOODS SQL =================================================
-- 기존 테이블 삭제
DROP TABLE cpu CASCADE CONSTRAINTS PURGE;
DROP TABLE memory CASCADE CONSTRAINTS PURGE;
DROP TABLE graphic_card CASCADE CONSTRAINTS PURGE;
DROP TABLE goods CASCADE CONSTRAINTS PURGE;

-- 시퀀스 삭제
DROP SEQUENCE goods_SEQ;

-- CPU 테이블 생성
CREATE TABLE cpu (
    cpu_id NUMBER PRIMARY KEY,       -- CPU 고유번호
    cpu_name VARCHAR2(100) UNIQUE,   -- CPU 이름 (예: 'Intel i3', 'Intel i5', 'Intel i7')
    cpu_price NUMBER(9)              -- CPU 가격
);

-- Memory 테이블 생성
CREATE TABLE memory (
    memory_id NUMBER PRIMARY KEY,    -- 메모리 고유번호
    memory_name VARCHAR2(100) UNIQUE, -- 메모리 크기 (예: '4GB', '8GB', '12GB')
    memory_price NUMBER(9)           -- 메모리 가격
);

-- 그래픽카드 테이블 생성
CREATE TABLE graphic_card (
    graphic_card_id NUMBER PRIMARY KEY,       -- 그래픽카드 고유번호
    graphic_card_name VARCHAR2(100) UNIQUE,   -- 그래픽카드 이름 (예: 'GTX1060', 'GTX2060', 'GTX3060')
    graphic_card_price NUMBER(9)              -- 그래픽카드 가격
);

-- Goods 테이블 생성
CREATE TABLE goods (
    goods_no NUMBER PRIMARY KEY,         -- 상품 고유번호        
    cpu_id NUMBER,                        -- CPU 번호 (foreign key)
    memory_id NUMBER,                     -- 메모리 번호 (foreign key)
    graphic_card_id NUMBER,               -- GPU 번호 (foreign key)
    cpu_name VARCHAR2(100),
    memory_name VARCHAR2(100),
    graphic_card_name VARCHAR2(100),
    total_price NUMBER(9),                -- 해당 상품의 부품에 맞춘 가격 (CPU + Memory + GPU 가격 합산)
    category VARCHAR2(50),
    delivery_charge NUMBER,
    discount NUMBER,
    hit NUMBER DEFAULT 0,
    image_name VARCHAR2(300),
    image_files VARCHAR2(1000),
    FOREIGN KEY (cpu_id) REFERENCES cpu(cpu_id),                -- CPU 외래 키
    FOREIGN KEY (memory_id) REFERENCES memory(memory_id),       -- Memory 외래 키
    FOREIGN KEY (graphic_card_id) REFERENCES graphic_card(graphic_card_id) -- GPU 외래 키
);

-- 시퀀스 생성
CREATE SEQUENCE goods_SEQ;

-- 데이터 삽입
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

-- 외래 키 추가
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
    status VARCHAR2(30) NOT NULL -- 0: 결제완료, 1: 결제 실패
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