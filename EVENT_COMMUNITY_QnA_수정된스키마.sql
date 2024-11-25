-- /////// EVENT SQL ////////////////////////////////////////////
-- �̺�Ʈ ��Ű��
-- �̺�Ʈ ��ȣ, ���̵�, ����, ����, �ۼ���, ��¥(����/����/�ֱ� ������), ÷�ε� ����, �̺�Ʈ����, �̺�Ʈ ī�װ�
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

-- /////// COMMUNITY, COMMUNITY_REPLY SQL ////////////////////////////////////////////
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
         
-- /////// QnA, answer SQL ////////////////////////////////////////////
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

-- ���� ��ȣ ������ ����
CREATE SEQUENCE qna_seq START WITH 1 INCREMENT BY 1;
-- �亯 ��ȣ ������ ����
CREATE SEQUENCE answer_seq START WITH 1 INCREMENT BY 1;

-- QnA ���� ������ 
INSERT INTO qna (qna_no, id, title, content, writeDate, category, status)
VALUES (1, 'test1', '����� ��� �ϳ���?', '��� ���� �����Դϴ�. ���� ���� �� �ֳ���?', sysdate, '���', 'waiting');
INSERT INTO qna (qna_no, id, title, content, writeDate, category, status)
VALUES (2, 'test1', 'ȯ�� ��å�� �����ΰ���?', 'ȯ�� ������ �ҿ� �ð��� ���� �˰� �ͽ��ϴ�.', sysdate, 'ȯ��', 'waiting');

-- Answer ���� ������
INSERT INTO answer (answer_no, id, answer_title, answer_content, answerDate, refNo, ordNo, levNo, parentNo)
VALUES (1, 'admin', '��� �ȳ�', '����� 3�� �̳��� �����մϴ�.', sysdate, NULL, 1, 0, 1);
INSERT INTO answer (answer_no, id, answer_title, answer_content, answerDate, refNo, ordNo, levNo, parentNo)
VALUES (2, 'admin', 'ȯ�� �ȳ�', 'ȯ���� ��û �� 5�� �̳��� ó���˴ϴ�.', sysdate, NULL, 1, 0, 2);

-- �亯�� ��ϵ� �� ���� ������Ʈ
UPDATE qna SET status = 'completed' WHERE qna_no = 1;
UPDATE qna SET status = 'completed' WHERE qna_no = 2;



