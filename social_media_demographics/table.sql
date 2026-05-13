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
insert into [smd].[Demographic_Ranges] VALUES(37, 20, 24)

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

delete from  [smd].Social_Media_Demographics 
select * from [smd].Social_Media_Demographics smd
SET IDENTITY_INSERT [smd].Social_Media_Demographics off

select * from [smd].[Social_Media_Demographics]
create or alter view [smd].[Social_Media_Demographics_View] as
    select
        sm.Id,
        p.PlatformName + '-' + p.ParentCompany as [Platform], 
        sm.Total_Monthly_Active_Users_Billion, 
        case 
            when sm.Total_Monthly_Active_Users_Is_Projected is null then 'None'
            when sm.Total_Monthly_Active_Users_Is_Projected = 0 then 'False'
            when sm.Total_Monthly_Active_Users_Is_Projected = 1 then 'True'
        end as [Is_Projection], 
        CAST(dr.Age_Lower_Bound as varchar) + '-' + CAST(dr.Age_Upper_Bound as varchar) as [Range], 
        sm.Percentage_of_Female_Users_within_age_group, 
        sm.Percentage_of_Male_Users_within_age_group, 
        sm.Overall_Percentage_of_Female_Users, 
        sm.Overall_Percentage_of_Male_Users, 
        sm.Notes 
    from [smd].Social_Media_Demographics sm 
    join [smd].[Platform] p on p.Id = sm.Platform_Id
    join [smd].[Demographic_Ranges] dr on dr.Id = sm.Range_Id;

select count(dmv.Id) as [count], round(avg(dmv.Overall_Percentage_of_Female_Users), 2) as [Average_Overall_Percentage_of_Female_Users], round(avg(dmv.Overall_Percentage_of_Male_Users), 2) as [Average_Overall_Percentage_of_Male_Users], dmv.[Range] from [smd].[Social_Media_Demographics_View] dmv group by dmv.[Range] order by round(avg(dmv.Overall_Percentage_of_Female_Users), 2) desc;
select count(dmv.Id) as [count], round(avg(dmv.Overall_Percentage_of_Female_Users), 2) as [Average_Overall_Percentage_of_Female_Users], round(avg(dmv.Overall_Percentage_of_Male_Users), 2) as [Average_Overall_Percentage_of_Male_Users], dmv.[Platform] from [smd].[Social_Media_Demographics_View] dmv group by dmv.[Platform] order by round(avg(dmv.Overall_Percentage_of_Female_Users), 2) desc;

