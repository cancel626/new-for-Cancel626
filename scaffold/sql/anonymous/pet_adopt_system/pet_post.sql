create table pet_post
(
    id          int auto_increment comment '宠物经验帖子主键ID'
        primary key,
    user_id     int          null comment '用户ID，外键，关联的是用户表',
    pet_type_id int          null comment '宠物类型ID，外键，关联的是宠物类别表',
    title       varchar(50)  null comment '标题',
    cover       varchar(255) null comment '封面',
    content     text         null comment '内容',
    summary     varchar(255) null comment '摘要',
    is_audit    tinyint(1)   null comment '是否已经审核（0：未审核；1：已审核）',
    create_time datetime     null comment '创建时间'
)
    comment '宠物经验帖子信息表';

