DROP TABLE goods CASCADE CONSTRAINTS PURGE;

CREATE TABLE goods (
    goods_no NUMBER PRIMARY KEY,    -- ��ǰ ���� ��ȣ
    goods_name VARCHAR2(255),       -- ��ǰ��
    company VARCHAR2(255),          -- ������
    price NUMBER,                   -- ����
    discount NUMBER,                -- ���αݾ�
    pro_code1 NUMBER,          
    pro_code2 NUMBER,       
    image_name VARCHAR2(255)        -- �̹��� ���ϸ�
);

INSERT INTO goods(goods_no, goods_name, company, price, discount, pro_code1, pro_code2, image_name) 
VALUES (1, 'computer', 'Hosun', 300000, 90000, '1', '3', 'computer');

commit;
