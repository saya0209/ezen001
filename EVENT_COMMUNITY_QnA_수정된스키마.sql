-- /////// EVENT SQL ////////////////////////////////////////////
-- 이벤트 스키마
-- 이벤트 번호, 아이디, 제목, 내용, 작성일, 날짜(시작/종료/최근 수정일), 첨부된 파일, 이벤트상태, 이벤트 카테고리
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
    hit NUMBER DEFAULT 0,  -- 변경된 부분
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
    id VARCHAR2(20) REFERENCES member(id) NOT NULL, -- 로그인 회원만 사용 가능
    content VARCHAR2(600) NOT NULL,
    writeDate DATE DEFAULT sysdate,
    updateDate DATE DEFAULT sysdate,
    likeCnt NUMBER DEFAULT 0,
    dislikeCnt NUMBER DEFAULT 0,
    image VARCHAR2(2000) NULL  
);

CREATE SEQUENCE community_reply_seq;


-- 첫 번째 커뮤니티 게시물
INSERT INTO community (community_no, id, title, content, writeDate, hit, likeCnt, dislikeCnt, image) 
VALUES (community_seq.NEXTVAL, 'admin', '최신 그래픽 카드 추천', 
        '2024년 최고의 그래픽 카드 리스트를 공유합니다. 성능과 가격대비 최고의 선택은 무엇일까요?', 
        SYSDATE, 0, 0, 0, 'graphic_card.jpg');
        
-- 두 번째 커뮤니티 게시물
INSERT INTO community (community_no, id, title, content, writeDate, hit, likeCnt, dislikeCnt, image) 
VALUES (community_seq.NEXTVAL, 'admin', '조립 PC 후기', 
        '최근에 조립한 PC에 대한 후기를 공유합니다. 사용 후기와 팁을 알고 싶으신 분들은 댓글 주세요!', 
        SYSDATE, 0, 0, 0, 'pc_build_review.jpg');
        
-- 3 커뮤니티 게시물
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
         
-- /////// QnA, answer SQL ////////////////////////////////////////////
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

-- 질문 번호 시퀀스 생성
CREATE SEQUENCE qna_seq START WITH 1 INCREMENT BY 1;
-- 답변 번호 시퀀스 생성
CREATE SEQUENCE answer_seq START WITH 1 INCREMENT BY 1;

-- QnA 샘플 데이터 
INSERT INTO qna (qna_no, id, title, content, writeDate, category, status)
VALUES (1, 'test1', '배송은 어떻게 하나요?', '배송 관련 질문입니다. 언제 받을 수 있나요?', sysdate, '배송', 'waiting');
INSERT INTO qna (qna_no, id, title, content, writeDate, category, status)
VALUES (2, 'test1', '환불 정책은 무엇인가요?', '환불 절차와 소요 시간에 대해 알고 싶습니다.', sysdate, '환불', 'waiting');

-- Answer 샘플 데이터
INSERT INTO answer (answer_no, id, answer_title, answer_content, answerDate, refNo, ordNo, levNo, parentNo)
VALUES (1, 'admin', '배송 안내', '배송은 3일 이내에 가능합니다.', sysdate, NULL, 1, 0, 1);
INSERT INTO answer (answer_no, id, answer_title, answer_content, answerDate, refNo, ordNo, levNo, parentNo)
VALUES (2, 'admin', '환불 안내', '환불은 요청 후 5일 이내에 처리됩니다.', sysdate, NULL, 1, 0, 2);

-- 답변이 등록된 후 상태 업데이트
UPDATE qna SET status = 'completed' WHERE qna_no = 1;
UPDATE qna SET status = 'completed' WHERE qna_no = 2;



