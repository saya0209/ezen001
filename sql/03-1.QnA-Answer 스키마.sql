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
    -- ���� �ۼ� ����
    writeDate DATE DEFAULT sysdate,
    -- ���� ���� (���, ȯ�� ��)
    category VARCHAR2(50) NOT NULL
);

-- 3. �亯 ���̺� (Answer) ����
CREATE TABLE answer (
    -- �亯 ���� ��ȣ
    answer_no NUMBER PRIMARY KEY,
    -- �亯 �ۼ��� ID (������)
    -- answer_id VARCHAR2(50) NOT NULL REFERENCES member(id),
    answer_id VARCHAR2(50) NOT NULL,
    -- ���� ����
    answer_title VARCHAR2(300) NOT NULL,
    -- �亯 ����
    answer_content VARCHAR2(2000) NOT NULL,
    -- �亯 �ۼ���
    answerDate DATE DEFAULT sysdate,
    -- ���� �� ��ȣ (�ش� �亯�� ���� ���� �����̳� �亯 ����)
    refNo NUMBER REFERENCES answer(answer_no),
    -- �亯 ���� ��ȣ
    ordNo NUMBER,
    -- �鿩���� ����
    levNo NUMBER,
     -- on delete cascade : ������ ����ɶ� ���ȿ� �޸� �亯���� �� ����
    -- �θ� �� ��ȣ (���� ���� �Ǵ� �亯 ����)
    parentNo NUMBER REFERENCES answer(answer_no) ON DELETE CASCADE
);

-- 4. ���� ��ȣ ������ ����
CREATE SEQUENCE qna_seq START WITH 1 INCREMENT BY 1;

-- 5. �亯 ��ȣ ������ ����
CREATE SEQUENCE answer_seq START WITH 1 INCREMENT BY 1;

-- QnA ���� ������ 
INSERT INTO qna (qna_no, writer_id, title, content, writeDate, category)
VALUES (1, 'test1', '����� ��� �ϳ���?', '��� ���� �����Դϴ�. ���� ���� �� �ֳ���?', sysdate, '���');

INSERT INTO qna (qna_no, writer_id, title, content, writeDate, category)
VALUES (2, 'test1', 'ȯ�� ��å�� �����ΰ���?', 'ȯ�� ������ �ҿ� �ð��� ���� �˰� �ͽ��ϴ�.', sysdate, 'ȯ��');

-- Answer ���� ������
INSERT INTO answer (answer_no, answer_id, answer_title, answer_content, answerDate, refNo, ordNo, levNo, parentNo)
VALUES (1, 'admin', '��� �ȳ�', '����� 3�� �̳��� �����մϴ�.', sysdate, NULL, 1, 0, 1);

INSERT INTO answer (answer_no, answer_id, answer_title, answer_content, answerDate, refNo, ordNo, levNo, parentNo)
VALUES (2, 'admin', 'ȯ�� �ȳ�', 'ȯ���� ��û �� 5�� �̳��� ó���˴ϴ�.', sysdate, NULL, 1, 0, 2);

-- ��ü ������ Ȯ��
SELECT * FROM qna;
SELECT * FROM answer;
