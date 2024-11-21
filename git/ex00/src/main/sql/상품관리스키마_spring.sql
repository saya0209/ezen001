-- ��ǰ���� ��Ű��
-- 1. ��ü ����
    -- ���̺� ����
    -- 1-6. ��ǰ����
    DROP TABLE goods_price CASCADE CONSTRAINTS;
    -- 1-5. ��ǰ�̹���
    DROP TABLE goods_image CASCADE CONSTRAINTS;
    -- 1-4. ��ǰ����
    DROP TABLE goods_color CASCADE CONSTRAINTS;
    -- 1-3. ��ǰ������
    DROP TABLE goods_size CASCADE CONSTRAINTS;
    -- 1-2. ��ǰ
    DROP TABLE goods CASCADE CONSTRAINTS;
    -- 1-1. ī�װ�
    DROP TABLE category CASCADE CONSTRAINTS;
    
    -- ������ ����
    DROP SEQUENCE goods_price_seq;
    DROP SEQUENCE goods_image_seq;
    DROP SEQUENCE goods_color_seq;
    DROP SEQUENCE goods_size_seq;
    DROP SEQUENCE goods_seq;

-- 2. ��ü ���� (���̺� �� ������)
    -- 2-1. ī�װ�
    CREATE TABLE category (
        cate_code1 NUMBER(3),
        -- cate_code2 = 0 �̸� ��з�
        cate_code2 NUMBER(3) DEFAULT 0,
        cate_name VARCHAR2(30) NOT NULL,
        CONSTRAINT category_pk PRIMARY KEY (cate_code1, cate_code2)
    );
    -- 2-2. ��ǰ
    CREATE TABLE goods (
        goods_no NUMBER PRIMARY KEY,
        goods_name VARCHAR2(300) NOT NULL,
        cate_code1 NUMBER(3) NOT NULL,
        cate_code2 NUMBER(3) NOT NULL,
        image_name VARCHAR2(300) NOT NULL,
        content VARCHAR2(2000),
        company VARCHAR2(60) NOT NULL,
        product_date DATE,
        CONSTRAINT goods_fk FOREIGN KEY (cate_code1, cate_code2)
        REFERENCES category(cate_code1, cate_code2)
    );
    -- 2-3. ��ǰ������
    CREATE TABLE goods_size (
        goods_size_no NUMBER PRIMARY KEY,
        size_name VARCHAR2(30) NOT NULL,
        goods_no NUMBER REFERENCES goods(goods_no) ON DELETE CASCADE NOT NULL
    );
    -- 2-4. ��ǰ����
    CREATE TABLE goods_color (
        goods_color_no NUMBER PRIMARY KEY,
        color_name VARCHAR2(30) NOT NULL,
        goods_no NUMBER REFERENCES goods(goods_no) ON DELETE CASCADE NOT NULL
    );
    -- 2-5. ��ǰ�̹���
    CREATE TABLE goods_image (
        goods_image_no NUMBER PRIMARY KEY,
        image_name VARCHAR2(300) NOT NULL,
        goods_no NUMBER REFERENCES goods(goods_no) ON DELETE CASCADE NOT NULL
    );
    -- 2-6. ��ǰ����
    CREATE TABLE goods_price (
        goods_price_no NUMBER PRIMARY KEY,
        price NUMBER(9) NOT NULL,
        discount NUMBER(9) DEFAULT 0,
        discount_rate NUMBER(3) DEFAULT 0,
        sale_price NUMBER(9) NOT NULL,
        saved_rate NUMBER(3) DEFAULT 0,
        delivery_charge NUMBER(6) DEFAULT 0,
        sale_start_date DATE DEFAULT sysdate,
        sale_end_date DATE DEFAULT '9999-12-31',
        goods_no NUMBER REFERENCES goods(goods_no) ON DELETE CASCADE NOT NULL
    );
    
    // ������ ����
    CREATE SEQUENCE goods_seq;
    CREATE SEQUENCE goods_size_seq;
    CREATE SEQUENCE goods_color_seq;
    CREATE SEQUENCE goods_image_seq;
    CREATE SEQUENCE goods_price_seq;

