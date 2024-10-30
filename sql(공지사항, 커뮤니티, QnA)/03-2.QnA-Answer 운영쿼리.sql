-- 질문/답변 운영 쿼리

-- 1. 모든 질문 조회
SELECT q.qna_no, q.title, q.writer_id, q.writeDate, q.category 
FROM qna q
ORDER BY q.writeDate DESC;  -- 작성일 기준 내림차순 정렬

-- 2. 특정 질문 조회 (질문 ID로 조회)
SELECT q.qna_no, q.title, q.content, q.writeDate, q.category
FROM qna q
WHERE q.qna_no = 1;  -- 특정 질문 번호 입력

-- 3. 특정 질문의 답변 조회
SELECT a.answer_no, a.answer_content, a.answer_id, a.answerDate
FROM answer a
WHERE a.qna_no = 1  -- 특정 질문 번호 입력
ORDER BY a.answerDate ASC;  -- 답변 작성일 기준 오름차순 정렬

-- 4. 질문 수정
UPDATE qna
SET title = '배송은 어떻게 이루어지나요?', content = '배송 절차와 소요 시간에 대해 알고 싶습니다.', category = '배송'
WHERE qna_no = 1;  -- 특정 질문 번호 입력

-- 5. 답변 수정
UPDATE answer
SET answer_content = '배송은 2-3일 이내에 가능합니다. 구체적인 날짜는 추후 안내드립니다.'
WHERE answer_no = 1;  -- 특정 답변 번호 입력

-- 6. 질문 삭제
DELETE FROM qna
WHERE qna_no = 2;  -- 특정 질문 번호 입력

-- 7. 답변 삭제
DELETE FROM answer
WHERE answer_no = 2;  -- 특정 답변 번호 입력

-- 8. 질문 및 답변 통계 조회
SELECT q.category, COUNT(q.qna_no) AS question_count, COUNT(a.answer_no) AS answer_count
FROM qna q
LEFT JOIN answer a ON q.qna_no = a.qna_no
GROUP BY q.category;  -- 질문 유형별 통계


