create table user
(
    id          int unsigned auto_increment comment '用户编号'
        primary key,
    account     varchar(50)  null comment '用户账号',
    username    varchar(50)  null comment '用户昵称',
    password    varchar(100) null comment '用户密码',
    avatar      text         null comment '用户头像',
    email       varchar(50)  null comment '用户邮箱',
    role        int          null comment '用户角色',
    gender      tinyint(1)   null comment '性别：1-女；2-男；',
    birthday    date         null comment '生日',
    phone       varchar(255) null comment '手机号',
    create_time datetime     null comment '用户注册时间'
)
    collate = utf8mb4_general_ci
    row_format = DYNAMIC;

