create table proposal_feedback
(
    id            int auto_increment comment '建议与反馈表主键'
        primary key,
    user_id       int          null comment '用户ID，外键，关联的是用户表',
    detail        varchar(255) null comment '描述',
    is_reply      tinyint(1)   null comment '是否回复（0：未回复；1：已回复）',
    reply_content varchar(255) null comment '回复内容',
    is_top        tinyint(1)   null comment '是否是精华贴（0：否；1：是）',
    create_time   datetime     null comment '创建时间',
    reply_time    datetime     null comment '回复时间'
)
    comment '建议与反馈信息表';

