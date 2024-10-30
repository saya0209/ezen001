-- �������� ��Ű��
--������ȣ, �ۼ���, ����, ����, �ۼ���, ������, ������, �ֱ� ������, �̹���

-- 1. ��ü����
drop table notice CASCADE CONSTRAINTS PURGE;
drop SEQUENCE notice_seq;


-- 2. ��ü ����drop SEQUENCE notice_seq;
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

--������ ����
CREATE SEQUENCE notice_seq;

-- ���� ������ ����
-- ���� ����
INSERT INTO notice (notice_no, writer_id, title, content, startDate, endDate, image) 
VALUES (notice_seq.NEXTVAL, 'admin', '����ǰ �׷��� ī�� �԰� �ȳ�', '�ֽ� �׷��� ī�尡 �԰�Ǿ����ϴ�! ���� ���Ÿ� �����մϴ�.', 
TO_DATE('2024-10-01', 'YYYY-MM-DD'), TO_DATE('2024-12-31', 'YYYY-MM-DD'), 'new_gpu.jpg');

-- ���� ����
INSERT INTO notice (notice_no, writer_id, title, content, startDate, endDate, image) 
VALUES (notice_seq.NEXTVAL, 'admin', '���� ���� �� ���� ���', 'CPU �� ���̽� �� ���� �̺�Ʈ�� ����Ǿ����ϴ�.', 
TO_DATE('2024-06-01', 'YYYY-MM-DD'), TO_DATE('2024-08-31', 'YYYY-MM-DD'), 'summer_cooler_sale.jpg');

-- ���� ����
INSERT INTO notice (notice_no, writer_id, title, content, startDate, endDate, image) 
VALUES (notice_seq.NEXTVAL, 'admin', '�� �����̵��� Ư�� ���', 'RAM�� SSD Ư�� ��簡 �����Ǿ� �ֽ��ϴ�. ��ġ�� ������!', 
TO_DATE('2024-11-20', 'YYYY-MM-DD'), TO_DATE('2024-11-30', 'YYYY-MM-DD'), 'black_friday_sale.jpg');


select *from notice;