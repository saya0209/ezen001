-- ī�װ� � ����

-- 1. ī�װ� ����Ʈ : ��з�, �ߺз�, �Һз�
-- 1-1. ��� ī�װ� ����Ʈ �����ִ� ���
SELECT cate_code1, cate_code2, cate_code3, cate_name
FROM category
ORDER BY cate_code1, cate_code2, cate_code3;

-- 1-2. ��з� ī�װ� ����Ʈ
SELECT cate_code1, cate_name
FROM category
WHERE cate_code2 = 0 AND cate_code3 = 0
ORDER BY cate_code1;

-- 1-3. �ߺз� ī�װ� ����Ʈ
SELECT cate_code2, cate_name
FROM category
WHERE cate_code1 = #{cate_code1} AND cate_code3 = 0
ORDER BY cate_code2;

-- 1-4. �Һз� ī�װ� ����Ʈ
SELECT cate_code3, cate_name
FROM category
WHERE cate_code1 = #{cate_code1} AND cate_code2 = #{cate_code2}
ORDER BY cate_code3;

-- 2. ī�װ� ���
-- ��з� ��� ����
INSERT INTO category(cate_code1, cate_name)
VALUES (
  (SELECT NVL(MAX(cate_code1), 0) + 1 FROM category),
  #{cate_name}
);

-- �ߺз� ��� ����
INSERT INTO category(cate_code1, cate_code2, cate_name)
VALUES (
  #{cate_code1},
  (SELECT NVL(MAX(cate_code2), 0) + 1 FROM category WHERE cate_code1 = #{cate_code1}),
  #{cate_name}
);

-- �Һз� ��� ����
INSERT INTO category(cate_code1, cate_code2, cate_code3, cate_name)
VALUES (
  #{cate_code1},
  #{cate_code2},
  (SELECT NVL(MAX(cate_code3), 0) + 1 FROM category WHERE cate_code1 = #{cate_code1} AND cate_code2 = #{cate_code2}),
  #{cate_name}
);

-- 3. ī�װ� ����
UPDATE category
SET cate_name = #{cate_name}
WHERE cate_code1 = #{cate_code1}
  <if test="cate_code2 != 0">
    AND cate_code2 = #{cate_code2}
  </if>
  <if test="cate_code3 != 0">
    AND cate_code3 = #{cate_code3}
  </if>;

-- 4. ī�װ� ����
DELETE FROM category
WHERE cate_code1 = #{cate_code1}
<if test="cate_code2 != 0">
  AND cate_code2 = #{cate_code2}
  <if test="cate_code3 != 0">
    AND cate_code3 = #{cate_code3}
  </if>
</if>;