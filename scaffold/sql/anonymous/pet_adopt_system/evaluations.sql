create table evaluations
(
    id           int unsigned auto_increment comment '主键'
        primary key,
    parent_id    int          null comment '父级评论ID',
    commenter_id int          null comment '评论者ID',
    replier_id   int          null comment '回复者ID',
    content_type varchar(100) null comment '内容类型',
    content_id   int          null comment '内容ID',
    content      varchar(255) null comment '评论内容',
    create_time  datetime     null comment '评论时间'
)
    row_format = DYNAMIC;

