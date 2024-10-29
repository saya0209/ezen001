-- 회원 등급 및 회원

-- 1. 객체 제거
drop table member cascade constraints purge;
drop table grade cascade constraints purge;

-- 2. 객체 생성
-- grdae table 생성
create table grade (
    gradeNo number(1) primary key,
    gradeName varchar2(21) not null
);

-- sample date 입력
insert into grade values (1, '일반회원');
insert into grade values (9, '관리자');
commit;

-- member table 생성
create table member(
    gradeno  number(1) default 1 references grade(gradeNo),
    gradeName varchar2(10) default '일반회원' references grade(gradeName),
    status  varchar2(6) default '정상',
    id varchar2(20) primary key,
    pw varchar2(20) not null,
    nicname varchar2(30) not null,
    tel  varchar2(13),
    email varchar2(50) not null,
    address varchar2(100) not null,
    regDate date default sysDate,
    conDate date default sysDate,
    photo  varchar2(100)
);

-- sample date 입력
insert into member (id,pw,name, gender, birth, email, gradeNo) values('admin','admin','관리자','여성','1975-04-23','mukgabi@naver.com',9);
insert into member (id,pw,name, gender, birth, email, gradeNo) values('test1','test1','테스터','남성','2000-01-1','test1@naver.com',1);
commit;

