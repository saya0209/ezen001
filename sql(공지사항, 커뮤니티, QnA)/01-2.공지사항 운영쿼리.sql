-- �������� � ����

-- 1. ����Ʈ : ������ȣ, ����, �Խ���, ������
-- 1-1. ��� ����Ʈ �����ִ� ���
-- ��¥ ������ 'yyyy-mm-dd'���� �����ݴϴ�.
SELECT notice_no AS no, title,
       TO_CHAR(writeDate, 'yyyy-mm-dd') AS writeDate,
       TO_CHAR(endDate, 'yyyy-mm-dd') AS endDate
FROM notice 
ORDER BY updateDate DESC, notice_no DESC;

-- 1-2. ���� ���� ����Ʈ ����
SELECT notice_no AS no, title,
       TO_CHAR(writeDate, 'yyyy-mm-dd') AS writeDate,
       TO_CHAR(endDate, 'yyyy-mm-dd') AS endDate
FROM notice 
WHERE startDate <= SYSDATE AND SYSDATE <= endDate 
ORDER BY updateDate DESC, notice_no DESC;

-- 1-3. ���� ���� ����Ʈ ���� (�������� �����Ϻ��� �ڿ� �ֽ��ϴ�)
SELECT notice_no AS no, title,
       TO_CHAR(writeDate, 'yyyy-mm-dd') AS writeDate,
       TO_CHAR(endDate, 'yyyy-mm-dd') AS endDate
FROM notice 
WHERE SYSDATE > endDate 
ORDER BY updateDate DESC, notice_no DESC;

-- 1-4. ���� ���� ����Ʈ ó�� (�������� �����Ϻ��� �տ� �ֽ��ϴ�)
SELECT notice_no AS no, title,
       TO_CHAR(writeDate, 'yyyy-mm-dd') AS writeDate,
       TO_CHAR(endDate, 'yyyy-mm-dd') AS endDate
FROM notice 
WHERE SYSDATE < startDate 
ORDER BY updateDate DESC, notice_no DESC;


SELECT * FROM notice;

