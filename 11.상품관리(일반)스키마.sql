-- ��ǰ���� (�Ϲ����λ���) goods
-- ��ǰ��ȣ(PK), ��ǰ��, ����, �ۼ���, ������, �𵨹�ȣ, ������, �̹����̸�, ��ۺ�

-- 1. ���� (���� ���̺� �� ������ ����)
drop table goods CASCADE CONSTRAINTS PURGE;
DROP TABLE goods_price CASCADE CONSTRAINTS PURGE;
drop sequence goods_seq;
DROP SEQUENCE goods_price_SEQ;

-- 2. ���̺� ����
create table goods (
    goods_no number UNIQUE,
    goods_name varchar2(300) not null,
    cate_code1 number,
    cate_code2 number,
    content varchar2(2000) not null,
    writeDate date default sysDate,
    product_Date date,
    company varchar2(30) not null,
    image_Name varchar2(200) not null,
    primary key (goods_no, cate_code1, cate_code2)  -- ����Ű�� ����
);

CREATE TABLE goods_price (
    goods_price_no NUMBER PRIMARY KEY,
    price NUMBER(9),
    discount NUMBER(9),
    sale_price NUMBER(9) NOT NULL,
    delivery_charge NUMBER(6),
    goods_no NUMBER REFERENCES goods(goods_no)
);

-- 3. ������ ����
create SEQUENCE goods_seq;
CREATE SEQUENCE goods_price_SEQ;

-- 4. ���� ������ �Է�
INSERT INTO goods (goods_no, goods_name, cate_code1, cate_code2, image_name, content, company, product_date)
VALUES (goods_seq.nextval, '���� ��ǰ 1', 101, 202, 'image1.jpg', '��ǰ �����Դϴ�.', '�������', SYSDATE);