create table evaluations_upvote
(
    id             int auto_increment comment '评论点赞表ID'
        primary key,
    user_id        int null comment '用户ID',
    evaluations_id int null comment '点赞ID'
)
    row_format = DYNAMIC;

