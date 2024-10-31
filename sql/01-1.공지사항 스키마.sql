-- 공지사항 스키마
--공지번호, 작성자, 제목, 내용, 작성일, 시작일, 종료일, 최근 수정일, 이미지

-- 1. 객체제거
drop table notice CASCADE CONSTRAINTS PURGE;
drop SEQUENCE notice_seq;


-- 2. 객체 생성drop SEQUENCE notice_seq;
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

--사퀀스 생성
CREATE SEQUENCE notice_seq;

-- 샘플 데이터 삽입
-- 현재 공지
INSERT INTO notice (notice_no, writer_id, title, content, startDate, endDate, image) 
VALUES (notice_seq.NEXTVAL, 'admin', '신제품 그래픽 카드 입고 안내', '최신 그래픽 카드가 입고되었습니다! 빠른 구매를 권장합니다.', 
TO_DATE('2024-10-01', 'YYYY-MM-DD'), TO_DATE('2024-12-31', 'YYYY-MM-DD'), 'new_gpu.jpg');

-- 지난 공지
INSERT INTO notice (notice_no, writer_id, title, content, startDate, endDate, image) 
VALUES (notice_seq.NEXTVAL, 'admin', '여름 맞이 쿨러 할인 행사', 'CPU 및 케이스 쿨러 할인 이벤트가 종료되었습니다.', 
TO_DATE('2024-06-01', 'YYYY-MM-DD'), TO_DATE('2024-08-31', 'YYYY-MM-DD'), 'summer_cooler_sale.jpg');

-- 예정 공지
INSERT INTO notice (notice_no, writer_id, title, content, startDate, endDate, image) 
VALUES (notice_seq.NEXTVAL, 'admin', '블랙 프라이데이 특가 행사', 'RAM과 SSD 특가 행사가 예정되어 있습니다. 놓치지 마세요!', 
TO_DATE('2024-11-20', 'YYYY-MM-DD'), TO_DATE('2024-11-30', 'YYYY-MM-DD'), 'black_friday_sale.jpg');


select *from notice;