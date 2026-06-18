create table active_net
(
    id           int auto_increment comment '行为信息表主键ID'
        primary key,
    user_id      int         null comment '用户ID，外键，关联的是用户表',
    content_id   int         null comment '内容ID',
    type         tinyint(1)  null comment '交互行为（1：浏览；2：点赞；3：收藏）',
    create_time  datetime    null comment '创建时间',
    content_type varchar(30) null comment '内容模块，标识的是该互动类型属于什么模块'
)
    comment '行为互动信息表';

