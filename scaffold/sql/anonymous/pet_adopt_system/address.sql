create table address
(
    id           int auto_increment comment '收货地址主键ID'
        primary key,
    user_id      int          null comment '用户ID，外键，关联的是用户表，标识这条收货地址信息是谁配置的',
    detail       varchar(100) null comment '详细地址',
    addressee    varchar(50)  null comment '收件人',
    concat_phone varchar(20)  null comment '收件电话',
    is_default   tinyint(1)   null comment '是否是默认地址（0：非默认；1：默认地址）',
    create_time  datetime     null comment '创建时间'
)
    comment '收货地址信息表';

