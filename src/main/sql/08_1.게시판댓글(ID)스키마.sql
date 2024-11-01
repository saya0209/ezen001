-- �ϹݰԽ��� ������
-- ��۵� �ϳ��� ���̺�� ������ �մϴ�.
-- �ϹݰԽ��� ��� ��Ű�� �ۼ�
-- ��۹�ȣ(PK), �۹�ȣ(��� �޸� �������?, FK, board.no),
-- ����, ������, �ۼ���, ��й�ȣ

-- 1. ��ü����
drop table board_reply CASCADE CONSTRAINTS PURGE;
drop SEQUENCE board_reply_seq;

-- 2. ��ü ����
create table board_reply (
    rno number primary key,
    no number references board(no) not null,
    content VARCHAR2(600) not null,
    id varchar2(20) references member(id) not null,
    writeDate date default sysDate
);

create SEQUENCE board_reply_seq;

-- ��� ���õ�����
-- ��ۿ��� �۳ѹ��� ���ϴ�.
select max(no) from board;
insert into board_reply(rno, no, content, id) 
 values (board_reply_seq.nextval, 143, '�����ֽ��ϴ�.', 'test1');

insert into board_reply(rno, no, content, id) 
 values (board_reply_seq.nextval, 143, '�ϹݰԽ��� ���.', 'admin');
commit;
select * from board_reply;