-- 3. ���� ������ �߰�
    -- 3-1. ī�װ�
    -- ��з�
    -- NVL(A, B) : A�� null �̸� B�� �����Ѵ�.
    INSERT INTO category(cate_code1, cate_name)
    VALUES((select NVL(max(cate_code1),0)+1 from category), '�Ƿ�');
    INSERT INTO category(cate_code1, cate_name)
    VALUES((select NVL(max(cate_code1),0)+1 from category), '�Ź�');
    commit;
    select * from category;
    
    -- �ߺз�
    INSERT INTO category(cate_code1, cate_code2, cate_name)
    VALUES(1,(select NVL(max(cate_code2),0)+1 from category), '������ ����');
    INSERT INTO category(cate_code1, cate_code2, cate_name)
    VALUES(1,(select NVL(max(cate_code2),0)+1 from category), '������ ����');
    INSERT INTO category(cate_code1, cate_code2, cate_name)
    VALUES(1,(select NVL(max(cate_code2),0)+1 from category), '������ ����');
    INSERT INTO category(cate_code1, cate_code2, cate_name)
    VALUES(1,(select NVL(max(cate_code2),0)+1 from category), '������ ����');

    INSERT INTO category(cate_code1, cate_code2, cate_name)
    VALUES(2,(select NVL(max(cate_code2),0)+1 from category), '�Ż�ȭ');
    INSERT INTO category(cate_code1, cate_code2, cate_name)
    VALUES(2,(select NVL(max(cate_code2),0)+1 from category), '�ȭ');

    commit;
    select * from category;
    -- ��з��� �������� ����
    select * from category where cate_code2 = 0;
    -- ��з�'�Ƿ�'�� �ߺз��� �������� ����
    select * from category where cate_code1 = 1 and cate_code2 != 0;
    
    -- ��ǰ
    INSERT INTO goods(goods_no, goods_name, cate_code1, cate_code2, image_name,
        content, company, product_date)
    VALUES (goods_seq.nextval, '���� ��Ÿ�� ���� ����', 1, 1,
        '/upload/goods/man01.jpg', '������ ���� ������ ����, ������ ����',
        'EZEN', '2024-10-02');
    commit;
    select * from goods;
    
    -- ��ǰ�̹���
    INSERT INTO goods_image(goods_image_no, image_name, goods_no)
    VALUES (goods_image_seq.nextval, '/upload/goods/man02.jpg', 1);
    INSERT INTO goods_image(goods_image_no, image_name, goods_no)
    VALUES (goods_image_seq.nextval, '/upload/goods/man03.jpg', 1);
    commit;
    select * from goods_image;
    
    -- ��ǰ������
    INSERT INTO goods_size(goods_size_no, size_name, goods_no)
    VALUES (goods_size_seq.nextval, 'M', 1);
    INSERT INTO goods_size(goods_size_no, size_name, goods_no)
    VALUES (goods_size_seq.nextval, 'L', 1);
    INSERT INTO goods_size(goods_size_no, size_name, goods_no)
    VALUES (goods_size_seq.nextval, 'XL', 1);
    commit; 
    select * from goods_size;
    
    -- ��ǰ�÷�
    INSERT INTO goods_color(goods_color_no, color_name, goods_no)
    VALUES (goods_color_seq.nextval, 'BLACK', 1);
    INSERT INTO goods_color(goods_color_no, color_name, goods_no)
    VALUES (goods_color_seq.nextval, 'GRAY', 1);
    INSERT INTO goods_color(goods_color_no, color_name, goods_no)
    VALUES (goods_color_seq.nextval, 'NAVY', 1);
    commit;
    select * from goods_color;
    
    -- ��ǰ����
    -- ���� ��ǰ���� �ǸűⰣ�� ��ġ�� �ȵȴ�.
    -- ���糯¥ (�Ǹ���) : 1��
    INSERT INTO goods_price(goods_price_no, price, discount, discount_rate, sale_price,
        saved_rate, delivery_charge, sale_start_date, sale_end_date, goods_no)
    VALUES(goods_price_seq.nextval, 100000, 0, 0, 100000, 0, 0,
        '2024-10-20', '2024-10-31', 1);
    -- �������� (������) - �Ǹ����� ��ġ�� �ȵȴ�.
    INSERT INTO goods_price(goods_price_no, price, discount, discount_rate, sale_price,
        saved_rate, delivery_charge, sale_start_date, sale_end_date, goods_no)
    VALUES(goods_price_seq.nextval, 100000, 0, 0, 100000, 0, 0,
        '2024-10-11', '2024-10-19', 1);
    INSERT INTO goods_price(goods_price_no, price, discount, discount_rate, sale_price,
        saved_rate, delivery_charge, sale_start_date, sale_end_date, goods_no)
    VALUES(goods_price_seq.nextval, 100000, 0, 0, 100000, 0, 0,
        '2024-10-03', '2024-10-10', 1);
    -- ���డ�� (����������)
    INSERT INTO goods_price(goods_price_no, price, discount, discount_rate, sale_price,
        saved_rate, delivery_charge, sale_start_date, sale_end_date, goods_no)
    VALUES(goods_price_seq.nextval, 100000, 10000, 0, 90000, 0, 0,
        '2024-11-01', '2024-11-10', 1);
    INSERT INTO goods_price(goods_price_no, price, discount, discount_rate, sale_price,
        saved_rate, delivery_charge, sale_start_date, sale_end_date, goods_no)
    VALUES(goods_price_seq.nextval, 100000, 0, 50, 50000, 0, 0,
        '2024-11-11', '2024-12-31', 1);
    commit;
    select * from goods_price;
    
    









