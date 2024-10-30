-- Ŀ�´�Ƽ �����  : DML ��ɾ�
-- �ǽ����� : 1>>3>>1>>2>>4>>1>>2>>5>>1
-- CRUD (Create, Read, Update, Delete)

-- 1. ����Ʈ : Ŀ�´�Ƽ ��ȣ, ����, �ۼ���, �ۼ���, ��ȸ��
-- �ֱ� �ۼ��� ���� ��ܿ� �ö������
SELECT community_no, title, writer_id, writeDate, hit 
FROM community 
ORDER BY writeDate DESC; -- �ۼ��� �������� �������� ����

-- 2. �ۺ��� : Ŀ�´�Ƽ ��ȣ, ����, ����, �ۼ���, �ۼ���, ��ȸ��
-- Ŭ���� �۹�ȣ�� ��ȸ���� 1 ������ŵ�ϴ�. (��ȸ�� ����)
UPDATE community 
SET hit = hit + 1 
WHERE community_no = 1; -- ���÷� �۹�ȣ 1�� ��ȸ�� ����
COMMIT; -- DB�� ����

-- �۹�ȣ 1�� ���� ������ �����ִ� ���
SELECT community_no, title, content, writer_id, writeDate, hit 
FROM community 
WHERE community_no = 1;

-- 3. �۾��� : ����, ����, �ۼ���, ��й�ȣ �Է� �޾Ƽ� DB�� ����
INSERT INTO community (community_no, writer_id, title, content, writeDate, hit, image) 
VALUES (community_seq.NEXTVAL, 'admin', '���ο� ���� PC ��õ', 
        '������ ���� ���� PC�� ��õ�մϴ�. �ʿ��� ��ǰ�� �����ϱ��?', 
        SYSDATE, 0, 'new_build.jpg');
COMMIT;

-- 4. �ۼ��� : ����, ����, �ۼ��ڸ� ������ �� �ֵ���
-- ���� �� Ŀ�´�Ƽ ��ȣ�� �н����尡 ��ġ�ؾ� �մϴ�. (��й�ȣ�� ���⼭ ����, �߰� �� ���)
UPDATE community 
SET title = '���� PC ��õ', content = '�ֽ� ������ ���� PC�� ���� �����Դϴ�.' 
WHERE community_no = 1; -- �۹�ȣ 1 ����
COMMIT;

-- 5. �ۻ��� : ���� : Ŀ�´�Ƽ ��ȣ, ��й�ȣ
DELETE FROM community 
WHERE community_no = 1 AND writer_id = 'user01'; -- ���÷� user01�� �۹�ȣ 1 ����
COMMIT;

-- ��ü ������ �� ī��Ʈ
SELECT COUNT(*) AS cnt FROM community;

-- ����� ���뿡�� Ư�� ���ڿ� �˻�
SELECT * FROM community 
WHERE title LIKE '%����%' OR content LIKE '%����%';
