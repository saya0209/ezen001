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
    -- 질문 작성일자
    writeDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    -- 질문 유형 (배송, 환불 등)
    category VARCHAR2(50) NOT NULL
);

-- 3. 답변 테이블 (Answer) 생성
CREATE TABLE answer (
    -- 답변 고유 번호
    answer_no NUMBER PRIMARY KEY,
    -- QnA 게시글 고유 번호 (FK)
    qna_no NUMBER NOT NULL,
    -- 답변 작성자 ID (관리자)
    answer_id VARCHAR2(50) NOT NULL,
    -- 답변 내용 (최대 2000자)
    answer_content VARCHAR2(2000) NOT NULL,
    -- 답변 작성일
    answerDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    -- FK 제약조건
    FOREIGN KEY (qna_no) REFERENCES qna(qna_no) ON DELETE CASCADE
);

-- 4. 질문 번호 시퀀스 생성
CREATE SEQUENCE qna_seq START WITH 1 INCREMENT BY 1;

-- 5. 답변 번호 시퀀스 생성
CREATE SEQUENCE answer_seq START WITH 1 INCREMENT BY 1;

-- 6. 샘플 질문 데이터 추가
INSERT INTO qna (qna_no, writer_id, title, content, writeDate, category)
VALUES (qna_seq.NEXTVAL, 'test1', '배송은 어떻게 하나요?', '배송 관련 질문입니다.', CURRENT_TIMESTAMP, '배송');

INSERT INTO qna (qna_no, writer_id, title, content, writeDate, category)
VALUES (qna_seq.NEXTVAL, 'test1', '환불 절차가 궁금해요.', '환불 관련 질문입니다.', CURRENT_TIMESTAMP, '환불');

-- 7. 샘플 답변 데이터 추가
INSERT INTO answer (answer_no, qna_no, answer_id, answer_content, answerDate)
VALUES (answer_seq.NEXTVAL, 1, 'admin', '배송은 3일 이내에 가능합니다.', CURRENT_TIMESTAMP);

INSERT INTO answer (answer_no, qna_no, answer_id, answer_content, answerDate)
VALUES (answer_seq.NEXTVAL, 2, 'admin', '환불은 5일 이내에 처리됩니다.', CURRENT_TIMESTAMP);

-- 8. 전체 데이터 확인
SELECT * FROM qna;
SELECT * FROM answer;
