create table pet_adopt_order
(
    id                 int auto_increment comment '宠物领养单据主键ID'
        primary key,
    user_id            int          null comment '用户ID，外键，关联用户表，标识的是谁产生的订单数据',
    pet_id             int          null comment '宠物ID，外键，关联的是宠物表，标识的是哪只宠物被申请领养的',
    address_id         int          null comment '收货地址ID，外键，关联的是收货地址表',
    detail             text         null comment '领养描述',
    status             tinyint(1)   null comment '单据状态（1：申请中；2：已审核；3：审核未通过；4：已完成）',
    audit_error_detail varchar(255) null comment '审核不通过原因备注',
    is_again_post      tinyint      null comment '是否是再次提交（0：初次提交；1：再次提交）',
    post_number        tinyint(1)   null comment '提交次数',
    create_time        datetime     null comment '创建时间'
)
    comment '宠物领养单据信息表';

