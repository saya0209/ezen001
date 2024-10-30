-- Ŀ�´�Ƽ ���̺� ����(��Ű��) - DDL ��ɾ�
-- Ŀ�´�Ƽ ��ȣ, �ۼ���, ����, ����, �ۼ���, ������, ������, �ֱ� ������, �̹���

-- ��ü ����
DROP TABLE community CASCADE CONSTRAINTS PURGE;
DROP SEQUENCE community_seq;

-- ��ü ����
CREATE TABLE community (
    -- Ŀ�´�Ƽ ��ȣ
    community_no NUMBER PRIMARY KEY,
    -- �ۼ��� ID
    writer_id VARCHAR2(50) NOT NULL,
    -- ����
    title VARCHAR2(300) NOT NULL,
    -- ����
    content VARCHAR2(2000) NOT NULL,
    -- �ۼ���
    writeDate DATE DEFAULT Sysdate,
    -- ������ (������)
    start_date DATE,
    -- ������ (������)
    endDate DATE,
    -- ��ȸ��
    hit NUMBER DEFAULT 0, -- ����� �κ�
    -- �ֱ� ������
    updateDate DATE,
    -- �̹���
    image VARCHAR2(2000)
);

-- community�� community_no�� ����� ������ ����
-- community�� community_no�� �ڵ�, ���������� �־��ݴϴ�.
CREATE SEQUENCE community_seq;

-- ���� ������ ����
-- ù ��° Ŀ�´�Ƽ �Խù�
INSERT INTO community (community_no, writer_id, title, content, writeDate, start_date, endDate, hit, image) 
VALUES (community_seq.NEXTVAL, 'admin', '�ֽ� �׷��� ī�� ��õ', 
        '2024�� �ְ��� �׷��� ī�� ����Ʈ�� �����մϴ�. ���ɰ� ���ݴ�� �ְ��� ������ �����ϱ��?', 
        SYSDATE, NULL, NULL, 0, 'graphic_card.jpg');

-- �� ��° Ŀ�´�Ƽ �Խù�
INSERT INTO community (community_no, writer_id, title, content, writeDate, start_date, endDate, hit, image) 
VALUES (community_seq.NEXTVAL, 'admin', '���� PC �ı�', 
        '�ֱٿ� ������ PC�� ���� �ı⸦ �����մϴ�. ��� �ı�� ���� �˰� ������ �е��� ��� �ּ���!', 
        SYSDATE, NULL, NULL, 0, 'pc_build_review.jpg');

-- ��ü ������ Ȯ��
SELECT * FROM community;
