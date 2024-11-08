DROP TABLE goods_price CASCADE CONSTRAINTS PURGE;



-- 3. ��ǰ ���� ���̺� ����
CREATE TABLE goods_price (
    goods_price_no NUMBER PRIMARY KEY,
    price NUMBER(9),
    discount NUMBER(9),
    sale_price NUMBER(9) NOT NULL,
    delivery_charge NUMBER(6),
    goods_no NUMBER,
    FOREIGN KEY (goods_no) REFERENCES products(goods_no)  -- products ���̺���� �ܷ� Ű ���� ����
);

-- ���� ������ �Է� (����)
INSERT INTO goods_price (goods_price_no, price, discount, sale_price, delivery_charge, goods_no) 
VALUES (1, 100000, 10000, 90000, 3000, 1);