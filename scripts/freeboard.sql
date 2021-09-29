-- 자유게시판 : 테이블2개 (메인글저장, 댓글저장)

create table freeboard(
	idx int not null auto_increment,
	name varchar(30) not null,					-- 작성자
	password varchar(10) not null,				-- 글비밀번호(필요할때만 사용)
	subject varchar(40) not null,				-- 글제목
	content varchar(2000) not null,				-- 내용
	readCount int default 0,					-- 조회수
	wdate datetime default current_timestamp,	-- 서버의 현재날짜/시간
	ip varchar(15) default '127.0.0.1',			-- 접속자 ip
	commentCount smallint default 0,			-- 댓글 개수
	primary key(idx)
);
ALTER TABLE freeboard MODIFY COLUMN wdate timestamp
DEFAULT current_timestamp;	-- timezone에 따라 설정


insert into freeboard (name,password,subject,content,ip)
values ('honey','1111','웰컴 ~~','하이 반가워','192.168.17.3');
insert into freeboard (name,password,subject,content,ip)
values ('사나','1111','welcome my home ~~','하이 반가워 어서와','192.168.22.3');
insert into freeboard (name,password,subject,content,ip)
values ('나나','1111','굿바이 ~~','잘가 또봐','192.168.23.3');
insert into freeboard (name,password,subject,content,ip)
values ('nayeon','1111','웰컴 ~~','하이 반가워2','192.168.24.3');
insert into freeboard (name,password,subject,content,ip)
values ('박찬호','1111','헬로우~~','운동좀 하자','192.168.25.3');
insert into freeboard (name,password,subject,content,ip)
values ('세리박','1111','하이 ~~','운동하러 가야지','192.168.26.3');

select * from freeboard;

-- mysql 에는 limit 키워드 : limit 번호,개수
-- mysql,oracle select 결과에 대해 각행에 순서대로 번호를 부여하는 컬럼(row num)
-- 이 만들어진다. limit 의 번호는 row num 이다.(mysql 은 0부터 시작)
select * from freeboard f order by idx desc;
select * from freeboard f order by idx desc limit 0,15;	-- 1페이지 목록
select * from freeboard f order by idx desc limit 15,15;	-- 2페이지 목록
select * from freeboard f order by idx desc limit 30,15;	-- 3페이지 목록
-- 계산식 : n=10페이지 글은? (n-1)*15
select * from freeboard f order by idx desc limit 135,15;	-- 10페이지 목록
commit;

-- 글 수정 : subject, content 수정. idx 컬럼을 조건으로 한다.
update freeboard set subject ='굿나잇~', content ='잘자고 내일보자'
where idx=154;

-- 조회수 변경 : 읽을 때마다(url 요청 발생) 카운트 +1
update freeboard set readCount = readCount +1 where idx=154;

-- 글 삭제 : 글 비밀번호 1)있을때 2)없을때
delete from freeboard where idx=151 and password ='1111';
delete from freeboard where idx=151;

select * from freeboard order by idx desc limit 0,15;
-- 글 비밀번호 체크(로그인 기능에도 참고)
select * from freeboard f where idx=151 and password ='1212';	-- 잘못된 비밀번호 : 쿼리결과 null
select * from freeboard f where idx=151 and password ='1111';	-- 옳바른 비밀번호 : 쿼리결과 1개 행 조회

-- 댓글 테이블 : board_comment
create table board_comment(
	idx int not null auto_increment,
	mref int not null,							-- 메인글(부모글)의 idx값
	name varchar(30) not null,					-- 작성자
	password varchar(10) not null,				-- 글비밀번호(필요할때만 사용)
	content varchar(2000) not null,				-- 내용
	wdate timestamp default current_timestamp,	-- 서버의 현재날짜/시간
	ip varchar(15) default '127.0.0.1',			-- 접속자 ip
	primary key(idx),
	foreign key(mref) references freeboard(idx)
);

insert into board_comment(mref,name,password,content,ip)
values(154,'다현','1234','오늘 하루도 무사히','192.168.11.11');
insert into board_comment(mref,name,password,content,ip)
values(154,'다현','1234','오늘 하루도 무사히','192.168.11.11');
insert into board_comment(mref,name,password,content,ip)
values(154,'다현','1234','오늘 하루도 무사히','192.168.11.11');

insert into board_comment(mref,name,password,content,ip)
values(147,'다현','1234','오늘 하루도 무사히','192.168.11.11');

-- 1)
insert into board_comment(mref,name,password,content,ip)
values(147,'다현','1234','오늘 하루도 무사히','192.168.11.11');


-- 댓글 개수(글목록에서 필요)
select count(*) from board_comment where mref=	154;	-- 154번글의 댓글 갯수 
select count(*) from board_comment where mref=	147;	-- 172번글의 댓글 갯수 
select count(*) from board_comment where mref=	100;	-- 100번글의 댓글 갯수(없는것)

-- 2) 댓글 리스트
select * from board_comment where mref = 154;
select * from board_comment where mref = 147;
select * from board_comment where mref = 100;

-- 3) 글목록 실행하는 dao.getList() 보다 앞에서 댓글개수를 update 
update freeboard set commentCount=(
select count(*) from board_comment where mref=154) where idx=154;
update freeboard set commentCount=(
select count(*) from board_comment where mref=147) where idx=147;

-- 4) 글상세보기에서 댓글 입력 후 저장할 때
update freeboard set commentCount=commentCount+1 where idx=0;