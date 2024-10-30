-- 1. ��ü ���� (������ ���)
DROP TABLE answer CASCADE CONSTRAINTS PURGE;
DROP TABLE qna CASCADE CONSTRAINTS PURGE;
DROP SEQUENCE answer_seq;
DROP SEQUENCE qna_seq;

-- 2. ���� ���̺� (QnA) ����
CREATE TABLE qna (
    -- QnA �Խñ� ���� ��ȣ
    qna_no NUMBER PRIMARY KEY,
    -- ���� �ۼ��� ID (ȸ��, ������)
    writer_id VARCHAR2(50) NOT NULL,
    -- ���� ����
    title VARCHAR2(300) NOT NULL,
    -- ���� ����
    content VARCHAR2(2000) NOT NULL,
    -- ���� �ۼ�����
    writeDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    -- ���� ���� (���, ȯ�� ��)
    category VARCHAR2(50) NOT NULL
);

-- 3. �亯 ���̺� (Answer) ����
CREATE TABLE answer (
    -- �亯 ���� ��ȣ
    answer_no NUMBER PRIMARY KEY,
    -- QnA �Խñ� ���� ��ȣ (FK)
    qna_no NUMBER NOT NULL,
    -- �亯 �ۼ��� ID (������)
    answer_id VARCHAR2(50) NOT NULL,
    -- �亯 ���� (�ִ� 2000��)
    answer_content VARCHAR2(2000) NOT NULL,
    -- �亯 �ۼ���
    answerDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    -- FK ��������
    FOREIGN KEY (qna_no) REFERENCES qna(qna_no) ON DELETE CASCADE
);

-- 4. ���� ��ȣ ������ ����
CREATE SEQUENCE qna_seq START WITH 1 INCREMENT BY 1;

-- 5. �亯 ��ȣ ������ ����
CREATE SEQUENCE answer_seq START WITH 1 INCREMENT BY 1;

-- 6. ���� ���� ������ �߰�
INSERT INTO qna (qna_no, writer_id, title, content, writeDate, category)
VALUES (qna_seq.NEXTVAL, 'test1', '����� ��� �ϳ���?', '��� ���� �����Դϴ�.', CURRENT_TIMESTAMP, '���');

INSERT INTO qna (qna_no, writer_id, title, content, writeDate, category)
VALUES (qna_seq.NEXTVAL, 'test1', 'ȯ�� ������ �ñ��ؿ�.', 'ȯ�� ���� �����Դϴ�.', CURRENT_TIMESTAMP, 'ȯ��');

-- 7. ���� �亯 ������ �߰�
INSERT INTO answer (answer_no, qna_no, answer_id, answer_content, answerDate)
VALUES (answer_seq.NEXTVAL, 1, 'admin', '����� 3�� �̳��� �����մϴ�.', CURRENT_TIMESTAMP);

INSERT INTO answer (answer_no, qna_no, answer_id, answer_content, answerDate)
VALUES (answer_seq.NEXTVAL, 2, 'admin', 'ȯ���� 5�� �̳��� ó���˴ϴ�.', CURRENT_TIMESTAMP);

-- 8. ��ü ������ Ȯ��
SELECT * FROM qna;
SELECT * FROM answer;
