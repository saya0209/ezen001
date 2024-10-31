-- 커뮤니티 테이블 구조(스키마) - DDL 명령어
-- 커뮤니티 번호, 작성자, 제목, 내용, 작성일, 시작일, 종료일, 최근 수정일, 이미지

-- 객체 제거
DROP TABLE community CASCADE CONSTRAINTS PURGE;
DROP SEQUENCE community_seq;

-- 객체 생성
CREATE TABLE community (
    -- 커뮤니티 번호
    community_no NUMBER PRIMARY KEY,
    -- 작성자 ID
    writer_id VARCHAR2(50) NOT NULL,
    -- 제목
    title VARCHAR2(300) NOT NULL,
    -- 내용
    content VARCHAR2(2000) NOT NULL,
    -- 작성일
    writeDate DATE DEFAULT Sysdate,
    -- 시작일 (선택적)
    start_date DATE,
    -- 종료일 (선택적)
    endDate DATE,
    -- 조회수
    hit NUMBER DEFAULT 0, -- 변경된 부분
    -- 최근 수정일
    updateDate DATE,
    -- 이미지
    image VARCHAR2(2000)
);

-- community의 community_no에 사용할 시퀀스 생성
-- community의 community_no을 자동, 순서적으로 넣어줍니다.
CREATE SEQUENCE community_seq;

-- 샘플 데이터 삽입
-- 첫 번째 커뮤니티 게시물
INSERT INTO community (community_no, writer_id, title, content, writeDate, start_date, endDate, hit, image) 
VALUES (community_seq.NEXTVAL, 'admin', '최신 그래픽 카드 추천', 
        '2024년 최고의 그래픽 카드 리스트를 공유합니다. 성능과 가격대비 최고의 선택은 무엇일까요?', 
        SYSDATE, NULL, NULL, 0, 'graphic_card.jpg');

-- 두 번째 커뮤니티 게시물
INSERT INTO community (community_no, writer_id, title, content, writeDate, start_date, endDate, hit, image) 
VALUES (community_seq.NEXTVAL, 'admin', '조립 PC 후기', 
        '최근에 조립한 PC에 대한 후기를 공유합니다. 사용 후기와 팁을 알고 싶으신 분들은 댓글 주세요!', 
        SYSDATE, NULL, NULL, 0, 'pc_build_review.jpg');

-- 전체 데이터 확인
SELECT * FROM community;
