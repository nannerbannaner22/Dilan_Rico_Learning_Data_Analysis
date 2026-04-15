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
insert into [smd].[Demographic_Ranges] VALUES(11, 25, 34)
insert into [smd].[Demographic_Ranges] VALUES(12, 25, 44)
insert into [smd].[Demographic_Ranges] VALUES(13, 26, 35)
insert into [smd].[Demographic_Ranges] VALUES(14, 30, 34)
insert into [smd].[Demographic_Ranges] VALUES(15, 30, 39)
insert into [smd].[Demographic_Ranges] VALUES(16, 30, 49)
insert into [smd].[Demographic_Ranges] VALUES(17, 35, 39)
insert into [smd].[Demographic_Ranges] VALUES(18, 35, 44)
insert into [smd].[Demographic_Ranges] VALUES(29, 35, 49)
insert into [smd].[Demographic_Ranges] VALUES(20, 40, 44)
insert into [smd].[Demographic_Ranges] VALUES(21, 45, 125)
insert into [smd].[Demographic_Ranges] VALUES(22, 45, 49)
insert into [smd].[Demographic_Ranges] VALUES(23, 45, 54)
insert into [smd].[Demographic_Ranges] VALUES(24, 50, 125)
insert into [smd].[Demographic_Ranges] VALUES(25, 50, 54)
insert into [smd].[Demographic_Ranges] VALUES(26, 51, 125)
insert into [smd].[Demographic_Ranges] VALUES(27, 55, 125)
insert into [smd].[Demographic_Ranges] VALUES(28, 55, 59)
insert into [smd].[Demographic_Ranges] VALUES(29, 55, 64)
insert into [smd].[Demographic_Ranges] VALUES(30, 60, 64)
insert into [smd].[Demographic_Ranges] VALUES(31, 65, 125)
insert into [smd].[Demographic_Ranges] VALUES(32, 18, 22)
insert into [smd].[Demographic_Ranges] VALUES(33, 20, 39)
insert into [smd].[Demographic_Ranges] VALUES(34, 18, 45)
insert into [smd].[Demographic_Ranges] VALUES(35, 0, 30)
insert into [smd].[Demographic_Ranges] VALUES(36, 0, 34)

select * from [smd].Demographic_Ranges;

create table [smd].[Social_Media_Demographics] (
    Id int IDENTITY(1,1) PRIMARY KEY,
    Platform_Id int,
    Total_Monthly_Active_Users_Billion DECIMAL(6,3),
    Total_Monthly_Active_Users_Is_Projected bit,
    Range_Id int,
    Percentage_of_Female_Users_within_age_group DECIMAL(6,2),
    Percentage_of_Male_Users_within_age_group DECIMAL(6,2),
    Overall_Percentage_of_Female_Users DECIMAL(6,2),
    Overall_Percentage_of_Male_Users DECIMAL(6,2),
    Notes VARCHAR(255),
    CONSTRAINT FK_PlatformId FOREIGN KEY (Platform_Id)
        REFERENCES [smd].[Platform](Id),
    CONSTRAINT FK_Range_Id FOREIGN KEY (Range_Id)
        REFERENCES [smd].[Demographic_Ranges](Id)
);

select * from [smd].Social_Media_Demographics smd