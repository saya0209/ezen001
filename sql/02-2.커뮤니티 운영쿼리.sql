-- 커뮤니티 운영쿼리  : DML 명령어
-- 실습순서 : 1>>3>>1>>2>>4>>1>>2>>5>>1
-- CRUD (Create, Read, Update, Delete)

-- 1. 리스트 : 커뮤니티 번호, 제목, 작성자, 작성일, 조회수
-- 최근 작성한 글이 상단에 올라오도록
SELECT community_no, title, writer_id, writeDate, hit 
FROM community 
ORDER BY writeDate DESC; -- 작성일 기준으로 내림차순 정렬

-- 2. 글보기 : 커뮤니티 번호, 제목, 내용, 작성자, 작성일, 조회수
-- 클릭한 글번호의 조회수를 1 증가시킵니다. (조회수 증가)
UPDATE community 
SET hit = hit + 1 
WHERE community_no = 1; -- 예시로 글번호 1의 조회수 증가
COMMIT; -- DB에 적용

-- 글번호 1에 대한 내용을 보여주는 명령
SELECT community_no, title, content, writer_id, writeDate, hit 
FROM community 
WHERE community_no = 1;

-- 3. 글쓰기 : 제목, 내용, 작성자, 비밀번호 입력 받아서 DB에 저장
INSERT INTO community (community_no, writer_id, title, content, writeDate, hit, image) 
VALUES (community_seq.NEXTVAL, 'admin', '새로운 조립 PC 추천', 
        '가성비 좋은 조립 PC를 추천합니다. 필요한 부품은 무엇일까요?', 
        SYSDATE, 0, 'new_build.jpg');
COMMIT;

-- 4. 글수정 : 제목, 내용, 작성자를 수정할 수 있도록
-- 수정 시 커뮤니티 번호와 패스워드가 일치해야 합니다. (비밀번호는 여기서 생략, 추가 시 고려)
UPDATE community 
SET title = '조립 PC 추천', content = '최신 가성비 조립 PC에 대한 정보입니다.' 
WHERE community_no = 1; -- 글번호 1 수정
COMMIT;

-- 5. 글삭제 : 조건 : 커뮤니티 번호, 비밀번호
DELETE FROM community 
WHERE community_no = 1 AND writer_id = 'user01'; -- 예시로 user01의 글번호 1 삭제
COMMIT;

-- 전체 데이터 수 카운트
SELECT COUNT(*) AS cnt FROM community;

-- 제목과 내용에서 특정 문자열 검색
SELECT * FROM community 
WHERE title LIKE '%조립%' OR content LIKE '%조립%';
