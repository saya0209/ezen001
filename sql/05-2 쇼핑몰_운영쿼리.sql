-- 1. 상품 리스트: 상품번호, 상품명, 가격, 할인, 판매가격, 이미지
-- 1-1. 모든 상품 리스트 보여주는 경우
SELECT g.goods_no AS goodsNo, g.goods_name AS goodsName,
       p.price, p.discount, p.sale_price,
       g.image_name AS imageName
FROM goods g
JOIN goods_price p ON g.goods_no = p.goods_no
WHERE p.sale_start_date <= SYSDATE AND TRUNC(SYSDATE) <= p.sale_end_date
ORDER BY g.goods_no;

-- 1-2. 상품 검색 리스트 (조건에 따라 검색)
SELECT g.goods_no AS goodsNo, g.goods_name AS goodsName,
       p.price, p.discount, p.sale_price,
       g.image_name AS imageName
FROM goods g
JOIN goods_price p ON g.goods_no = p.goods_no
WHERE 
    -- 검색 조건 포함
    (g.cate_code1 = #{goodsSearchVO.cate_code1} OR #{goodsSearchVO.cate_code1} IS NULL) AND
    (g.cate_code2 = #{goodsSearchVO.cate_code2} OR #{goodsSearchVO.cate_code2} IS NULL) AND
    (g.cate_code3 = #{goodsSearchVO.cate_code3} OR #{goodsSearchVO.cate_code3} IS NULL) AND
    (g.goods_name LIKE '%' || #{goodsSearchVO.goods_name} || '%' OR #{goodsSearchVO.goods_name} IS NULL) AND
    (p.sale_price >= #{goodsSearchVO.min_price} OR #{goodsSearchVO.min_price} IS NULL) AND
    (p.sale_price <= #{goodsSearchVO.max_price} OR #{goodsSearchVO.max_price} IS NULL)
ORDER BY g.goods_no;

-- 1-3. 상품 상세 보기
SELECT g.goods_no AS goodsNo, g.goods_name AS goodsName,
       g.cate_code1, g.cate_code2, g.cate_code3, g.image_name AS imageName,
       g.content, g.company, g.product_date AS productDate,
       p.price, p.discount, p.sale_price, p.delivery_charge,
       p.sale_start_date AS saleStartDate, p.sale_end_date AS saleEndDate
FROM goods g
JOIN goods_price p ON g.goods_no = p.goods_no
WHERE g.goods_no = #{goods_no} AND
      p.sale_start_date <= SYSDATE AND TRUNC(SYSDATE) <= p.sale_end_date;

-- 1-4. 상품 이미지 리스트
SELECT goods_image_no AS imageNo, image_name AS imageName, goods_no AS goodsNo
FROM goods_image
WHERE goods_no = #{goods_no};

-- 2. 상품 등록
INSERT INTO goods (goods_no, goods_name, cate_code1, cate_code2, cate_code3, image_name, content, company, product_date)
VALUES (#{goods_no}, #{goods_name}, #{cate_code1}, #{cate_code2}, #{cate_code3}, #{image_name}, #{content}, #{company}, #{product_date});

-- 3. 가격 정보 등록
INSERT INTO goods_price (goods_price_no, price, discount, sale_price, saved_rate, delivery_charge, sale_start_date, sale_end_date, goods_no)
VALUES (goods_price_seq.nextval, #{price}, #{discount}, #{sale_price}, #{saved_rate}, #{delivery_charge}, #{sale_start_date}, #{sale_end_date}, #{goods_no});

-- 4. 상품 수정
UPDATE goods
SET cate_code1 = #{cate_code1}, cate_code2 = #{cate_code2}, cate_code3 = #{cate_code3},
    goods_name = #{goods_name}, company = #{company},
    content = #{content}, product_date = #{product_date}
WHERE goods_no = #{goods_no};

-- 5. 상품 가격 수정
UPDATE goods_price
SET price = #{price}, discount = #{discount}, sale_price = #{sale_price}, 
    saved_rate = #{saved_rate}, delivery_charge = #{delivery_charge},
    sale_start_date = #{sale_start_date}, sale_end_date = #{sale_end_date}
WHERE goods_no = #{goods_no} AND goods_price_no = #{goods_price_no};

-- 6. 상품 이미지 삭제
DELETE FROM goods_image
WHERE image_name = #{image_name};

-- 7. 전체 상품 수 카운트
SELECT COUNT(*) AS totalRow
FROM goods g
JOIN goods_price p ON g.goods_no = p.goods_no
WHERE p.sale_start_date <= SYSDATE AND TRUNC(SYSDATE) <= p.sale_end_date;