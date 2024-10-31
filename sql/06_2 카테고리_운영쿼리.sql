-- 카테고리 운영 쿼리

-- 1. 카테고리 리스트 : 대분류, 중분류, 소분류
-- 1-1. 모든 카테고리 리스트 보여주는 경우
SELECT cate_code1, cate_code2, cate_code3, cate_name
FROM category
ORDER BY cate_code1, cate_code2, cate_code3;

-- 1-2. 대분류 카테고리 리스트
SELECT cate_code1, cate_name
FROM category
WHERE cate_code2 = 0 AND cate_code3 = 0
ORDER BY cate_code1;

-- 1-3. 중분류 카테고리 리스트
SELECT cate_code2, cate_name
FROM category
WHERE cate_code1 = #{cate_code1} AND cate_code3 = 0
ORDER BY cate_code2;

-- 1-4. 소분류 카테고리 리스트
SELECT cate_code3, cate_name
FROM category
WHERE cate_code1 = #{cate_code1} AND cate_code2 = #{cate_code2}
ORDER BY cate_code3;

-- 2. 카테고리 등록
-- 대분류 등록 쿼리
INSERT INTO category(cate_code1, cate_name)
VALUES (
  (SELECT NVL(MAX(cate_code1), 0) + 1 FROM category),
  #{cate_name}
);

-- 중분류 등록 쿼리
INSERT INTO category(cate_code1, cate_code2, cate_name)
VALUES (
  #{cate_code1},
  (SELECT NVL(MAX(cate_code2), 0) + 1 FROM category WHERE cate_code1 = #{cate_code1}),
  #{cate_name}
);

-- 소분류 등록 쿼리
INSERT INTO category(cate_code1, cate_code2, cate_code3, cate_name)
VALUES (
  #{cate_code1},
  #{cate_code2},
  (SELECT NVL(MAX(cate_code3), 0) + 1 FROM category WHERE cate_code1 = #{cate_code1} AND cate_code2 = #{cate_code2}),
  #{cate_name}
);

-- 3. 카테고리 수정
UPDATE category
SET cate_name = #{cate_name}
WHERE cate_code1 = #{cate_code1}
  <if test="cate_code2 != 0">
    AND cate_code2 = #{cate_code2}
  </if>
  <if test="cate_code3 != 0">
    AND cate_code3 = #{cate_code3}
  </if>;

-- 4. 카테고리 삭제
DELETE FROM category
WHERE cate_code1 = #{cate_code1}
<if test="cate_code2 != 0">
  AND cate_code2 = #{cate_code2}
  <if test="cate_code3 != 0">
    AND cate_code3 = #{cate_code3}
  </if>
</if>;