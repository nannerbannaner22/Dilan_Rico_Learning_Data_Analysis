create schema [smd]
select * from smd.Platform;
create table [smd].[Platform] values
(
    Id int primary key,
    PlatformName VARCHAR(255),
    ParentCompany VARCHAR(255)
);

insert into [smd].[Platform] values (1, 'Facebook', 'Meta');
insert into [smd].[Platform] values (2, 'Messenger', 'Meta');
insert into [smd].[Platform] values (3, 'Instagram', 'Meta');
insert into [smd].[Platform] values (4, 'WhatsApp', 'Meta');
insert into [smd].[Platform] values (5, 'Threads', 'Meta');
insert into [smd].[Platform] values (6, 'TikTok', 'ByteDance Ltd');
insert into [smd].[Platform] values (7, 'Douyin', 'ByteDance Ltd');
insert into [smd].[Platform] values (8, 'Snapchat', 'Snap Inc');
insert into [smd].[Platform] values (9, 'LinkedIn', 'Microsoft');
insert into [smd].[Platform] values (10, 'YouTube', 'Alphabet Inc');
insert into [smd].[Platform] values (11, 'Pinterest', 'None');
insert into [smd].[Platform] values (12, 'Reddit', 'Advance Publications');
insert into [smd].[Platform] values (13, 'Telegram', 'None');
insert into [smd].[Platform] values (14, 'Twitter (X)', 'X Corp');
insert into [smd].[Platform] values (15, 'Qzone', 'Tencent');
insert into [smd].[Platform] values (16, 'WeChat Weixin', 'Tencent');
insert into [smd].[Platform] values (17, 'QQ', 'Tencent');
insert into [smd].[Platform] values (18, 'Tumblr', 'Automattic');
insert into [smd].[Platform] values (19, 'Discord', 'Discord Inc');
insert into [smd].[Platform] values (20, 'Kuaishou', 'None');
insert into [smd].[Platform] values (21, 'LINE', 'LY Corporation');
insert into [smd].[Platform] values (22, 'Sina Weibo', 'Sina Corporation');
insert into [smd].[Platform] values (23, 'Twitch', 'Amazon');
insert into [smd].[Platform] values (24, 'Quora', 'None');
insert into [smd].[Platform] values (25, 'Viber', 'Rakuten Group, Inc');

create view [smd].[Parent_Company_Grouping] as
 select count(p.Id) as [count], p.ParentCompany from smd.Platform p where not p.ParentCompany = 'None' group by p.ParentCompany;

select * from [smd].Parent_Company_Grouping pcg order by pcg.[count];

--create table
create table [smd].[Demographic_Ranges]
(
    Id int primary key,
    Age_Lower_Bound int,
    Age_Upper_Bound int,
)
select * from [smd].[Demographic_Ranges];
insert into [smd].[Demographic_Ranges] VALUES(1, 13, 17)
insert into [smd].[Demographic_Ranges] VALUES(2, 15, 19)
insert into [smd].[Demographic_Ranges] VALUES(3, 15, 25)
insert into [smd].[Demographic_Ranges] VALUES(4, 16, 24)
insert into [smd].[Demographic_Ranges] VALUES(5, 18, 24)

insert into [smd].[Demographic_Ranges] VALUES(6, 18, 34)
insert into [smd].[Demographic_Ranges] VALUES(7, 18, 35)

insert into [smd].[Demographic_Ranges] VALUES(8, 19, 29)
insert into [smd].[Demographic_Ranges] VALUES(9, 20, 24)

insert into [smd].[Demographic_Ranges] VALUES(10, 25, 29)