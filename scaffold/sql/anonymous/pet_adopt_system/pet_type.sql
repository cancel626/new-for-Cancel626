create table pet_type
(
    id   int auto_increment comment '宠物类别主键ID'
        primary key,
    name varchar(30) null comment '宠物类别名'
)
    comment '宠物类别表';