insert into [smd].[Social_Media_Demographics] select (select [Id] from [smd].Platform p where p.Id = 1), 2, 1, (select top 1 [Id] from [smd].[Demographic_Ranges]),                   4, 6, 2, 3, 'test notes';
insert into [smd].[Social_Media_Demographics] select (select [Id] from [smd].Platform p where p.Id = 1),3.07,0,(select top 1 [Id] from [smd].[Demographic_Ranges] dr where dr.Id = 1),0,0,43.20,56.80, 'Declining youth usage strong among (12.7 F - 18.4 M) Male users generally outnumber females';
insert into [smd].[Social_Media_Demographics] select (select [Id] from [smd].Platform p where p.Id = 3),2,0,(select top 1 [Id] from [smd].[Demographic_Ranges] dr where dr.Id = 1),7,7,49.40,50.60,'Significant teen presence is largest demographic globally. Nearly balanced gender';
insert into [smd].[Social_Media_Demographics] select (select [Id] from [smd].Platform p where p.Id = 3),0.85,0,(select top 1 [Id] from [smd].[Demographic_Ranges] dr where dr.Id = 1),19.20,19.20,49.00,49.20,'Strong appeal to younger teens and young adults largest group Fairly balanced gender';
insert into [smd].[Social_Media_Demographics] select (select [Id] from [smd].Platform p where p.Id = 21),0.178,0,(select top 1 [Id] from [smd].[Demographic_Ranges] dr where dr.Id = 2),7.90, 0,53.3,46.7,'Primarily dominant in Japan (92M MAU) where gender is slightly female-skewed and age is evenly spread';
insert into [smd].[Social_Media_Demographics] select (select [Id] from [smd].Platform p where p.Id = 18),0.135,0,(select top 1 [Id] from [smd].[Demographic_Ranges] dr where dr.Id = 3),10,10,50,50,'Leans towards younger audience (under 35). Balanced gender distribution among users';
insert into [smd].[Social_Media_Demographics] select (select [Id] from [smd].Platform p where p.Id = 5),0.275,0,(select top 1 [Id] from [smd].[Demographic_Ranges] dr where dr.Id = 3),32,68,32,68,'Heavily male-dominated and strongest among Gen Z and young millennials';
insert into [smd].[Social_Media_Demographics] select (select [Id] from [smd].Platform p where p.Id = 19),0.2,0,(select top 1 [Id] from [smd].[Demographic_Ranges] dr where dr.Id = 4),20.6,20.6,32.60,66.30,'Strong male dominance. Largest age group is';
insert into [smd].[Social_Media_Demographics] select (select [Id] from [smd].Platform p where p.Id = 1),3.07,0,(select top 1 [Id] from [smd].[Demographic_Ranges] dr where dr.Id = 5),9.50,13.50,43.20,56.80, 'None';
insert into [smd].[Social_Media_Demographics] select (select [Id] from [smd].Platform p where p.Id = 3),2,0,(select top 1 [Id] from [smd].[Demographic_Ranges] dr where dr.Id = 5),31.30,31.30,49.40,50.60, 'None';
insert into [smd].[Social_Media_Demographics] select (select [Id] from [smd].Platform p where p.Id = 8),0.85,0,(select top 1 [Id] from [smd].[Demographic_Ranges] dr where dr.Id = 5),38.00,38.00,49.00,49.20, 'None';
insert into [smd].[Social_Media_Demographics] select (select [Id] from [smd].Platform p where p.Id = 9),1.15,0,(select top 1 [Id] from [smd].[Demographic_Ranges] dr where dr.Id = 5),0,0,43.60,56.40, 'Millennials make up 50.6 of users. Skews male';
insert into [smd].[Social_Media_Demographics] select (select [Id] from [smd].Platform p where p.Id = 10),2.7,0,(select top 1 [Id] from [smd].[Demographic_Ranges] dr where dr.Id = 5),6.90,8.90,45.60,54.40, 'Wide appeal across all ages slightly more male users. Largest portion 25-44';
insert into [smd].[Social_Media_Demographics] select (select [Id] from [smd].Platform p where p.Id = 11),0.57,0,(select top 1 [Id] from [smd].[Demographic_Ranges] dr where dr.Id = 5),19.50,6.70,69.40,22.60, 'Heavily female-dominated especially age group';
insert into [smd].[Social_Media_Demographics] select (select [Id] from [smd].Platform p where p.Id = 13),1,0,(select top 1 [Id] from [smd].[Demographic_Ranges] dr where dr.Id = 5),0,0,42,58, 'Majority of users aged 25-44. Skews male';
insert into [smd].[Social_Media_Demographics] select (select [Id] from [smd].Platform p where p.Id = 1),0.965,0,(select top 1 [Id] from [smd].[Demographic_Ranges] dr where dr.Id = 5),8.70,12.10,44.50,55.50, 'Largest demographic is Skews male';
insert into [smd].[Social_Media_Demographics] select (select [Id] from [smd].Platform p where p.Id = 14),0.563,0,(select top 1 [Id] from [smd].[Demographic_Ranges] dr where dr.Id = 6),54.8,54.8,38.80,61.20, 'User base mostly young Skews male.,';
insert into [smd].[Social_Media_Demographics] select (select [Id] from [smd].Platform p where p.Id = 25),0.82,0,(select top 1 [Id] from [smd].[Demographic_Ranges] dr where dr.Id = 6),70,70,52.4,47.6, 'Popular in Eastern Europe and Middle East. 70 of users are between';
insert into [smd].[Social_Media_Demographics] select (select [Id] from [smd].Platform p where p.Id = 7),1.0,0,(select top 1 [Id] from [smd].[Demographic_Ranges] dr where dr.Id = 7),60,60,53,47, 'Dominant in China skews younger fairly balanced gender';
insert into [smd].[Social_Media_Demographics] select (select [Id] from [smd].Platform p where p.Id = 12),0.712,0,(select top 1 [Id] from [smd].[Demographic_Ranges] dr where dr.Id = 8),46,46,51,49, 'Strong among young adults but users across all ages. Balanced gender';
insert into [smd].[Social_Media_Demographics] select (select [Id] from [smd].Platform p where p.Id = 21),0.178,0,(select top 1 [Id] from [smd].[Demographic_Ranges] dr where dr.Id = 9),7.50, 0,53.3,46.7, 'None';
insert into [smd].[Social_Media_Demographics] select (select [Id] from [smd].Platform p where p.Id = 23),0.24,0,(select top 1 [Id] from [smd].[Demographic_Ranges] dr where dr.Id = 34),35,35,37,63,'None';
insert into [smd].[Social_Media_Demographics] select (select [Id] from [smd].Platform p where p.Id = 21),0.178,0,(select top 1 [Id] from [smd].[Demographic_Ranges] dr where dr.Id = 10),7.50, 0,53.3,46.7, 'None';
insert into [smd].[Social_Media_Demographics] select (select [Id] from [smd].Platform p where p.Id = 1),3.07,0,(select top 1 [Id] from [smd].[Demographic_Ranges] dr where dr.Id = 11),12.70,18.40,43.20,56.80, 'None';
insert into [smd].[Social_Media_Demographics] select (select [Id] from [smd].Platform p where p.Id = 3),2,0,(select top 1 [Id] from [smd].[Demographic_Ranges] dr where dr.Id = 11),31.00,31.00,49.40,50.60, 'None';
insert into [smd].[Social_Media_Demographics] select (select [Id] from [smd].Platform p where p.Id = 8),0.85,0,(select top 1 [Id] from [smd].[Demographic_Ranges] dr where dr.Id = 11),24.20,24.20,49.00,49.20, 'None';
insert into [smd].[Social_Media_Demographics] select (select [Id] from [smd].Platform p where p.Id = 9),1.15,0,(select top 1 [Id] from [smd].[Demographic_Ranges] dr where dr.Id = 11),0,0,43.60,56.40, 'None';
insert into [smd].[Social_Media_Demographics] select (select [Id] from [smd].Platform p where p.Id = 10),2.7,0,(select top 1 [Id] from [smd].[Demographic_Ranges] dr where dr.Id = 11),9.70,12.00,45.60,54.40, 'None';
insert into [smd].[Social_Media_Demographics] select (select [Id] from [smd].Platform p where p.Id = 11),0.57,0,(select top 1 [Id] from [smd].[Demographic_Ranges] dr where dr.Id = 11),20.40,7.10,69.40,22.60, 'None';
insert into [smd].[Social_Media_Demographics] select (select [Id] from [smd].Platform p where p.Id = 19),0.2,0,(select top 1 [Id] from [smd].[Demographic_Ranges] dr where dr.Id = 11),53.4,53.4,32.60,66.30, 'None';
insert into [smd].[Social_Media_Demographics] select (select [Id] from [smd].Platform p where p.Id = 1),0.965,0,(select top 1 [Id] from [smd].[Demographic_Ranges] dr where dr.Id = 11),13.20,19.30,44.50,55.50, 'None';
insert into [smd].[Social_Media_Demographics] select (select [Id] from [smd].Platform p where p.Id = 24),0.4,0,(select top 1 [Id] from [smd].[Demographic_Ranges] dr where dr.Id = 11),32.5,32.5,43,57,'Skews male highly educated audience. is a key demographic';
insert into [smd].[Social_Media_Demographics] select (select [Id] from [smd].Platform p where p.Id = 25),0.82,0,(select top 1 [Id] from [smd].[Demographic_Ranges] dr where dr.Id = 11),29.66,29.66,52.4,47.6, 'None';
insert into [smd].[Social_Media_Demographics] select (select [Id] from [smd].Platform p where p.Id = 13),1,0,(select top 1 [Id] from [smd].[Demographic_Ranges] dr where dr.Id = 12),53.2,53.2,42,58, 'None';
insert into [smd].[Social_Media_Demographics] select (select [Id] from [smd].Platform p where p.Id = 18),0.135,0,(select top 1 [Id] from [smd].[Demographic_Ranges] dr where dr.Id = 13),11,11,50,50, 'None';
insert into [smd].[Social_Media_Demographics] select (select [Id] from [smd].Platform p where p.Id = 21),0.178,0,(select top 1 [Id] from [smd].[Demographic_Ranges] dr where dr.Id = 14),8.40, 0,53.3,46.7, 'None';
insert into [smd].[Social_Media_Demographics] select (select [Id] from [smd].Platform p where p.Id = 23),0.24,0,(select top 1 [Id] from [smd].[Demographic_Ranges] dr where dr.Id = 15),34,34,37,63,'None';
insert into [smd].[Social_Media_Demographics] select (select [Id] from [smd].Platform p where p.Id = 4),3,0,(select top 1 [Id] from [smd].[Demographic_Ranges] dr where dr.Id = 16),30,30,47.20,52.80, 'Heavily used globally for messaging. Slightly more male users';
insert into [smd].[Social_Media_Demographics] select (select [Id] from [smd].Platform p where p.Id = 21),0.178,0,(select top 1 [Id] from [smd].[Demographic_Ranges] dr where dr.Id = 17),8.90, 0,53.3,46.7, 'None';
insert into [smd].[Social_Media_Demographics] select (select [Id] from [smd].Platform p where p.Id = 1),3.07,0,(select top 1 [Id] from [smd].[Demographic_Ranges] dr where dr.Id = 18),8.60,11.60,43.20,56.80, 'None';
insert into [smd].[Social_Media_Demographics] select (select [Id] from [smd].Platform p where p.Id = 3),2,0,(select top 1 [Id] from [smd].[Demographic_Ranges] dr where dr.Id = 18),16.40,16.40,49.40,50.60, 'None';
insert into [smd].[Social_Media_Demographics] select (select [Id] from [smd].Platform p where p.Id = 9),1.15,0,(select top 1 [Id] from [smd].[Demographic_Ranges] dr where dr.Id = 18),0,0,43.60,56.40, 'None';
insert into [smd].[Social_Media_Demographics] select (select [Id] from [smd].Platform p where p.Id = 10),2.7,0,(select top 1 [Id] from [smd].[Demographic_Ranges] dr where dr.Id = 18),8.40,10.10,45.60,54.40, 'None';
insert into [smd].[Social_Media_Demographics] select (select [Id] from [smd].Platform p where p.Id = 11),0.57,0,(select top 1 [Id] from [smd].[Demographic_Ranges] dr where dr.Id = 18),12.20,3.50,69.40,22.60, 'None';
insert into [smd].[Social_Media_Demographics] select (select [Id] from [smd].Platform p where p.Id = 1),0.965,0,(select top 1 [Id] from [smd].[Demographic_Ranges] dr where dr.Id = 18),9.50,12.00,44.50,55.50, 'None';
insert into [smd].[Social_Media_Demographics] select (select [Id] from [smd].Platform p where p.Id = 8),0.85,0,(select top 1 [Id] from [smd].[Demographic_Ranges] dr where dr.Id = 29),14.30,14.30,49.00,49.20, 'None';
insert into [smd].[Social_Media_Demographics] select (select [Id] from [smd].Platform p where p.Id = 13),1,0,(select top 1 [Id] from [smd].[Demographic_Ranges] dr where dr.Id = 21),21.6,21.6,42,58,'None';
insert into [smd].[Social_Media_Demographics] select (select [Id] from [smd].Platform p where p.Id = 5),0.275,0,(select top 1 [Id] from [smd].[Demographic_Ranges] dr where dr.Id = 21),2,3,32,68,'Lowest usage';
insert into [smd].[Social_Media_Demographics] select (select [Id] from [smd].Platform p where p.Id = 1),3.07,0,(select top 1 [Id] from [smd].[Demographic_Ranges] dr where dr.Id = 23),5.50,6.50,43.20,56.80, 'None';
insert into [smd].[Social_Media_Demographics] select (select [Id] from [smd].Platform p where p.Id = 3),2,0,(select top 1 [Id] from [smd].[Demographic_Ranges] dr where dr.Id = 23),9.00,9.00,49.40,50.60, 'None';
insert into [smd].[Social_Media_Demographics] select (select [Id] from [smd].Platform p where p.Id = 9),1.15,0,(select top 1 [Id] from [smd].[Demographic_Ranges] dr where dr.Id = 23),0,0,43.60,56.40, 'None';
insert into [smd].[Social_Media_Demographics] select (select [Id] from [smd].Platform p where p.Id = 10),2.7,0,(select top 1 [Id] from [smd].[Demographic_Ranges] dr where dr.Id = 23),6.40,7.60,45.60,54.40, 'None';
insert into [smd].[Social_Media_Demographics] select (select [Id] from [smd].Platform p where p.Id = 11),0.57,0,(select top 1 [Id] from [smd].[Demographic_Ranges] dr where dr.Id = 23),8.10,2.40,69.40,22.60, 'None';
insert into [smd].[Social_Media_Demographics] select (select [Id] from [smd].Platform p where p.Id = 1),0.965,0,(select top 1 [Id] from [smd].[Demographic_Ranges] dr where dr.Id = 23),6.20,6.50,44.50,55.50, 'None';
insert into [smd].[Social_Media_Demographics] select (select [Id] from [smd].Platform p where p.Id = 8),0.85,0,(select top 1 [Id] from [smd].[Demographic_Ranges] dr where dr.Id = 24),3.80,3.80,49.00,49.20, 'None';
insert into [smd].[Social_Media_Demographics] select (select [Id] from [smd].Platform p where p.Id = 16),1.39,0,(select top 1 [Id] from [smd].[Demographic_Ranges] dr where dr.Id = 26),22.7,22.7,48,52, 'None';
insert into [smd].[Social_Media_Demographics] select (select [Id] from [smd].Platform p where p.Id = 1),3.07,0,(select top 1 [Id] from [smd].[Demographic_Ranges] dr where dr.Id = 29),3.80,3.80,43.20,56.80, 'None';
insert into [smd].[Social_Media_Demographics] select (select [Id] from [smd].Platform p where p.Id = 3),2,0,(select top 1 [Id] from [smd].[Demographic_Ranges] dr where dr.Id = 29),4.80,4.80,49.40,50.60, 'None';
insert into [smd].[Social_Media_Demographics] select (select [Id] from [smd].Platform p where p.Id = 10),2.7,0,(select top 1 [Id] from [smd].[Demographic_Ranges] dr where dr.Id = 29),4.70,5.20,45.60,54.40, 'None';
insert into [smd].[Social_Media_Demographics] select (select [Id] from [smd].Platform p where p.Id = 11),0.57,0,(select top 1 [Id] from [smd].[Demographic_Ranges] dr where dr.Id = 29),6.10,1.70,69.40,22.60, 'None';
insert into [smd].[Social_Media_Demographics] select (select [Id] from [smd].Platform p where p.Id = 1),0.965,0,(select top 1 [Id] from [smd].[Demographic_Ranges] dr where dr.Id = 29),4.00,3.60,44.50,55.50, 'None';
insert into [smd].[Social_Media_Demographics] select (select [Id] from [smd].Platform p where p.Id = 1),3.07,0,(select top 1 [Id] from [smd].[Demographic_Ranges] dr where dr.Id = 31),3.20,2.90,43.20,56.80, 'None';
insert into [smd].[Social_Media_Demographics] select (select [Id] from [smd].Platform p where p.Id = 3),2,0,(select top 1 [Id] from [smd].[Demographic_Ranges] dr where dr.Id = 31),3.00,3.00,49.40,50.60, 'None';
insert into [smd].[Social_Media_Demographics] select (select [Id] from [smd].Platform p where p.Id = 10),2.7,0,(select top 1 [Id] from [smd].[Demographic_Ranges] dr where dr.Id = 31),4.90,4.60,45.60,54.40, 'None';
insert into [smd].[Social_Media_Demographics] select (select [Id] from [smd].Platform p where p.Id = 11),0.57,0,(select top 1 [Id] from [smd].[Demographic_Ranges] dr where dr.Id = 31),3.20,0.90,69.40,22.60, 'None';
insert into [smd].[Social_Media_Demographics] select (select [Id] from [smd].Platform p where p.Id = 1),0.965,0,(select top 1 [Id] from [smd].[Demographic_Ranges] dr where dr.Id = 31),2.70,2.20,44.50,55.50, 'None';
insert into [smd].[Social_Media_Demographics] select (select [Id] from [smd].Platform p where p.Id = 23),0.59,0,(select top 1 [Id] from [smd].[Demographic_Ranges] dr where dr.Id = 5),70,70,49.90,50.10,'Significant user base in China with many  users. Nearly balanced gender';
insert into [smd].[Social_Media_Demographics] select (select [Id] from [smd].Platform p where p.Id = 16),1.39,0,(select top 1 [Id] from [smd].[Demographic_Ranges] dr where dr.Id = 35),36,36,48,52,'Dominant in China significant users over 51. Slightly more male users globally';
insert into [smd].[Social_Media_Demographics] select (select [Id] from [smd].Platform p where p.Id = 23),0.24,0,(select top 1 [Id] from [smd].[Demographic_Ranges] dr where dr.Id = 36),73,73,37,63,'Strong male dominance especially among younger adults interested in gaming';

select * from [smd].[Social_Media_Demographics_View] smdv;

