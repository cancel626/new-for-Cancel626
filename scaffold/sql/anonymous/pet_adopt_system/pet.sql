create table pet
(
    id           int auto_increment comment '宠物信息表主键ID'
        primary key,
    name         varchar(50)  null comment '宠物名',
    cover        varchar(255) null comment '宠物封面图',
    detail       text         null comment '宠物描述',
    address      varchar(100) null comment '宠物所在地',
    age          int          null comment '宠物年龄',
    pet_type_id  int          null comment '宠物类别ID，外键，关联的是宠物类别表',
    is_vaccine   tinyint(1)   null comment '是否已经接种疫苗（0：未接种；1：已接种）',
    is_recommend tinyint(1)   null comment '是否推荐（0：未推荐；1：已推荐）',
    is_adopt     tinyint(1)   null comment '领养状态（0：待领养；1：已领养）',
    create_time  datetime     null comment '创建时间'
)
    comment '宠物信息表';

