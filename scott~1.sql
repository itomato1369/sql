-- story  테이블 생성 전 , 관련된 sequence, trigger, table 정리
DROP TABLE gift_applicant CASCADE CONSTRAINTS;
DROP TABLE story CASCADE CONSTRAINTS;
DROP SEQUENCE story_seq;

-- story 테이블의 ID 자동 생성을 위한 sequence
CREATE SEQUENCE story_seq
  INCREMENT BY 1 -- 매번 1씩 증가
  START WITH 1  -- 1부터 시작
  MINVALUE 1  -- 최소 값은 1
  NOMAXVALUE  -- 최대 값 지정하지 않고 순환 하지 않는다
  NOCYCLE
  CACHE 20;  -- 성능 향상을 위해 20개 캐시 사용
  
-- story 테이블 생성
CREATE TABLE story (
  story_id NUMBER PRIMARY KEY,
  story_name NVARCHAR2(50) NOT NULL,
  story_age NUMBER NOT NULL,
  story_gender NVARCHAR2(10) NOT NULL,
  story_content NCLOB NOT NULL,
  story_pw NVARCHAR2(100) NOT NULL,
  gift_apply CHAR(1) NOT NULL,
  apply_date TIMESTAMP DEFAULT SYSTIMESTAMP NOT NULL
);
-- date 와 시스템 자동생성이므로 timestamp와 default systimestamp를 사용
-- story 테이블과 FOREIGN KEY 설정
-- sequence는 번호표를 뽑는 기계이고 직접 전달하는 역할은 triger
CREATE OR REPLACE TRIGGER trg_story_id
  BEFORE INSERT ON story
  FOR EACH ROW
BEGIN
  IF :NEW.story_id IS NULL THEN
    SELECT story_seq.NEXTVAL INTO :NEW.story_id FROM dual;
  END IF;
END;
/ 
-- gift_applicant 테이블 생성
CREATE TABLE gift_applicant (
  story_id NUMBER PRIMARY KEY,
  applicant_name NVARCHAR2(50) NOT NULL,
  applicant_email NVARCHAR2(255) NOT NULL,
  applicant_postal VARCHAR2(10) NOT NULL,
  applicant_phone VARCHAR2(20) NOT NULL,
  address_detail NVARCHAR2(255) NOT NULL,
  privacy_agree CHAR(1) NOT NULL,
-- story 테이블과 FOREIGN KEY 설정 추가
  CONSTRAINT fk_applicant_story
    FOREIGN KEY (story_id)
    REFERENCES story(story_id)
    -- 부모 테이블 (story) 삭제시 응모 정보도 함께 삭제하도록
    ON DELETE CASCADE
);
  

SELECT *
FROM story;
SELECT *
FROM gift_applicant;

  
  
  
  
  
  
  
  
  
