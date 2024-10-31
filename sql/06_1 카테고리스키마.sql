-- CATEGORY 테이블 생성
CREATE TABLE category (
    cate_code1 NUMBER(3),
    cate_code2 NUMBER(3),
    cate_code3 NUMBER(3),
    cate_name VARCHAR2(30) NOT NULL,
    PRIMARY KEY (cate_code1, cate_code2, cate_code3) 
);

-- COMPONENT 테이블 생성
CREATE TABLE component (
    cate_code1 NUMBER(3),
    cate_code2 NUMBER(3),
    cate_name VARCHAR2(30) NOT NULL,
    PRIMARY KEY (cate_code1, cate_code2)
);

-- 샘플 데이터 삽입: 카테고리
INSERT INTO category (cate_code1, cate_code2, cate_code3, cate_name) 
VALUES (1, 1, 1, '컴퓨터 주요 부품');

INSERT INTO category (cate_code1, cate_code2, cate_code3, cate_name) 
VALUES (1, 2, 1, '주변기기');


-- 샘플 데이터 삽입: 컴포넌트
INSERT INTO component (cate_code1, cate_code2, cate_name) 
VALUES (1, 1, 'CPU');

INSERT INTO component (cate_code1, cate_code2, cate_name) 
VALUES (1, 1, '그래픽 카드');



-- 카테고리 및 컴포넌트 데이터 조회
SELECT 
    c.cate_code1, c.cate_code2, c.cate_code3, c.cate_name AS category_name,
    cp.cate_name AS component_name
FROM 
    category c
LEFT JOIN 
    component cp ON c.cate_code1 = cp.cate_code1 AND c.cate_code2 = cp.cate_code2;

-- 전체 카테고리 리스트
SELECT * FROM category;

-- 전체 컴포넌트 리스트
SELECT * FROM component;