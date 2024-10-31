-- ����/�亯 � ����

-- 1. ��� ���� ��ȸ
SELECT q.qna_no, q.title, q.writer_id, q.writeDate, q.category 
FROM qna q
ORDER BY q.writeDate DESC;  -- �ۼ��� ���� �������� ����

-- 2. Ư�� ���� ��ȸ (���� ID�� ��ȸ)
SELECT q.qna_no, q.title, q.content, q.writeDate, q.category
FROM qna q
WHERE q.qna_no = 1;  -- Ư�� ���� ��ȣ �Է�

-- 3. Ư�� ������ �亯 ��ȸ
SELECT a.answer_no, a.answer_content, a.answer_id, a.answerDate
FROM answer a
WHERE a.refNo = 1  -- Ư�� ���� ��ȣ �Է�
ORDER BY a.answerDate ASC;  -- �亯 �ۼ��� ���� �������� ����

-- 4. ���� �߰�
INSERT INTO qna (qna_no, writer_id, title, content, writeDate, category)
VALUES (3, 'test_user3', '��ȯ ��å�� ��� �ǳ���?', '��ǰ ��ȯ�� ���� ������ �˰� �ͽ��ϴ�.', sysdate, '��ȯ');

-- 5. �亯 �߰�
INSERT INTO answer (answer_no, answer_id, answer_title, answer_content, answerDate, refNo, ordNo, levNo, parentNo)
VALUES (3, 'admin', '��ȯ �ȳ�', '��ȯ�� ���� �� 7�� �̳��� �����մϴ�.', sysdate, 3, 1, 0, NULL);

-- 6. ���� ����
UPDATE qna
SET title = '����� ��� �̷��������?', content = '��� ������ �ҿ� �ð��� ���� �˰� �ͽ��ϴ�.', category = '���'
WHERE qna_no = 1;  -- Ư�� ���� ��ȣ �Է�

-- 7. �亯 ����
UPDATE answer
SET answer_content = '����� 2-3�� �̳��� �����մϴ�. ��ü���� ��¥�� ���� �ȳ��帳�ϴ�.'
WHERE answer_no = 1;  -- Ư�� �亯 ��ȣ �Է�

-- 8. ���� ����
DELETE FROM qna
WHERE qna_no = 2;  -- Ư�� ���� ��ȣ �Է�

-- 9. �亯 ����
DELETE FROM answer
WHERE answer_no = 2;  -- Ư�� �亯 ��ȣ �Է�

-- 10. ���� �� �亯 ��� ��ȸ
SELECT q.category, COUNT(q.qna_no) AS question_count, COUNT(a.answer_no) AS answer_count
FROM qna q
LEFT JOIN answer a ON q.qna_no = a.refNo
GROUP BY q.category;  -- ���� ������ ���
