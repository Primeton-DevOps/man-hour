
drop table if exists RD_CALENDAR;

drop table if exists RD_TASKLIST;

drop table if exists RD_LABOR_DETAIL;

drop table if exists RD_PLAN;

drop table if exists RD_WORKLIST;

drop table if exists RD_EMP_PROJ;

drop table if exists RD_PROJECT;

drop table if exists RD_CODE_PACK;

drop table if exists RD_DEV_MODULE;

drop table if exists RD_COM_MODULE;

drop table if exists RD_PROD_MODULE;

drop table if exists RD_PROD_COM;

drop table if exists RD_MODULE;

drop table if exists RD_PROD_VER;

drop table if exists RD_PRODUCT;

drop table if exists RD_COMPONENT;

drop table if exists RD_FINANCE_UNIT;


/*==============================================================*/
/* Table: RD_CALENDAR                                           */
/*==============================================================*/
create table RD_CALENDAR
(
   CALENDAR_ID          varchar(10) not null,
   IS_WORK              char(1) not null,
   HOURS                int not null,
   primary key (CALENDAR_ID)
);

/*==============================================================*/
/* Table: RD_CODE_PACK                                          */
/*==============================================================*/
create table RD_CODE_PACK
(
   PACKAGE_ID           numeric(18,0) not null,
   MODULE_ID            numeric(18,0),
   PACK_NAME            varchar(128),
   CVS_PATH             varchar(128),
   primary key (PACKAGE_ID)
);

/*==============================================================*/
/* Table: RD_COMPONENT                                          */
/*==============================================================*/
create table RD_COMPONENT
(
   COMPONENT_ID         numeric(18,0) not null,
   COMPONENT_NAME       varchar(64) not null,
   COMPONENT_TYPE       varchar(32),
   CURRENT_VER          varchar(20),
   primary key (COMPONENT_ID)
);

/*==============================================================*/
/* Table: RD_COM_MODULE                                         */
/*==============================================================*/
create table RD_COM_MODULE
(
   COMPONENT_ID         numeric(18,0),
   MODULE_ID            numeric(18,0)
);

/*==============================================================*/
/* Table: RD_DEV_MODULE                                         */
/*==============================================================*/
create table RD_DEV_MODULE
(
   DEV_MODULE_ID        numeric(18,0) not null,
   PROD_VER_ID          numeric(18,0),
   MODULE_ID            numeric(18,0),
   VERSION              varchar(32),
   BRANCH               varchar(32),
   TAG                  varchar(32),
   primary key (DEV_MODULE_ID)
);

/*==============================================================*/
/* Table: RD_EMP_PROJ                                           */
/*==============================================================*/
create table RD_EMP_PROJ
(
   PROJECT_ID           numeric(18,0) not null comment '项目编号',
   USERID               varchar(32) not null,
   BEGIN_DATE           date,
   END_DATE             date,
   PROJ_ROLE            varchar(10),
   primary key (PROJECT_ID, USERID)
);

/*==============================================================*/
/* Table: RD_FINANCE_UNIT                                       */
/*==============================================================*/
create table RD_FINANCE_UNIT
(
   FIN_UNIT_ID          numeric(18,0) not null comment '财务核算单位编号',
   FIN_UNIT_NAME        varchar(32) not null comment '财务核算单位名称',
   primary key (FIN_UNIT_ID)
);

alter table RD_FINANCE_UNIT comment '财务核算单位';

/*==============================================================*/
/* Table: RD_LABOR_DETAIL                                       */
/*==============================================================*/
create table RD_LABOR_DETAIL
(
   LABOR_DETAIL_ID      numeric(18,0) not null,
   LABOR_DATE           date not null,
   WORKLIST_ID          numeric(18,0),
   TASKLIST             varchar(32),
   TASKNAME             varchar(200),
   USER_ID              varchar(32) not null,
   PROJECT_ID           numeric(18,0) comment '项目编号',
   ACT_HOURS            numeric(9,2),
   STD_HOURS            numeric(9,2),
   REP_CONTENT          varchar(4000),
   IS_CLOSE             varchar(10),
   SALES_NAME           varchar(32),
   primary key (LABOR_DETAIL_ID)
);

/*==============================================================*/
/* Table: RD_MODULE                                             */
/*==============================================================*/
create table RD_MODULE
(
   MODULE_ID            numeric(18,0) not null,
   MODULE_NAME          varchar(128),
   MOD_TYPE             varchar(32),
   TECH_TYPE            varchar(32),
   CVS_PATH             varchar(128),
   primary key (MODULE_ID)
);

/*==============================================================*/
/* Table: RD_PLAN                                               */
/*==============================================================*/
create table RD_PLAN
(
   PLAN_ID              numeric(18,0) not null,
   PROJECT_ID           numeric(18,0) not null comment '项目编号',
   WORKLIST_ID          numeric(18,0),
   TASKLIST             varchar(32),
   COMPOSITE_NAME       varchar(500) not null,
   WORKLIST_USER_ID     varchar(32),
   USER_NAME            varchar(128),
   PLAN_START_DAY       datetime,
   START_DAY            datetime,
   ACT_EFFORT           numeric(4,1),
   primary key (PLAN_ID)
);

/*==============================================================*/
/* Table: RD_PRODUCT                                            */
/*==============================================================*/
create table RD_PRODUCT
(
   PRODUCT_ID           varchar(32) not null comment '产品编号',
   PRODUCT_NAME         varchar(64) not null,
   primary key (PRODUCT_ID)
);

alter table RD_PRODUCT comment '产品';

/*==============================================================*/
/* Table: RD_PROD_COM                                           */
/*==============================================================*/
create table RD_PROD_COM
(
   PRODUCT_ID           varchar(32) comment '产品编号',
   COMPONENT_ID         numeric(18,0)
);

/*==============================================================*/
/* Table: RD_PROD_MODULE                                        */
/*==============================================================*/
create table RD_PROD_MODULE
(
   PRODUCT_ID           varchar(32) comment '产品编号',
   MODULE_ID            numeric(18,0)
);

/*==============================================================*/
/* Table: RD_PROD_VER                                           */
/*==============================================================*/
create table RD_PROD_VER
(
   PROD_VER_ID          numeric(18,0) not null,
   PRODUCT_ID           varchar(32) comment '产品编号',
   PROD_VER_NAME        varchar(64) not null,
   VER_NO               varchar(32) not null,
   RELEASE_DATE         date,
   primary key (PROD_VER_ID)
);

/*==============================================================*/
/* Table: RD_PROJECT                                            */
/*==============================================================*/
create table RD_PROJECT
(
   PROJECT_ID           numeric(18,0) not null comment '项目编号',
   PROD_VER_ID          numeric(18,0),
   FIN_UNIT_ID          numeric(18,0) comment '财务核算单位编号',
   PROJECT_NAME         varchar(100),
   PROJECT_TYPE         varchar(10) comment '项目类型',
   IS_TEMPLATE          char(1),
   IS_PUBLIC            char(1) default 'N',
   PROJECT_STATUS       char(1),
   primary key (PROJECT_ID)
);

alter table RD_PROJECT comment '项目';

/*==============================================================*/
/* Table: RD_TASKLIST                                           */
/*==============================================================*/
create table RD_TASKLIST
(
   TASKLIST             varchar(32) not null,
   TASKNAME             varchar(64) not null,
   WORK_TYPE            varchar(32),
   TASK_TYPE            varchar(32),
   primary key (TASKLIST)
);

/*==============================================================*/
/* Table: RD_WORKLIST                                           */
/*==============================================================*/
create table RD_WORKLIST
(
   WORKLIST_ID          numeric(18,0) not null,
   WORKLIST_NAME        varchar(1024) not null,
   PROJECT_ID           numeric(18,0),
   PARENT_WORKLIST_ID   numeric(18,0),
   WORK_TYPE            varchar(32),
   PRIORITY             int,
   WORKLIST_SEQ         varchar(2048) not null,
   DEV_MODULE_ID        numeric(18,0),
   primary key (WORKLIST_ID)
);

/*
alter table RD_CODE_PACK add constraint FK_Reference_20 foreign key (MODULE_ID)
      references RD_MODULE (MODULE_ID) on delete restrict on update restrict;

alter table RD_COM_MODULE add constraint FK_Reference_27 foreign key (COMPONENT_ID)
      references RD_COMPONENT (COMPONENT_ID) on delete restrict on update restrict;

alter table RD_COM_MODULE add constraint FK_Reference_28 foreign key (MODULE_ID)
      references RD_MODULE (MODULE_ID) on delete restrict on update restrict;

alter table RD_DEV_MODULE add constraint FK_Reference_16 foreign key (PROD_VER_ID)
      references RD_PROD_VER (PROD_VER_ID) on delete restrict on update restrict;

alter table RD_DEV_MODULE add constraint FK_Reference_17 foreign key (MODULE_ID)
      references RD_MODULE (MODULE_ID) on delete restrict on update restrict;

alter table RD_EMP_PROJ add constraint FK_Reference_8 foreign key (PROJECT_ID)
      references RD_PROJECT (PROJECT_ID) on delete restrict on update restrict;

alter table RD_LABOR_DETAIL add constraint FK_Reference_13 foreign key (WORKLIST_ID)
      references RD_WORKLIST (WORKLIST_ID) on delete restrict on update restrict;

alter table RD_PLAN add constraint FK_Reference_14 foreign key (PROJECT_ID)
      references RD_PROJECT (PROJECT_ID) on delete restrict on update restrict;

alter table RD_PLAN add constraint FK_Reference_15 foreign key (WORKLIST_ID)
      references RD_WORKLIST (WORKLIST_ID) on delete restrict on update restrict;

alter table RD_PROD_COM add constraint FK_Reference_19 foreign key (PRODUCT_ID)
      references RD_PRODUCT (PRODUCT_ID) on delete restrict on update restrict;

alter table RD_PROD_COM add constraint FK_Reference_21 foreign key (COMPONENT_ID)
      references RD_COMPONENT (COMPONENT_ID) on delete restrict on update restrict;

alter table RD_PROD_MODULE add constraint FK_Reference_29 foreign key (PRODUCT_ID)
      references RD_PRODUCT (PRODUCT_ID) on delete restrict on update restrict;

alter table RD_PROD_MODULE add constraint FK_Reference_30 foreign key (MODULE_ID)
      references RD_MODULE (MODULE_ID) on delete restrict on update restrict;

alter table RD_PROD_VER add constraint FK_Reference_10 foreign key (PRODUCT_ID)
      references RD_PRODUCT (PRODUCT_ID) on delete restrict on update restrict;

alter table RD_PROJECT add constraint FK_Reference_11 foreign key (PROD_VER_ID)
      references RD_PROD_VER (PROD_VER_ID) on delete restrict on update restrict;

alter table RD_PROJECT add constraint FK_Reference_18 foreign key (FIN_UNIT_ID)
      references RD_FINANCE_UNIT (FIN_UNIT_ID) on delete restrict on update restrict;

alter table RD_WORKLIST add constraint FK_Reference_1 foreign key (PROJECT_ID)
      references RD_PROJECT (PROJECT_ID) on delete restrict on update restrict;
*/