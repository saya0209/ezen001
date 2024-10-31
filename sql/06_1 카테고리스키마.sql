-- CATEGORY ���̺� ����
CREATE TABLE category (
    cate_code1 NUMBER(3),
    cate_code2 NUMBER(3),
    cate_code3 NUMBER(3),
    cate_name VARCHAR2(30) NOT NULL,
    PRIMARY KEY (cate_code1, cate_code2, cate_code3) 
);

-- COMPONENT ���̺� ����
CREATE TABLE component (
    cate_code1 NUMBER(3),
    cate_code2 NUMBER(3),
    cate_name VARCHAR2(30) NOT NULL,
    PRIMARY KEY (cate_code1, cate_code2)
);

-- ���� ������ ����: ī�װ�
INSERT INTO category (cate_code1, cate_code2, cate_code3, cate_name) 
VALUES (1, 1, 1, '��ǻ�� �ֿ� ��ǰ');

INSERT INTO category (cate_code1, cate_code2, cate_code3, cate_name) 
VALUES (1, 2, 1, '�ֺ����');


-- ���� ������ ����: ������Ʈ
INSERT INTO component (cate_code1, cate_code2, cate_name) 
VALUES (1, 1, 'CPU');

INSERT INTO component (cate_code1, cate_code2, cate_name) 
VALUES (1, 1, '�׷��� ī��');



-- ī�װ� �� ������Ʈ ������ ��ȸ
SELECT 
    c.cate_code1, c.cate_code2, c.cate_code3, c.cate_name AS category_name,
    cp.cate_name AS component_name
FROM 
    category c
LEFT JOIN 
    component cp ON c.cate_code1 = cp.cate_code1 AND c.cate_code2 = cp.cate_code2;

-- ��ü ī�װ� ����Ʈ
SELECT * FROM category;

-- ��ü ������Ʈ ����Ʈ
SELECT * FROM component;