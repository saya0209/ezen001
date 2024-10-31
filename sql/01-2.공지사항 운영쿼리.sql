-- 공지사항 운영 쿼리

-- 1. 리스트 : 공지번호, 제목, 게시일, 종료일
-- 1-1. 모든 리스트 보여주는 경우
-- 날짜 형식을 'yyyy-mm-dd'으로 보여줍니다.
SELECT notice_no AS no, title,
       TO_CHAR(writeDate, 'yyyy-mm-dd') AS writeDate,
       TO_CHAR(endDate, 'yyyy-mm-dd') AS endDate
FROM notice 
ORDER BY updateDate DESC, notice_no DESC;

-- 1-2. 현재 공지 리스트 쿼리
SELECT notice_no AS no, title,
       TO_CHAR(writeDate, 'yyyy-mm-dd') AS writeDate,
       TO_CHAR(endDate, 'yyyy-mm-dd') AS endDate
FROM notice 
WHERE startDate <= SYSDATE AND SYSDATE <= endDate 
ORDER BY updateDate DESC, notice_no DESC;

-- 1-3. 지난 공지 리스트 쿼리 (현재일이 종료일보다 뒤에 있습니다)
SELECT notice_no AS no, title,
       TO_CHAR(writeDate, 'yyyy-mm-dd') AS writeDate,
       TO_CHAR(endDate, 'yyyy-mm-dd') AS endDate
FROM notice 
WHERE SYSDATE > endDate 
ORDER BY updateDate DESC, notice_no DESC;

-- 1-4. 예정 공지 리스트 처리 (현재일이 시작일보다 앞에 있습니다)
SELECT notice_no AS no, title,
       TO_CHAR(writeDate, 'yyyy-mm-dd') AS writeDate,
       TO_CHAR(endDate, 'yyyy-mm-dd') AS endDate
FROM notice 
WHERE SYSDATE < startDate 
ORDER BY updateDate DESC, notice_no DESC;


SELECT * FROM notice;

