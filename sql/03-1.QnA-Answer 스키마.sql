-- 1. 객체 제거 (존재할 경우)
DROP TABLE answer CASCADE CONSTRAINTS PURGE;
DROP TABLE qna CASCADE CONSTRAINTS PURGE;
DROP SEQUENCE answer_seq;
DROP SEQUENCE qna_seq;

-- 2. 질문 테이블 (QnA) 생성
CREATE TABLE qna (
    -- QnA 게시글 고유 번호
    qna_no NUMBER PRIMARY KEY,
    -- 질문 작성자 ID (회원, 관리자)
    writer_id VARCHAR2(50) NOT NULL,
    -- 질문 제목
    title VARCHAR2(300) NOT NULL,
    -- 질문 내용
    content VARCHAR2(2000) NOT NULL,
    -- 질문 작성 일자
    writeDate DATE DEFAULT sysdate,
    -- 질문 유형 (배송, 환불 등)
    category VARCHAR2(50) NOT NULL
);

-- 3. 답변 테이블 (Answer) 생성
CREATE TABLE answer (
    -- 답변 고유 번호
    answer_no NUMBER PRIMARY KEY,
    -- 답변 작성자 ID (관리자)
    -- answer_id VARCHAR2(50) NOT NULL REFERENCES member(id),
    answer_id VARCHAR2(50) NOT NULL,
    -- 질문 제목
    answer_title VARCHAR2(300) NOT NULL,
    -- 답변 내용
    answer_content VARCHAR2(2000) NOT NULL,
    -- 답변 작성일
    answerDate DATE DEFAULT sysdate,
    -- 관련 글 번호 (해당 답변이 속한 원본 질문이나 답변 참조)
    refNo NUMBER REFERENCES answer(answer_no),
    -- 답변 순서 번호
    ordNo NUMBER,
    -- 들여쓰기 수준
    levNo NUMBER,
     -- on delete cascade : 질문이 삭재될때 질믄에 달린 답변들을 다 지워
    -- 부모 글 번호 (상위 질문 또는 답변 참조)
    parentNo NUMBER REFERENCES answer(answer_no) ON DELETE CASCADE
);

-- 4. 질문 번호 시퀀스 생성
CREATE SEQUENCE qna_seq START WITH 1 INCREMENT BY 1;

-- 5. 답변 번호 시퀀스 생성
CREATE SEQUENCE answer_seq START WITH 1 INCREMENT BY 1;

-- QnA 샘플 데이터 
INSERT INTO qna (qna_no, writer_id, title, content, writeDate, category)
VALUES (1, 'test1', '배송은 어떻게 하나요?', '배송 관련 질문입니다. 언제 받을 수 있나요?', sysdate, '배송');

INSERT INTO qna (qna_no, writer_id, title, content, writeDate, category)
VALUES (2, 'test1', '환불 정책은 무엇인가요?', '환불 절차와 소요 시간에 대해 알고 싶습니다.', sysdate, '환불');

-- Answer 샘플 데이터
INSERT INTO answer (answer_no, answer_id, answer_title, answer_content, answerDate, refNo, ordNo, levNo, parentNo)
VALUES (1, 'admin', '배송 안내', '배송은 3일 이내에 가능합니다.', sysdate, NULL, 1, 0, 1);

INSERT INTO answer (answer_no, answer_id, answer_title, answer_content, answerDate, refNo, ordNo, levNo, parentNo)
VALUES (2, 'admin', '환불 안내', '환불은 요청 후 5일 이내에 처리됩니다.', sysdate, NULL, 1, 0, 2);

-- 전체 데이터 확인
SELECT * FROM qna;
SELECT * FROM answer;
