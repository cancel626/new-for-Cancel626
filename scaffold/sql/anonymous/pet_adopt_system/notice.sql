create table notice
(
    id          int auto_increment comment '公告表主键ID'
        primary key,
    title       varchar(50) null comment '公告标题',
    content     text        null comment '公告内容',
    create_time datetime    null comment '创建时间'
)
    comment '公告信息表';

