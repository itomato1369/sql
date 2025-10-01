
-- 1page: 1 ~ 10, 2page: 11 ~ 20,...,
SELECT b.*
FROM (SELECT /*+ INDEX_DESC(a SYS_C008735)*/ ROWNUM rn, a.*
      FROM board_t a) b
WHERE b.rn > (:PAGE - 1) * 10 -- 1page 당 10개씩 값 출력
AND b.rn <= (:PAGE * 10);

SELECT /*+ INDEX_DESC(b SYS_C008735)*/ b.*
FROM board_t b;

CREATE INDEX board_write_date_idx
ON board_t(write_date);


DELETE FROM board_t
WHERE board_no = 6;








