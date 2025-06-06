-- Drop existing tables if they exist
DROP TABLE IF EXISTS member_notification;
DROP TABLE IF EXISTS notification;
DROP TABLE IF EXISTS role_account;
DROP TABLE IF EXISTS token;
DROP TABLE IF EXISTS account;
DROP TABLE IF EXISTS role;
DROP TABLE IF EXISTS family_member;
DROP TABLE IF EXISTS family;

-- Create tables in correct order
CREATE TABLE role (
    role_id BIGINT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL UNIQUE,
    created_at DATETIME,
    created_by VARCHAR(255),
    updated_at DATETIME,
    updated_by VARCHAR(255)
) ENGINE=InnoDB;

CREATE TABLE account (
    account_id BIGINT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(255) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    full_name VARCHAR(255),
    email VARCHAR(255),
    phone VARCHAR(255),
    created_at DATETIME,
    created_by VARCHAR(255),
    updated_at DATETIME,
    updated_by VARCHAR(255)
) ENGINE=InnoDB;

CREATE TABLE role_account (
    account_id BIGINT NOT NULL,
    role_id BIGINT NOT NULL,
    created_at DATETIME,
    created_by VARCHAR(255),
    updated_at DATETIME,
    updated_by VARCHAR(255),
    PRIMARY KEY (account_id, role_id),
    CONSTRAINT fk_role_account_account FOREIGN KEY (account_id) REFERENCES account(account_id) ON DELETE CASCADE,
    CONSTRAINT fk_role_account_role FOREIGN KEY (role_id) REFERENCES role(role_id) ON DELETE CASCADE
) ENGINE=InnoDB;

CREATE TABLE token (
    token_id BIGINT AUTO_INCREMENT PRIMARY KEY,
    token VARCHAR(255) NOT NULL UNIQUE,
    token_type VARCHAR(255),
    revoked BOOLEAN,
    expiry_date DATETIME,
    account_id BIGINT,
    created_at DATETIME,
    created_by VARCHAR(255),
    updated_at DATETIME,
    updated_by VARCHAR(255),
    CONSTRAINT fk_token_account FOREIGN KEY (account_id) REFERENCES account(account_id) ON DELETE CASCADE
) ENGINE=InnoDB;

CREATE TABLE family (
    family_id BIGINT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255),
    created_at DATETIME,
    created_by VARCHAR(255),
    updated_at DATETIME,
    updated_by VARCHAR(255)
) ENGINE=InnoDB;

CREATE TABLE family_member (
    member_id BIGINT AUTO_INCREMENT PRIMARY KEY,
    full_name VARCHAR(255),
    date_of_birth VARCHAR(255),
    gender VARCHAR(255),
    phone VARCHAR(255),
    email VARCHAR(255),
    address TEXT,
    family_id BIGINT,
    father_id INTEGER,
    mother_id INTEGER,
    generation VARCHAR(255),
    role_family VARCHAR(255),
    birth_date DATE,
    date_of_death DATE,
    life_status VARCHAR(255),
    grave_site VARCHAR(255),
    created_at DATETIME,
    created_by VARCHAR(255),
    updated_at DATETIME,
    updated_by VARCHAR(255),
    CONSTRAINT fk_family_member_family FOREIGN KEY (family_id) REFERENCES family(family_id) ON DELETE CASCADE
) ENGINE=InnoDB;

CREATE TABLE notification (
    notification_id BIGINT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(200) NOT NULL,
    content TEXT,
    type VARCHAR(50),
    status VARCHAR(20),
    created_at DATETIME,
    created_by VARCHAR(255),
    updated_at DATETIME,
    updated_by VARCHAR(255)
) ENGINE=InnoDB;

CREATE TABLE member_notification (
    member_id BIGINT NOT NULL,
    notification_id BIGINT NOT NULL,
    created_at DATETIME,
    created_by VARCHAR(255),
    updated_at DATETIME,
    updated_by VARCHAR(255),
    PRIMARY KEY (member_id, notification_id),
    CONSTRAINT fk_member_notification_member FOREIGN KEY (member_id) REFERENCES family_member(member_id) ON DELETE CASCADE,
    CONSTRAINT fk_member_notification_notification FOREIGN KEY (notification_id) REFERENCES notification(notification_id) ON DELETE CASCADE
) ENGINE=InnoDB; 
    create table `account` (
        `account_id` bigint not null auto_increment,
        `created_at` datetime(6) not null,
        `updated_at` datetime(6),
        `created_by` varchar(255),
        `email` varchar(255),
        `full_name` varchar(255),
        `password` varchar(255) not null,
        `phone` varchar(255),
        `updated_by` varchar(255),
        `username` varchar(255) not null,
        primary key (`account_id`)
    ) engine=InnoDB;

    create table `contact` (
        `contact_id` bigint not null auto_increment,
        `created_at` datetime(6) not null,
        `member_id` bigint,
        `updated_at` datetime(6),
        `address` varchar(255),
        `created_by` varchar(255),
        `email` varchar(255),
        `phone` varchar(255),
        `updated_by` varchar(255),
        `zalo` varchar(255),
        primary key (`contact_id`)
    ) engine=InnoDB;

    create table `family` (
        `created_at` datetime(6) not null,
        `family_id` bigint not null auto_increment,
        `updated_at` datetime(6),
        `created_by` varchar(255),
        `name` varchar(255),
        `updated_by` varchar(255),
        primary key (`family_id`)
    ) engine=InnoDB;

    create table `family_event` (
        `end_date` date,
        `start_date` date,
        `created_at` datetime(6) not null,
        `event_id` bigint not null auto_increment,
        `updated_at` datetime(6),
        `created_by` varchar(255),
        `description` TEXT,
        `event_name` varchar(255),
        `place` varchar(255),
        `status` varchar(255),
        `updated_by` varchar(255),
        primary key (`event_id`)
    ) engine=InnoDB;

    create table `family_history` (
        `end_date` date,
        `start_date` date,
        `created_at` datetime(6) not null,
        `history_id` bigint not null auto_increment,
        `updated_at` datetime(6),
        `created_by` varchar(255),
        `description` TEXT,
        `updated_by` varchar(255),
        primary key (`history_id`)
    ) engine=InnoDB;

    create table `family_member` (
        `birth_date` date,
        `date_of_death` date,
        `father_id` integer,
        `mother_id` integer,
        `account_id` bigint,
        `created_at` datetime(6) not null,
        `family_id` bigint,
        `member_id` bigint not null auto_increment,
        `updated_at` datetime(6),
        `address` TEXT,
        `created_by` varchar(255),
        `full_name` varchar(255),
        `gender` varchar(255),
        `generation` varchar(255),
        `grave_site` varchar(255),
        `life_status` varchar(255),
        `role_family` varchar(255),
        `updated_by` varchar(255),
        primary key (`member_id`)
    ) engine=InnoDB;

    create table `marriage` (
        `created_at` datetime(6) not null,
        `husband_id` bigint,
        `marriage_id` bigint not null auto_increment,
        `updated_at` datetime(6),
        `wife_id` bigint,
        `created_by` varchar(255),
        `updated_by` varchar(255),
        primary key (`marriage_id`)
    ) engine=InnoDB;

    create table `member_event` (
        `is_going` bit,
        `created_at` datetime(6) not null,
        `event_id` bigint not null,
        `member_id` bigint not null,
        `updated_at` datetime(6),
        `created_by` varchar(255),
        `updated_by` varchar(255),
        primary key (`event_id`, `member_id`)
    ) engine=InnoDB;

    create table `member_notification` (
        `created_at` datetime(6) not null,
        `member_id` bigint not null,
        `notification_id` bigint not null,
        `updated_at` datetime(6),
        `created_by` varchar(255),
        `updated_by` varchar(255),
        primary key (`member_id`, `notification_id`)
    ) engine=InnoDB;

    create table `merit` (
        `amount` decimal(10,2),
        `merit_date` date,
        `created_at` datetime(6) not null,
        `member_id` bigint,
        `merit_event_id` bigint,
        `merit_id` bigint not null auto_increment,
        `merit_type_id` bigint,
        `payer_member_id` bigint,
        `updated_at` datetime(6),
        `created_by` varchar(255),
        `description` TEXT,
        `payment_status` varchar(255),
        `qr_code_url` varchar(255),
        `updated_by` varchar(255),
        primary key (`merit_id`)
    ) engine=InnoDB;

    create table `merit_banking_info` (
        `created_at` datetime(6) not null,
        `merit_banking_info_id` bigint not null auto_increment,
        `merit_id` bigint,
        `updated_at` datetime(6),
        `account_number` varchar(255),
        `bank_name` varchar(255),
        `created_by` varchar(255),
        `note` TEXT,
        `updated_by` varchar(255),
        primary key (`merit_banking_info_id`)
    ) engine=InnoDB;

    create table `merit_event` (
        `end_date` date,
        `start_date` date,
        `created_at` datetime(6) not null,
        `merit_event_id` bigint not null auto_increment,
        `updated_at` datetime(6),
        `created_by` varchar(255),
        `description` TEXT,
        `updated_by` varchar(255),
        primary key (`merit_event_id`)
    ) engine=InnoDB;

    create table `merit_spending` (
        `amount` decimal(10,2),
        `spending_date` date,
        `created_at` datetime(6) not null,
        `merit_event_id` bigint,
        `merit_id` bigint,
        `merit_spending_id` bigint not null auto_increment,
        `updated_at` datetime(6),
        `created_by` varchar(255),
        `description` TEXT,
        `updated_by` varchar(255),
        primary key (`merit_spending_id`)
    ) engine=InnoDB;

    create table `merit_type` (
        `created_at` datetime(6) not null,
        `merit_type_id` bigint not null auto_increment,
        `updated_at` datetime(6),
        `created_by` varchar(255),
        `description` TEXT,
        `merit_type_name` varchar(255),
        `updated_by` varchar(255),
        primary key (`merit_type_id`)
    ) engine=InnoDB;

    create table `notification` (
        `created_at` datetime(6) not null,
        `notification_id` bigint not null auto_increment,
        `updated_at` datetime(6),
        `status` varchar(20),
        `type` varchar(50),
        `title` varchar(200) not null,
        `content` TEXT,
        `created_by` varchar(255),
        `updated_by` varchar(255),
        primary key (`notification_id`)
    ) engine=InnoDB;

    create table `photo` (
        `album_id` bigint,
        `created_at` datetime(6) not null,
        `photo_id` bigint not null auto_increment,
        `updated_at` datetime(6),
        `created_by` varchar(255),
        `image` varchar(255),
        `updated_by` varchar(255),
        primary key (`photo_id`)
    ) engine=InnoDB;

    create table `photo_album` (
        `album_id` bigint not null auto_increment,
        `created_at` datetime(6) not null,
        `updated_at` datetime(6),
        `album_name` varchar(255),
        `background_image` varchar(255),
        `created_by` varchar(255),
        `updated_by` varchar(255),
        primary key (`album_id`)
    ) engine=InnoDB;

    create table `role` (
        `created_at` datetime(6) not null,
        `role_id` bigint not null auto_increment,
        `updated_at` datetime(6),
        `created_by` varchar(255),
        `name` varchar(255) not null,
        `updated_by` varchar(255),
        primary key (`role_id`)
    ) engine=InnoDB;

    create table `role_account` (
        `account_id` bigint not null,
        `created_at` datetime(6) not null,
        `role_id` bigint not null,
        `updated_at` datetime(6),
        `created_by` varchar(255),
        `updated_by` varchar(255),
        primary key (`account_id`, `role_id`)
    ) engine=InnoDB;

    create table `tokens` (
        `revoked` bit not null,
        `account_id` bigint,
        `created_at` datetime(6) not null,
        `expiry_date` datetime(6) not null,
        `token_id` bigint not null auto_increment,
        `updated_at` datetime(6),
        `created_by` varchar(255),
        `token` varchar(255) not null,
        `token_type` varchar(255) not null,
        `updated_by` varchar(255),
        primary key (`token_id`)
    ) engine=InnoDB;

    alter table `account` 
       add constraint UK_gex1lmaqpg0ir5g1f5eftyaa1 unique (`username`);

    alter table `family_member` 
       add constraint UK_9j58np7nvxkjsr8axoodws9wi unique (`account_id`);

    alter table `role` 
       add constraint UK_8sewwnpamngi6b1dwaa88askk unique (`name`);

    alter table `contact` 
       add constraint `FKa662284mv3v70efr9ke4e56rx` 
       foreign key (`member_id`) 
       references `family_member` (`member_id`);

    alter table `family_member` 
       add constraint `FKe036vnrpek6g9ui0s16evp7xy` 
       foreign key (`account_id`) 
       references `account` (`account_id`);

    alter table `family_member` 
       add constraint `FKefmngx5ktky2xhh7f73f74hj` 
       foreign key (`family_id`) 
       references `family` (`family_id`);

    alter table `marriage` 
       add constraint `FK3j0pdlqvtc098flmu4xdaeapq` 
       foreign key (`husband_id`) 
       references `family_member` (`member_id`);

    alter table `marriage` 
       add constraint `FKockv3umn6rc2dtwnsicuji43v` 
       foreign key (`wife_id`) 
       references `family_member` (`member_id`);

    alter table `member_event` 
       add constraint `FKmtp4tlt0bm252tsyg82ny7tgj` 
       foreign key (`event_id`) 
       references `family_event` (`event_id`);

    alter table `member_event` 
       add constraint `FKs34ysou7xmtvaaucxiiqa5cpg` 
       foreign key (`member_id`) 
       references `family_member` (`member_id`);

    alter table `member_notification` 
       add constraint `FKg5ytrmyak9k0g7qlvusgxq9vf` 
       foreign key (`member_id`) 
       references `family_member` (`member_id`);

    alter table `member_notification` 
       add constraint `FK5i6t3fj6eejtmwbjspnndouuv` 
       foreign key (`notification_id`) 
       references `notification` (`notification_id`);

    alter table `merit` 
       add constraint `FKn9eosoi2ot8ukkx7elnwkgbdt` 
       foreign key (`member_id`) 
       references `family_member` (`member_id`);

    alter table `merit` 
       add constraint `FKhwjqbofc87hwb1jtqm4jnqqaj` 
       foreign key (`merit_event_id`) 
       references `merit_event` (`merit_event_id`);

    alter table `merit` 
       add constraint `FK2mqef1vui2bowrrm5pgk6xsql` 
       foreign key (`merit_type_id`) 
       references `merit_type` (`merit_type_id`);

    alter table `merit` 
       add constraint `FKme9ismjwj5onfc93fw7dslnjj` 
       foreign key (`payer_member_id`) 
       references `family_member` (`member_id`);

    alter table `merit_banking_info` 
       add constraint `FKq5gbxw79kt68f4ylo5il39ub5` 
       foreign key (`merit_id`) 
       references `merit` (`merit_id`);

    alter table `merit_spending` 
       add constraint `FKk19vjh27pi87ijb8a561kj9dc` 
       foreign key (`merit_id`) 
       references `merit` (`merit_id`);

    alter table `merit_spending` 
       add constraint `FKt97ig3fvne50kk1y56ro6lxxa` 
       foreign key (`merit_event_id`) 
       references `merit_event` (`merit_event_id`);

    alter table `photo` 
       add constraint `FKenp8min560cfgcqgl9ix71khm` 
       foreign key (`album_id`) 
       references `photo_album` (`album_id`);

    alter table `role_account` 
       add constraint `FK9dgt8k82peg2i69sytqp5ljte` 
       foreign key (`account_id`) 
       references `account` (`account_id`);

    alter table `role_account` 
       add constraint `FKg5a7wqfh8i53yr5m2rrukliu8` 
       foreign key (`role_id`) 
       references `role` (`role_id`);

    alter table `tokens` 
       add constraint `FKgfvfh9a7k1xclvxhsckp4h9io` 
       foreign key (`account_id`) 
       references `account` (`account_id`);

    create table `account` (
        `account_id` bigint not null auto_increment,
        `created_at` datetime(6) not null,
        `updated_at` datetime(6),
        `created_by` varchar(255),
        `email` varchar(255),
        `full_name` varchar(255),
        `password` varchar(255) not null,
        `phone` varchar(255),
        `updated_by` varchar(255),
        `username` varchar(255) not null,
        primary key (`account_id`)
    ) engine=InnoDB;

    create table `contact` (
        `contact_id` bigint not null auto_increment,
        `created_at` datetime(6) not null,
        `member_id` bigint,
        `updated_at` datetime(6),
        `address` varchar(255),
        `created_by` varchar(255),
        `email` varchar(255),
        `phone` varchar(255),
        `updated_by` varchar(255),
        `zalo` varchar(255),
        primary key (`contact_id`)
    ) engine=InnoDB;

    create table `family` (
        `created_at` datetime(6) not null,
        `family_id` bigint not null auto_increment,
        `updated_at` datetime(6),
        `created_by` varchar(255),
        `name` varchar(255),
        `updated_by` varchar(255),
        primary key (`family_id`)
    ) engine=InnoDB;

    create table `family_event` (
        `end_date` date,
        `start_date` date,
        `created_at` datetime(6) not null,
        `event_id` bigint not null auto_increment,
        `updated_at` datetime(6),
        `created_by` varchar(255),
        `description` TEXT,
        `event_name` varchar(255),
        `place` varchar(255),
        `status` varchar(255),
        `updated_by` varchar(255),
        primary key (`event_id`)
    ) engine=InnoDB;

    create table `family_history` (
        `end_date` date,
        `start_date` date,
        `created_at` datetime(6) not null,
        `history_id` bigint not null auto_increment,
        `updated_at` datetime(6),
        `created_by` varchar(255),
        `description` TEXT,
        `updated_by` varchar(255),
        primary key (`history_id`)
    ) engine=InnoDB;

    create table `family_member` (
        `birth_date` date,
        `date_of_death` date,
        `father_id` integer,
        `mother_id` integer,
        `account_id` bigint,
        `created_at` datetime(6) not null,
        `family_id` bigint,
        `member_id` bigint not null auto_increment,
        `updated_at` datetime(6),
        `address` TEXT,
        `created_by` varchar(255),
        `full_name` varchar(255),
        `gender` varchar(255),
        `generation` varchar(255),
        `grave_site` varchar(255),
        `life_status` varchar(255),
        `role_family` varchar(255),
        `updated_by` varchar(255),
        primary key (`member_id`)
    ) engine=InnoDB;

    create table `marriage` (
        `created_at` datetime(6) not null,
        `husband_id` bigint,
        `marriage_id` bigint not null auto_increment,
        `updated_at` datetime(6),
        `wife_id` bigint,
        `created_by` varchar(255),
        `updated_by` varchar(255),
        primary key (`marriage_id`)
    ) engine=InnoDB;

    create table `member_event` (
        `is_going` bit,
        `created_at` datetime(6) not null,
        `event_id` bigint not null,
        `member_id` bigint not null,
        `updated_at` datetime(6),
        `created_by` varchar(255),
        `updated_by` varchar(255),
        primary key (`event_id`, `member_id`)
    ) engine=InnoDB;

    create table `member_notification` (
        `created_at` datetime(6) not null,
        `member_id` bigint not null,
        `notification_id` bigint not null,
        `updated_at` datetime(6),
        `created_by` varchar(255),
        `updated_by` varchar(255),
        primary key (`member_id`, `notification_id`)
    ) engine=InnoDB;

    create table `merit` (
        `amount` decimal(10,2),
        `merit_date` date,
        `created_at` datetime(6) not null,
        `member_id` bigint,
        `merit_event_id` bigint,
        `merit_id` bigint not null auto_increment,
        `merit_type_id` bigint,
        `payer_member_id` bigint,
        `updated_at` datetime(6),
        `created_by` varchar(255),
        `description` TEXT,
        `payment_status` varchar(255),
        `qr_code_url` varchar(255),
        `updated_by` varchar(255),
        primary key (`merit_id`)
    ) engine=InnoDB;

    create table `merit_banking_info` (
        `created_at` datetime(6) not null,
        `merit_banking_info_id` bigint not null auto_increment,
        `merit_id` bigint,
        `updated_at` datetime(6),
        `account_number` varchar(255),
        `bank_name` varchar(255),
        `created_by` varchar(255),
        `note` TEXT,
        `updated_by` varchar(255),
        primary key (`merit_banking_info_id`)
    ) engine=InnoDB;

    create table `merit_event` (
        `end_date` date,
        `start_date` date,
        `created_at` datetime(6) not null,
        `merit_event_id` bigint not null auto_increment,
        `updated_at` datetime(6),
        `created_by` varchar(255),
        `description` TEXT,
        `updated_by` varchar(255),
        primary key (`merit_event_id`)
    ) engine=InnoDB;

    create table `merit_spending` (
        `amount` decimal(10,2),
        `spending_date` date,
        `created_at` datetime(6) not null,
        `merit_event_id` bigint,
        `merit_id` bigint,
        `merit_spending_id` bigint not null auto_increment,
        `updated_at` datetime(6),
        `created_by` varchar(255),
        `description` TEXT,
        `updated_by` varchar(255),
        primary key (`merit_spending_id`)
    ) engine=InnoDB;

    create table `merit_type` (
        `created_at` datetime(6) not null,
        `merit_type_id` bigint not null auto_increment,
        `updated_at` datetime(6),
        `created_by` varchar(255),
        `description` TEXT,
        `merit_type_name` varchar(255),
        `updated_by` varchar(255),
        primary key (`merit_type_id`)
    ) engine=InnoDB;

    create table `notification` (
        `created_at` datetime(6) not null,
        `notification_id` bigint not null auto_increment,
        `updated_at` datetime(6),
        `status` varchar(20),
        `type` varchar(50),
        `title` varchar(200) not null,
        `content` TEXT,
        `created_by` varchar(255),
        `updated_by` varchar(255),
        primary key (`notification_id`)
    ) engine=InnoDB;

    create table `photo` (
        `album_id` bigint,
        `created_at` datetime(6) not null,
        `photo_id` bigint not null auto_increment,
        `updated_at` datetime(6),
        `created_by` varchar(255),
        `image` varchar(255),
        `updated_by` varchar(255),
        primary key (`photo_id`)
    ) engine=InnoDB;

    create table `photo_album` (
        `album_id` bigint not null auto_increment,
        `created_at` datetime(6) not null,
        `updated_at` datetime(6),
        `album_name` varchar(255),
        `background_image` varchar(255),
        `created_by` varchar(255),
        `updated_by` varchar(255),
        primary key (`album_id`)
    ) engine=InnoDB;

    create table `role` (
        `created_at` datetime(6) not null,
        `role_id` bigint not null auto_increment,
        `updated_at` datetime(6),
        `created_by` varchar(255),
        `name` varchar(255) not null,
        `updated_by` varchar(255),
        primary key (`role_id`)
    ) engine=InnoDB;

    create table `role_account` (
        `account_id` bigint not null,
        `created_at` datetime(6) not null,
        `role_id` bigint not null,
        `updated_at` datetime(6),
        `created_by` varchar(255),
        `updated_by` varchar(255),
        primary key (`account_id`, `role_id`)
    ) engine=InnoDB;

    create table `tokens` (
        `revoked` bit not null,
        `account_id` bigint,
        `created_at` datetime(6) not null,
        `expiry_date` datetime(6) not null,
        `token_id` bigint not null auto_increment,
        `updated_at` datetime(6),
        `created_by` varchar(255),
        `token` varchar(255) not null,
        `token_type` varchar(255) not null,
        `updated_by` varchar(255),
        primary key (`token_id`)
    ) engine=InnoDB;

    alter table `account` 
       add constraint UK_gex1lmaqpg0ir5g1f5eftyaa1 unique (`username`);

    alter table `family_member` 
       add constraint UK_9j58np7nvxkjsr8axoodws9wi unique (`account_id`);

    alter table `role` 
       add constraint UK_8sewwnpamngi6b1dwaa88askk unique (`name`);

    alter table `contact` 
       add constraint `FKa662284mv3v70efr9ke4e56rx` 
       foreign key (`member_id`) 
       references `family_member` (`member_id`);

    alter table `family_member` 
       add constraint `FKe036vnrpek6g9ui0s16evp7xy` 
       foreign key (`account_id`) 
       references `account` (`account_id`);

    alter table `family_member` 
       add constraint `FKefmngx5ktky2xhh7f73f74hj` 
       foreign key (`family_id`) 
       references `family` (`family_id`);

    alter table `marriage` 
       add constraint `FK3j0pdlqvtc098flmu4xdaeapq` 
       foreign key (`husband_id`) 
       references `family_member` (`member_id`);

    alter table `marriage` 
       add constraint `FKockv3umn6rc2dtwnsicuji43v` 
       foreign key (`wife_id`) 
       references `family_member` (`member_id`);

    alter table `member_event` 
       add constraint `FKmtp4tlt0bm252tsyg82ny7tgj` 
       foreign key (`event_id`) 
       references `family_event` (`event_id`);

    alter table `member_event` 
       add constraint `FKs34ysou7xmtvaaucxiiqa5cpg` 
       foreign key (`member_id`) 
       references `family_member` (`member_id`);

    alter table `member_notification` 
       add constraint `FKg5ytrmyak9k0g7qlvusgxq9vf` 
       foreign key (`member_id`) 
       references `family_member` (`member_id`);

    alter table `member_notification` 
       add constraint `FK5i6t3fj6eejtmwbjspnndouuv` 
       foreign key (`notification_id`) 
       references `notification` (`notification_id`);

    alter table `merit` 
       add constraint `FKn9eosoi2ot8ukkx7elnwkgbdt` 
       foreign key (`member_id`) 
       references `family_member` (`member_id`);

    alter table `merit` 
       add constraint `FKhwjqbofc87hwb1jtqm4jnqqaj` 
       foreign key (`merit_event_id`) 
       references `merit_event` (`merit_event_id`);

    alter table `merit` 
       add constraint `FK2mqef1vui2bowrrm5pgk6xsql` 
       foreign key (`merit_type_id`) 
       references `merit_type` (`merit_type_id`);

    alter table `merit` 
       add constraint `FKme9ismjwj5onfc93fw7dslnjj` 
       foreign key (`payer_member_id`) 
       references `family_member` (`member_id`);

    alter table `merit_banking_info` 
       add constraint `FKq5gbxw79kt68f4ylo5il39ub5` 
       foreign key (`merit_id`) 
       references `merit` (`merit_id`);

    alter table `merit_spending` 
       add constraint `FKk19vjh27pi87ijb8a561kj9dc` 
       foreign key (`merit_id`) 
       references `merit` (`merit_id`);

    alter table `merit_spending` 
       add constraint `FKt97ig3fvne50kk1y56ro6lxxa` 
       foreign key (`merit_event_id`) 
       references `merit_event` (`merit_event_id`);

    alter table `photo` 
       add constraint `FKenp8min560cfgcqgl9ix71khm` 
       foreign key (`album_id`) 
       references `photo_album` (`album_id`);

    alter table `role_account` 
       add constraint `FK9dgt8k82peg2i69sytqp5ljte` 
       foreign key (`account_id`) 
       references `account` (`account_id`);

    alter table `role_account` 
       add constraint `FKg5a7wqfh8i53yr5m2rrukliu8` 
       foreign key (`role_id`) 
       references `role` (`role_id`);

    alter table `tokens` 
       add constraint `FKgfvfh9a7k1xclvxhsckp4h9io` 
       foreign key (`account_id`) 
       references `account` (`account_id`);

    create table `account` (
        `account_id` bigint not null auto_increment,
        `created_at` datetime(6) not null,
        `updated_at` datetime(6),
        `created_by` varchar(255),
        `email` varchar(255),
        `full_name` varchar(255),
        `password` varchar(255) not null,
        `phone` varchar(255),
        `updated_by` varchar(255),
        `username` varchar(255) not null,
        primary key (`account_id`)
    ) engine=InnoDB;

    create table `contact` (
        `contact_id` bigint not null auto_increment,
        `created_at` datetime(6) not null,
        `member_id` bigint,
        `updated_at` datetime(6),
        `address` varchar(255),
        `created_by` varchar(255),
        `email` varchar(255),
        `phone` varchar(255),
        `updated_by` varchar(255),
        `zalo` varchar(255),
        primary key (`contact_id`)
    ) engine=InnoDB;

    create table `family` (
        `created_at` datetime(6) not null,
        `family_id` bigint not null auto_increment,
        `updated_at` datetime(6),
        `created_by` varchar(255),
        `name` varchar(255),
        `updated_by` varchar(255),
        primary key (`family_id`)
    ) engine=InnoDB;

    create table `family_event` (
        `end_date` date,
        `start_date` date,
        `created_at` datetime(6) not null,
        `event_id` bigint not null auto_increment,
        `updated_at` datetime(6),
        `created_by` varchar(255),
        `description` TEXT,
        `event_name` varchar(255),
        `place` varchar(255),
        `status` varchar(255),
        `updated_by` varchar(255),
        primary key (`event_id`)
    ) engine=InnoDB;

    create table `family_history` (
        `end_date` date,
        `start_date` date,
        `created_at` datetime(6) not null,
        `history_id` bigint not null auto_increment,
        `updated_at` datetime(6),
        `created_by` varchar(255),
        `description` TEXT,
        `updated_by` varchar(255),
        primary key (`history_id`)
    ) engine=InnoDB;

    create table `family_member` (
        `birth_date` date,
        `date_of_death` date,
        `father_id` integer,
        `mother_id` integer,
        `account_id` bigint,
        `created_at` datetime(6) not null,
        `family_id` bigint,
        `member_id` bigint not null auto_increment,
        `updated_at` datetime(6),
        `address` TEXT,
        `created_by` varchar(255),
        `full_name` varchar(255),
        `gender` varchar(255),
        `generation` varchar(255),
        `grave_site` varchar(255),
        `life_status` varchar(255),
        `role_family` varchar(255),
        `updated_by` varchar(255),
        primary key (`member_id`)
    ) engine=InnoDB;

    create table `marriage` (
        `created_at` datetime(6) not null,
        `husband_id` bigint,
        `marriage_id` bigint not null auto_increment,
        `updated_at` datetime(6),
        `wife_id` bigint,
        `created_by` varchar(255),
        `updated_by` varchar(255),
        primary key (`marriage_id`)
    ) engine=InnoDB;

    create table `member_event` (
        `is_going` bit,
        `created_at` datetime(6) not null,
        `event_id` bigint not null,
        `member_id` bigint not null,
        `updated_at` datetime(6),
        `created_by` varchar(255),
        `updated_by` varchar(255),
        primary key (`event_id`, `member_id`)
    ) engine=InnoDB;

    create table `member_notification` (
        `created_at` datetime(6) not null,
        `member_id` bigint not null,
        `notification_id` bigint not null,
        `updated_at` datetime(6),
        `created_by` varchar(255),
        `updated_by` varchar(255),
        primary key (`member_id`, `notification_id`)
    ) engine=InnoDB;

    create table `merit` (
        `amount` decimal(10,2),
        `merit_date` date,
        `created_at` datetime(6) not null,
        `member_id` bigint,
        `merit_event_id` bigint,
        `merit_id` bigint not null auto_increment,
        `merit_type_id` bigint,
        `payer_member_id` bigint,
        `updated_at` datetime(6),
        `created_by` varchar(255),
        `description` TEXT,
        `payment_status` varchar(255),
        `qr_code_url` varchar(255),
        `updated_by` varchar(255),
        primary key (`merit_id`)
    ) engine=InnoDB;

    create table `merit_banking_info` (
        `created_at` datetime(6) not null,
        `merit_banking_info_id` bigint not null auto_increment,
        `merit_id` bigint,
        `updated_at` datetime(6),
        `account_number` varchar(255),
        `bank_name` varchar(255),
        `created_by` varchar(255),
        `note` TEXT,
        `updated_by` varchar(255),
        primary key (`merit_banking_info_id`)
    ) engine=InnoDB;

    create table `merit_event` (
        `end_date` date,
        `start_date` date,
        `created_at` datetime(6) not null,
        `merit_event_id` bigint not null auto_increment,
        `updated_at` datetime(6),
        `created_by` varchar(255),
        `description` TEXT,
        `updated_by` varchar(255),
        primary key (`merit_event_id`)
    ) engine=InnoDB;

    create table `merit_spending` (
        `amount` decimal(10,2),
        `spending_date` date,
        `created_at` datetime(6) not null,
        `merit_event_id` bigint,
        `merit_id` bigint,
        `merit_spending_id` bigint not null auto_increment,
        `updated_at` datetime(6),
        `created_by` varchar(255),
        `description` TEXT,
        `updated_by` varchar(255),
        primary key (`merit_spending_id`)
    ) engine=InnoDB;

    create table `merit_type` (
        `created_at` datetime(6) not null,
        `merit_type_id` bigint not null auto_increment,
        `updated_at` datetime(6),
        `created_by` varchar(255),
        `description` TEXT,
        `merit_type_name` varchar(255),
        `updated_by` varchar(255),
        primary key (`merit_type_id`)
    ) engine=InnoDB;

    create table `notification` (
        `created_at` datetime(6) not null,
        `notification_id` bigint not null auto_increment,
        `updated_at` datetime(6),
        `status` varchar(20),
        `type` varchar(50),
        `title` varchar(200) not null,
        `content` TEXT,
        `created_by` varchar(255),
        `updated_by` varchar(255),
        primary key (`notification_id`)
    ) engine=InnoDB;

    create table `photo` (
        `album_id` bigint,
        `created_at` datetime(6) not null,
        `photo_id` bigint not null auto_increment,
        `updated_at` datetime(6),
        `created_by` varchar(255),
        `image` varchar(255),
        `updated_by` varchar(255),
        primary key (`photo_id`)
    ) engine=InnoDB;

    create table `photo_album` (
        `album_id` bigint not null auto_increment,
        `created_at` datetime(6) not null,
        `updated_at` datetime(6),
        `album_name` varchar(255),
        `background_image` varchar(255),
        `created_by` varchar(255),
        `updated_by` varchar(255),
        primary key (`album_id`)
    ) engine=InnoDB;

    create table `role` (
        `created_at` datetime(6) not null,
        `role_id` bigint not null auto_increment,
        `updated_at` datetime(6),
        `created_by` varchar(255),
        `name` varchar(255) not null,
        `updated_by` varchar(255),
        primary key (`role_id`)
    ) engine=InnoDB;

    create table `role_account` (
        `account_id` bigint not null,
        `created_at` datetime(6) not null,
        `role_id` bigint not null,
        `updated_at` datetime(6),
        `created_by` varchar(255),
        `updated_by` varchar(255),
        primary key (`account_id`, `role_id`)
    ) engine=InnoDB;

    create table `token` (
        `revoked` bit not null,
        `account_id` bigint,
        `created_at` datetime(6) not null,
        `expiry_date` datetime(6) not null,
        `token_id` bigint not null auto_increment,
        `updated_at` datetime(6),
        `created_by` varchar(255),
        `token` varchar(255) not null,
        `token_type` varchar(255) not null,
        `updated_by` varchar(255),
        primary key (`token_id`)
    ) engine=InnoDB;

    alter table `account` 
       add constraint UK_gex1lmaqpg0ir5g1f5eftyaa1 unique (`username`);

    alter table `family_member` 
       add constraint UK_9j58np7nvxkjsr8axoodws9wi unique (`account_id`);

    alter table `role` 
       add constraint UK_8sewwnpamngi6b1dwaa88askk unique (`name`);

    alter table `contact` 
       add constraint `FKa662284mv3v70efr9ke4e56rx` 
       foreign key (`member_id`) 
       references `family_member` (`member_id`);

    alter table `family_member` 
       add constraint `FKe036vnrpek6g9ui0s16evp7xy` 
       foreign key (`account_id`) 
       references `account` (`account_id`);

    alter table `family_member` 
       add constraint `FKefmngx5ktky2xhh7f73f74hj` 
       foreign key (`family_id`) 
       references `family` (`family_id`);

    alter table `marriage` 
       add constraint `FK3j0pdlqvtc098flmu4xdaeapq` 
       foreign key (`husband_id`) 
       references `family_member` (`member_id`);

    alter table `marriage` 
       add constraint `FKockv3umn6rc2dtwnsicuji43v` 
       foreign key (`wife_id`) 
       references `family_member` (`member_id`);

    alter table `member_event` 
       add constraint `FKmtp4tlt0bm252tsyg82ny7tgj` 
       foreign key (`event_id`) 
       references `family_event` (`event_id`);

    alter table `member_event` 
       add constraint `FKs34ysou7xmtvaaucxiiqa5cpg` 
       foreign key (`member_id`) 
       references `family_member` (`member_id`);

    alter table `member_notification` 
       add constraint `FKg5ytrmyak9k0g7qlvusgxq9vf` 
       foreign key (`member_id`) 
       references `family_member` (`member_id`);

    alter table `member_notification` 
       add constraint `FK5i6t3fj6eejtmwbjspnndouuv` 
       foreign key (`notification_id`) 
       references `notification` (`notification_id`);

    alter table `merit` 
       add constraint `FKn9eosoi2ot8ukkx7elnwkgbdt` 
       foreign key (`member_id`) 
       references `family_member` (`member_id`);

    alter table `merit` 
       add constraint `FKhwjqbofc87hwb1jtqm4jnqqaj` 
       foreign key (`merit_event_id`) 
       references `merit_event` (`merit_event_id`);

    alter table `merit` 
       add constraint `FK2mqef1vui2bowrrm5pgk6xsql` 
       foreign key (`merit_type_id`) 
       references `merit_type` (`merit_type_id`);

    alter table `merit` 
       add constraint `FKme9ismjwj5onfc93fw7dslnjj` 
       foreign key (`payer_member_id`) 
       references `family_member` (`member_id`);

    alter table `merit_banking_info` 
       add constraint `FKq5gbxw79kt68f4ylo5il39ub5` 
       foreign key (`merit_id`) 
       references `merit` (`merit_id`);

    alter table `merit_spending` 
       add constraint `FKk19vjh27pi87ijb8a561kj9dc` 
       foreign key (`merit_id`) 
       references `merit` (`merit_id`);

    alter table `merit_spending` 
       add constraint `FKt97ig3fvne50kk1y56ro6lxxa` 
       foreign key (`merit_event_id`) 
       references `merit_event` (`merit_event_id`);

    alter table `photo` 
       add constraint `FKenp8min560cfgcqgl9ix71khm` 
       foreign key (`album_id`) 
       references `photo_album` (`album_id`);

    alter table `role_account` 
       add constraint `FK9dgt8k82peg2i69sytqp5ljte` 
       foreign key (`account_id`) 
       references `account` (`account_id`);

    alter table `role_account` 
       add constraint `FKg5a7wqfh8i53yr5m2rrukliu8` 
       foreign key (`role_id`) 
       references `role` (`role_id`);

    alter table `token` 
       add constraint `FKf4j7i0wwlqmeaxu9fufgkopdp` 
       foreign key (`account_id`) 
       references `account` (`account_id`);

    create table `account` (
        `account_id` bigint not null auto_increment,
        `created_at` datetime(6) not null,
        `updated_at` datetime(6),
        `created_by` varchar(255),
        `email` varchar(255),
        `full_name` varchar(255),
        `password` varchar(255) not null,
        `phone` varchar(255),
        `updated_by` varchar(255),
        `username` varchar(255) not null,
        primary key (`account_id`)
    ) engine=InnoDB;

    create table `contact` (
        `contact_id` bigint not null auto_increment,
        `created_at` datetime(6) not null,
        `member_id` bigint,
        `updated_at` datetime(6),
        `address` varchar(255),
        `created_by` varchar(255),
        `email` varchar(255),
        `phone` varchar(255),
        `updated_by` varchar(255),
        `zalo` varchar(255),
        primary key (`contact_id`)
    ) engine=InnoDB;

    create table `family` (
        `created_at` datetime(6) not null,
        `family_id` bigint not null auto_increment,
        `updated_at` datetime(6),
        `created_by` varchar(255),
        `name` varchar(255),
        `updated_by` varchar(255),
        primary key (`family_id`)
    ) engine=InnoDB;

    create table `family_event` (
        `end_date` date,
        `start_date` date,
        `created_at` datetime(6) not null,
        `event_id` bigint not null auto_increment,
        `updated_at` datetime(6),
        `created_by` varchar(255),
        `description` TEXT,
        `event_name` varchar(255),
        `place` varchar(255),
        `status` varchar(255),
        `updated_by` varchar(255),
        primary key (`event_id`)
    ) engine=InnoDB;

    create table `family_history` (
        `end_date` date,
        `start_date` date,
        `created_at` datetime(6) not null,
        `history_id` bigint not null auto_increment,
        `updated_at` datetime(6),
        `created_by` varchar(255),
        `description` TEXT,
        `updated_by` varchar(255),
        primary key (`history_id`)
    ) engine=InnoDB;

    create table `family_member` (
        `birth_date` date,
        `date_of_death` date,
        `father_id` integer,
        `mother_id` integer,
        `account_id` bigint,
        `created_at` datetime(6) not null,
        `family_id` bigint,
        `member_id` bigint not null auto_increment,
        `updated_at` datetime(6),
        `address` TEXT,
        `created_by` varchar(255),
        `full_name` varchar(255),
        `gender` varchar(255),
        `generation` varchar(255),
        `grave_site` varchar(255),
        `life_status` varchar(255),
        `role_family` varchar(255),
        `updated_by` varchar(255),
        primary key (`member_id`)
    ) engine=InnoDB;

    create table `marriage` (
        `created_at` datetime(6) not null,
        `husband_id` bigint,
        `marriage_id` bigint not null auto_increment,
        `updated_at` datetime(6),
        `wife_id` bigint,
        `created_by` varchar(255),
        `updated_by` varchar(255),
        primary key (`marriage_id`)
    ) engine=InnoDB;

    create table `member_event` (
        `is_going` bit,
        `created_at` datetime(6) not null,
        `event_id` bigint not null,
        `member_id` bigint not null,
        `updated_at` datetime(6),
        `created_by` varchar(255),
        `updated_by` varchar(255),
        primary key (`event_id`, `member_id`)
    ) engine=InnoDB;

    create table `member_notification` (
        `created_at` datetime(6) not null,
        `member_id` bigint not null,
        `notification_id` bigint not null,
        `updated_at` datetime(6),
        `created_by` varchar(255),
        `updated_by` varchar(255),
        primary key (`member_id`, `notification_id`)
    ) engine=InnoDB;

    create table `merit` (
        `amount` decimal(10,2),
        `merit_date` date,
        `created_at` datetime(6) not null,
        `member_id` bigint,
        `merit_event_id` bigint,
        `merit_id` bigint not null auto_increment,
        `merit_type_id` bigint,
        `payer_member_id` bigint,
        `updated_at` datetime(6),
        `created_by` varchar(255),
        `description` TEXT,
        `payment_status` varchar(255),
        `qr_code_url` varchar(255),
        `updated_by` varchar(255),
        primary key (`merit_id`)
    ) engine=InnoDB;

    create table `merit_banking_info` (
        `created_at` datetime(6) not null,
        `merit_banking_info_id` bigint not null auto_increment,
        `merit_id` bigint,
        `updated_at` datetime(6),
        `account_number` varchar(255),
        `bank_name` varchar(255),
        `created_by` varchar(255),
        `note` TEXT,
        `updated_by` varchar(255),
        primary key (`merit_banking_info_id`)
    ) engine=InnoDB;

    create table `merit_event` (
        `end_date` date,
        `start_date` date,
        `created_at` datetime(6) not null,
        `merit_event_id` bigint not null auto_increment,
        `updated_at` datetime(6),
        `created_by` varchar(255),
        `description` TEXT,
        `updated_by` varchar(255),
        primary key (`merit_event_id`)
    ) engine=InnoDB;

    create table `merit_spending` (
        `amount` decimal(10,2),
        `spending_date` date,
        `created_at` datetime(6) not null,
        `merit_event_id` bigint,
        `merit_id` bigint,
        `merit_spending_id` bigint not null auto_increment,
        `updated_at` datetime(6),
        `created_by` varchar(255),
        `description` TEXT,
        `updated_by` varchar(255),
        primary key (`merit_spending_id`)
    ) engine=InnoDB;

    create table `merit_type` (
        `created_at` datetime(6) not null,
        `merit_type_id` bigint not null auto_increment,
        `updated_at` datetime(6),
        `created_by` varchar(255),
        `description` TEXT,
        `merit_type_name` varchar(255),
        `updated_by` varchar(255),
        primary key (`merit_type_id`)
    ) engine=InnoDB;

    create table `notification` (
        `created_at` datetime(6) not null,
        `notification_id` bigint not null auto_increment,
        `updated_at` datetime(6),
        `status` varchar(20),
        `type` varchar(50),
        `title` varchar(200) not null,
        `content` TEXT,
        `created_by` varchar(255),
        `updated_by` varchar(255),
        primary key (`notification_id`)
    ) engine=InnoDB;

    create table `photo` (
        `album_id` bigint,
        `created_at` datetime(6) not null,
        `photo_id` bigint not null auto_increment,
        `updated_at` datetime(6),
        `created_by` varchar(255),
        `image` varchar(255),
        `updated_by` varchar(255),
        primary key (`photo_id`)
    ) engine=InnoDB;

    create table `photo_album` (
        `album_id` bigint not null auto_increment,
        `created_at` datetime(6) not null,
        `updated_at` datetime(6),
        `album_name` varchar(255),
        `background_image` varchar(255),
        `created_by` varchar(255),
        `updated_by` varchar(255),
        primary key (`album_id`)
    ) engine=InnoDB;

    create table `role` (
        `created_at` datetime(6) not null,
        `role_id` bigint not null auto_increment,
        `updated_at` datetime(6),
        `created_by` varchar(255),
        `name` varchar(255) not null,
        `updated_by` varchar(255),
        primary key (`role_id`)
    ) engine=InnoDB;

    create table `role_account` (
        `account_id` bigint not null,
        `created_at` datetime(6) not null,
        `role_id` bigint not null,
        `updated_at` datetime(6),
        `created_by` varchar(255),
        `updated_by` varchar(255),
        primary key (`account_id`, `role_id`)
    ) engine=InnoDB;

    create table `token` (
        `revoked` bit not null,
        `account_id` bigint,
        `created_at` datetime(6) not null,
        `expiry_date` datetime(6) not null,
        `token_id` bigint not null auto_increment,
        `updated_at` datetime(6),
        `created_by` varchar(255),
        `token` varchar(255) not null,
        `token_type` varchar(255) not null,
        `updated_by` varchar(255),
        primary key (`token_id`)
    ) engine=InnoDB;

    alter table `account` 
       add constraint UK_gex1lmaqpg0ir5g1f5eftyaa1 unique (`username`);

    alter table `family_member` 
       add constraint UK_9j58np7nvxkjsr8axoodws9wi unique (`account_id`);

    alter table `role` 
       add constraint UK_8sewwnpamngi6b1dwaa88askk unique (`name`);

    alter table `contact` 
       add constraint `FKa662284mv3v70efr9ke4e56rx` 
       foreign key (`member_id`) 
       references `family_member` (`member_id`);

    alter table `family_member` 
       add constraint `FKe036vnrpek6g9ui0s16evp7xy` 
       foreign key (`account_id`) 
       references `account` (`account_id`);

    alter table `family_member` 
       add constraint `FKefmngx5ktky2xhh7f73f74hj` 
       foreign key (`family_id`) 
       references `family` (`family_id`);

    alter table `marriage` 
       add constraint `FK3j0pdlqvtc098flmu4xdaeapq` 
       foreign key (`husband_id`) 
       references `family_member` (`member_id`);

    alter table `marriage` 
       add constraint `FKockv3umn6rc2dtwnsicuji43v` 
       foreign key (`wife_id`) 
       references `family_member` (`member_id`);

    alter table `member_event` 
       add constraint `FKmtp4tlt0bm252tsyg82ny7tgj` 
       foreign key (`event_id`) 
       references `family_event` (`event_id`);

    alter table `member_event` 
       add constraint `FKs34ysou7xmtvaaucxiiqa5cpg` 
       foreign key (`member_id`) 
       references `family_member` (`member_id`);

    alter table `member_notification` 
       add constraint `FKg5ytrmyak9k0g7qlvusgxq9vf` 
       foreign key (`member_id`) 
       references `family_member` (`member_id`);

    alter table `member_notification` 
       add constraint `FK5i6t3fj6eejtmwbjspnndouuv` 
       foreign key (`notification_id`) 
       references `notification` (`notification_id`);

    alter table `merit` 
       add constraint `FKn9eosoi2ot8ukkx7elnwkgbdt` 
       foreign key (`member_id`) 
       references `family_member` (`member_id`);

    alter table `merit` 
       add constraint `FKhwjqbofc87hwb1jtqm4jnqqaj` 
       foreign key (`merit_event_id`) 
       references `merit_event` (`merit_event_id`);

    alter table `merit` 
       add constraint `FK2mqef1vui2bowrrm5pgk6xsql` 
       foreign key (`merit_type_id`) 
       references `merit_type` (`merit_type_id`);

    alter table `merit` 
       add constraint `FKme9ismjwj5onfc93fw7dslnjj` 
       foreign key (`payer_member_id`) 
       references `family_member` (`member_id`);

    alter table `merit_banking_info` 
       add constraint `FKq5gbxw79kt68f4ylo5il39ub5` 
       foreign key (`merit_id`) 
       references `merit` (`merit_id`);

    alter table `merit_spending` 
       add constraint `FKk19vjh27pi87ijb8a561kj9dc` 
       foreign key (`merit_id`) 
       references `merit` (`merit_id`);

    alter table `merit_spending` 
       add constraint `FKt97ig3fvne50kk1y56ro6lxxa` 
       foreign key (`merit_event_id`) 
       references `merit_event` (`merit_event_id`);

    alter table `photo` 
       add constraint `FKenp8min560cfgcqgl9ix71khm` 
       foreign key (`album_id`) 
       references `photo_album` (`album_id`);

    alter table `role_account` 
       add constraint `FK9dgt8k82peg2i69sytqp5ljte` 
       foreign key (`account_id`) 
       references `account` (`account_id`);

    alter table `role_account` 
       add constraint `FKg5a7wqfh8i53yr5m2rrukliu8` 
       foreign key (`role_id`) 
       references `role` (`role_id`);

    alter table `token` 
       add constraint `FKf4j7i0wwlqmeaxu9fufgkopdp` 
       foreign key (`account_id`) 
       references `account` (`account_id`);

    create table `account` (
        `account_id` bigint not null auto_increment,
        `created_at` datetime(6) not null,
        `updated_at` datetime(6),
        `created_by` varchar(255),
        `email` varchar(255),
        `full_name` varchar(255),
        `password` varchar(255) not null,
        `phone` varchar(255),
        `updated_by` varchar(255),
        `username` varchar(255) not null,
        primary key (`account_id`)
    ) engine=InnoDB;

    create table `contact` (
        `contact_id` bigint not null auto_increment,
        `created_at` datetime(6) not null,
        `member_id` bigint,
        `updated_at` datetime(6),
        `address` varchar(255),
        `created_by` varchar(255),
        `email` varchar(255),
        `phone` varchar(255),
        `updated_by` varchar(255),
        `zalo` varchar(255),
        primary key (`contact_id`)
    ) engine=InnoDB;

    create table `family` (
        `created_at` datetime(6) not null,
        `family_id` bigint not null auto_increment,
        `updated_at` datetime(6),
        `created_by` varchar(255),
        `name` varchar(255),
        `updated_by` varchar(255),
        primary key (`family_id`)
    ) engine=InnoDB;

    create table `family_event` (
        `end_date` date,
        `start_date` date,
        `created_at` datetime(6) not null,
        `event_id` bigint not null auto_increment,
        `updated_at` datetime(6),
        `created_by` varchar(255),
        `description` TEXT,
        `event_name` varchar(255),
        `place` varchar(255),
        `status` varchar(255),
        `updated_by` varchar(255),
        primary key (`event_id`)
    ) engine=InnoDB;

    create table `family_history` (
        `end_date` date,
        `start_date` date,
        `created_at` datetime(6) not null,
        `history_id` bigint not null auto_increment,
        `updated_at` datetime(6),
        `created_by` varchar(255),
        `description` TEXT,
        `updated_by` varchar(255),
        primary key (`history_id`)
    ) engine=InnoDB;

    create table `family_member` (
        `birth_date` date,
        `date_of_death` date,
        `father_id` integer,
        `mother_id` integer,
        `account_id` bigint,
        `created_at` datetime(6) not null,
        `family_id` bigint,
        `member_id` bigint not null auto_increment,
        `updated_at` datetime(6),
        `address` TEXT,
        `created_by` varchar(255),
        `full_name` varchar(255),
        `gender` varchar(255),
        `generation` varchar(255),
        `grave_site` varchar(255),
        `life_status` varchar(255),
        `role_family` varchar(255),
        `updated_by` varchar(255),
        primary key (`member_id`)
    ) engine=InnoDB;

    create table `marriage` (
        `created_at` datetime(6) not null,
        `husband_id` bigint,
        `marriage_id` bigint not null auto_increment,
        `updated_at` datetime(6),
        `wife_id` bigint,
        `created_by` varchar(255),
        `updated_by` varchar(255),
        primary key (`marriage_id`)
    ) engine=InnoDB;

    create table `member_event` (
        `is_going` bit,
        `created_at` datetime(6) not null,
        `event_id` bigint not null,
        `member_id` bigint not null,
        `updated_at` datetime(6),
        `created_by` varchar(255),
        `updated_by` varchar(255),
        primary key (`event_id`, `member_id`)
    ) engine=InnoDB;

    create table `member_notification` (
        `created_at` datetime(6) not null,
        `member_id` bigint not null,
        `notification_id` bigint not null,
        `updated_at` datetime(6),
        `created_by` varchar(255),
        `updated_by` varchar(255),
        primary key (`member_id`, `notification_id`)
    ) engine=InnoDB;

    create table `merit` (
        `amount` decimal(10,2),
        `merit_date` date,
        `created_at` datetime(6) not null,
        `member_id` bigint,
        `merit_event_id` bigint,
        `merit_id` bigint not null auto_increment,
        `merit_type_id` bigint,
        `payer_member_id` bigint,
        `updated_at` datetime(6),
        `created_by` varchar(255),
        `description` TEXT,
        `payment_status` varchar(255),
        `qr_code_url` varchar(255),
        `updated_by` varchar(255),
        primary key (`merit_id`)
    ) engine=InnoDB;

    create table `merit_banking_info` (
        `created_at` datetime(6) not null,
        `merit_banking_info_id` bigint not null auto_increment,
        `merit_id` bigint,
        `updated_at` datetime(6),
        `account_number` varchar(255),
        `bank_name` varchar(255),
        `created_by` varchar(255),
        `note` TEXT,
        `updated_by` varchar(255),
        primary key (`merit_banking_info_id`)
    ) engine=InnoDB;

    create table `merit_event` (
        `end_date` date,
        `start_date` date,
        `created_at` datetime(6) not null,
        `merit_event_id` bigint not null auto_increment,
        `updated_at` datetime(6),
        `created_by` varchar(255),
        `description` TEXT,
        `updated_by` varchar(255),
        primary key (`merit_event_id`)
    ) engine=InnoDB;

    create table `merit_spending` (
        `amount` decimal(10,2),
        `spending_date` date,
        `created_at` datetime(6) not null,
        `merit_event_id` bigint,
        `merit_id` bigint,
        `merit_spending_id` bigint not null auto_increment,
        `updated_at` datetime(6),
        `created_by` varchar(255),
        `description` TEXT,
        `updated_by` varchar(255),
        primary key (`merit_spending_id`)
    ) engine=InnoDB;

    create table `merit_type` (
        `created_at` datetime(6) not null,
        `merit_type_id` bigint not null auto_increment,
        `updated_at` datetime(6),
        `created_by` varchar(255),
        `description` TEXT,
        `merit_type_name` varchar(255),
        `updated_by` varchar(255),
        primary key (`merit_type_id`)
    ) engine=InnoDB;

    create table `notification` (
        `created_at` datetime(6) not null,
        `notification_id` bigint not null auto_increment,
        `updated_at` datetime(6),
        `status` varchar(20),
        `type` varchar(50),
        `title` varchar(200) not null,
        `content` TEXT,
        `created_by` varchar(255),
        `updated_by` varchar(255),
        primary key (`notification_id`)
    ) engine=InnoDB;

    create table `photo` (
        `album_id` bigint,
        `created_at` datetime(6) not null,
        `photo_id` bigint not null auto_increment,
        `updated_at` datetime(6),
        `created_by` varchar(255),
        `image` varchar(255),
        `updated_by` varchar(255),
        primary key (`photo_id`)
    ) engine=InnoDB;

    create table `photo_album` (
        `album_id` bigint not null auto_increment,
        `created_at` datetime(6) not null,
        `updated_at` datetime(6),
        `album_name` varchar(255),
        `background_image` varchar(255),
        `created_by` varchar(255),
        `updated_by` varchar(255),
        primary key (`album_id`)
    ) engine=InnoDB;

    create table `role` (
        `created_at` datetime(6) not null,
        `role_id` bigint not null auto_increment,
        `updated_at` datetime(6),
        `created_by` varchar(255),
        `name` varchar(255) not null,
        `updated_by` varchar(255),
        primary key (`role_id`)
    ) engine=InnoDB;

    create table `role_account` (
        `account_id` bigint not null,
        `created_at` datetime(6) not null,
        `role_id` bigint not null,
        `updated_at` datetime(6),
        `created_by` varchar(255),
        `updated_by` varchar(255),
        primary key (`account_id`, `role_id`)
    ) engine=InnoDB;

    create table `token` (
        `revoked` bit not null,
        `account_id` bigint,
        `created_at` datetime(6) not null,
        `expiry_date` datetime(6) not null,
        `token_id` bigint not null auto_increment,
        `updated_at` datetime(6),
        `created_by` varchar(255),
        `token` varchar(255) not null,
        `token_type` varchar(255) not null,
        `updated_by` varchar(255),
        primary key (`token_id`)
    ) engine=InnoDB;

    alter table `account` 
       add constraint UK_gex1lmaqpg0ir5g1f5eftyaa1 unique (`username`);

    alter table `family_member` 
       add constraint UK_9j58np7nvxkjsr8axoodws9wi unique (`account_id`);

    alter table `role` 
       add constraint UK_8sewwnpamngi6b1dwaa88askk unique (`name`);

    alter table `contact` 
       add constraint `FKa662284mv3v70efr9ke4e56rx` 
       foreign key (`member_id`) 
       references `family_member` (`member_id`);

    alter table `family_member` 
       add constraint `FKe036vnrpek6g9ui0s16evp7xy` 
       foreign key (`account_id`) 
       references `account` (`account_id`);

    alter table `family_member` 
       add constraint `FKefmngx5ktky2xhh7f73f74hj` 
       foreign key (`family_id`) 
       references `family` (`family_id`);

    alter table `marriage` 
       add constraint `FK3j0pdlqvtc098flmu4xdaeapq` 
       foreign key (`husband_id`) 
       references `family_member` (`member_id`);

    alter table `marriage` 
       add constraint `FKockv3umn6rc2dtwnsicuji43v` 
       foreign key (`wife_id`) 
       references `family_member` (`member_id`);

    alter table `member_event` 
       add constraint `FKmtp4tlt0bm252tsyg82ny7tgj` 
       foreign key (`event_id`) 
       references `family_event` (`event_id`);

    alter table `member_event` 
       add constraint `FKs34ysou7xmtvaaucxiiqa5cpg` 
       foreign key (`member_id`) 
       references `family_member` (`member_id`);

    alter table `member_notification` 
       add constraint `FKg5ytrmyak9k0g7qlvusgxq9vf` 
       foreign key (`member_id`) 
       references `family_member` (`member_id`);

    alter table `member_notification` 
       add constraint `FK5i6t3fj6eejtmwbjspnndouuv` 
       foreign key (`notification_id`) 
       references `notification` (`notification_id`);

    alter table `merit` 
       add constraint `FKn9eosoi2ot8ukkx7elnwkgbdt` 
       foreign key (`member_id`) 
       references `family_member` (`member_id`);

    alter table `merit` 
       add constraint `FKhwjqbofc87hwb1jtqm4jnqqaj` 
       foreign key (`merit_event_id`) 
       references `merit_event` (`merit_event_id`);

    alter table `merit` 
       add constraint `FK2mqef1vui2bowrrm5pgk6xsql` 
       foreign key (`merit_type_id`) 
       references `merit_type` (`merit_type_id`);

    alter table `merit` 
       add constraint `FKme9ismjwj5onfc93fw7dslnjj` 
       foreign key (`payer_member_id`) 
       references `family_member` (`member_id`);

    alter table `merit_banking_info` 
       add constraint `FKq5gbxw79kt68f4ylo5il39ub5` 
       foreign key (`merit_id`) 
       references `merit` (`merit_id`);

    alter table `merit_spending` 
       add constraint `FKk19vjh27pi87ijb8a561kj9dc` 
       foreign key (`merit_id`) 
       references `merit` (`merit_id`);

    alter table `merit_spending` 
       add constraint `FKt97ig3fvne50kk1y56ro6lxxa` 
       foreign key (`merit_event_id`) 
       references `merit_event` (`merit_event_id`);

    alter table `photo` 
       add constraint `FKenp8min560cfgcqgl9ix71khm` 
       foreign key (`album_id`) 
       references `photo_album` (`album_id`);

    alter table `role_account` 
       add constraint `FK9dgt8k82peg2i69sytqp5ljte` 
       foreign key (`account_id`) 
       references `account` (`account_id`);

    alter table `role_account` 
       add constraint `FKg5a7wqfh8i53yr5m2rrukliu8` 
       foreign key (`role_id`) 
       references `role` (`role_id`);

    alter table `token` 
       add constraint `FKf4j7i0wwlqmeaxu9fufgkopdp` 
       foreign key (`account_id`) 
       references `account` (`account_id`);

    create table `account` (
        `account_id` bigint not null auto_increment,
        `created_at` datetime(6) not null,
        `updated_at` datetime(6),
        `created_by` varchar(255),
        `email` varchar(255),
        `full_name` varchar(255),
        `password` varchar(255) not null,
        `phone` varchar(255),
        `updated_by` varchar(255),
        `username` varchar(255) not null,
        primary key (`account_id`)
    ) engine=InnoDB;

    create table `contact` (
        `contact_id` bigint not null auto_increment,
        `created_at` datetime(6) not null,
        `member_id` bigint,
        `updated_at` datetime(6),
        `address` varchar(255),
        `created_by` varchar(255),
        `email` varchar(255),
        `phone` varchar(255),
        `updated_by` varchar(255),
        `zalo` varchar(255),
        primary key (`contact_id`)
    ) engine=InnoDB;

    create table `family` (
        `created_at` datetime(6) not null,
        `family_id` bigint not null auto_increment,
        `updated_at` datetime(6),
        `created_by` varchar(255),
        `name` varchar(255),
        `updated_by` varchar(255),
        primary key (`family_id`)
    ) engine=InnoDB;

    create table `family_event` (
        `end_date` date,
        `start_date` date,
        `created_at` datetime(6) not null,
        `event_id` bigint not null auto_increment,
        `updated_at` datetime(6),
        `created_by` varchar(255),
        `description` TEXT,
        `event_name` varchar(255),
        `place` varchar(255),
        `status` varchar(255),
        `updated_by` varchar(255),
        primary key (`event_id`)
    ) engine=InnoDB;

    create table `family_history` (
        `end_date` date,
        `start_date` date,
        `created_at` datetime(6) not null,
        `history_id` bigint not null auto_increment,
        `updated_at` datetime(6),
        `created_by` varchar(255),
        `description` TEXT,
        `updated_by` varchar(255),
        primary key (`history_id`)
    ) engine=InnoDB;

    create table `family_member` (
        `birth_date` date,
        `date_of_death` date,
        `father_id` integer,
        `mother_id` integer,
        `account_id` bigint,
        `created_at` datetime(6) not null,
        `family_id` bigint,
        `member_id` bigint not null auto_increment,
        `updated_at` datetime(6),
        `address` TEXT,
        `created_by` varchar(255),
        `full_name` varchar(255),
        `gender` varchar(255),
        `generation` varchar(255),
        `grave_site` varchar(255),
        `life_status` varchar(255),
        `role_family` varchar(255),
        `updated_by` varchar(255),
        primary key (`member_id`)
    ) engine=InnoDB;

    create table `marriage` (
        `created_at` datetime(6) not null,
        `husband_id` bigint,
        `marriage_id` bigint not null auto_increment,
        `updated_at` datetime(6),
        `wife_id` bigint,
        `created_by` varchar(255),
        `updated_by` varchar(255),
        primary key (`marriage_id`)
    ) engine=InnoDB;

    create table `member_event` (
        `is_going` bit,
        `created_at` datetime(6) not null,
        `event_id` bigint not null,
        `member_id` bigint not null,
        `updated_at` datetime(6),
        `created_by` varchar(255),
        `updated_by` varchar(255),
        primary key (`event_id`, `member_id`)
    ) engine=InnoDB;

    create table `member_notification` (
        `created_at` datetime(6) not null,
        `member_id` bigint not null,
        `notification_id` bigint not null,
        `updated_at` datetime(6),
        `created_by` varchar(255),
        `updated_by` varchar(255),
        primary key (`member_id`, `notification_id`)
    ) engine=InnoDB;

    create table `merit` (
        `amount` decimal(10,2),
        `merit_date` date,
        `created_at` datetime(6) not null,
        `member_id` bigint,
        `merit_event_id` bigint,
        `merit_id` bigint not null auto_increment,
        `merit_type_id` bigint,
        `payer_member_id` bigint,
        `updated_at` datetime(6),
        `created_by` varchar(255),
        `description` TEXT,
        `payment_status` varchar(255),
        `qr_code_url` varchar(255),
        `updated_by` varchar(255),
        primary key (`merit_id`)
    ) engine=InnoDB;

    create table `merit_banking_info` (
        `created_at` datetime(6) not null,
        `merit_banking_info_id` bigint not null auto_increment,
        `merit_id` bigint,
        `updated_at` datetime(6),
        `account_number` varchar(255),
        `bank_name` varchar(255),
        `created_by` varchar(255),
        `note` TEXT,
        `updated_by` varchar(255),
        primary key (`merit_banking_info_id`)
    ) engine=InnoDB;

    create table `merit_event` (
        `end_date` date,
        `start_date` date,
        `created_at` datetime(6) not null,
        `merit_event_id` bigint not null auto_increment,
        `updated_at` datetime(6),
        `created_by` varchar(255),
        `description` TEXT,
        `updated_by` varchar(255),
        primary key (`merit_event_id`)
    ) engine=InnoDB;

    create table `merit_spending` (
        `amount` decimal(10,2),
        `spending_date` date,
        `created_at` datetime(6) not null,
        `merit_event_id` bigint,
        `merit_id` bigint,
        `merit_spending_id` bigint not null auto_increment,
        `updated_at` datetime(6),
        `created_by` varchar(255),
        `description` TEXT,
        `updated_by` varchar(255),
        primary key (`merit_spending_id`)
    ) engine=InnoDB;

    create table `merit_type` (
        `created_at` datetime(6) not null,
        `merit_type_id` bigint not null auto_increment,
        `updated_at` datetime(6),
        `created_by` varchar(255),
        `description` TEXT,
        `merit_type_name` varchar(255),
        `updated_by` varchar(255),
        primary key (`merit_type_id`)
    ) engine=InnoDB;

    create table `notification` (
        `created_at` datetime(6) not null,
        `notification_id` bigint not null auto_increment,
        `updated_at` datetime(6),
        `status` varchar(20),
        `type` varchar(50),
        `title` varchar(200) not null,
        `content` TEXT,
        `created_by` varchar(255),
        `updated_by` varchar(255),
        primary key (`notification_id`)
    ) engine=InnoDB;

    create table `photo` (
        `album_id` bigint,
        `created_at` datetime(6) not null,
        `photo_id` bigint not null auto_increment,
        `updated_at` datetime(6),
        `created_by` varchar(255),
        `image` varchar(255),
        `updated_by` varchar(255),
        primary key (`photo_id`)
    ) engine=InnoDB;

    create table `photo_album` (
        `album_id` bigint not null auto_increment,
        `created_at` datetime(6) not null,
        `updated_at` datetime(6),
        `album_name` varchar(255),
        `background_image` varchar(255),
        `created_by` varchar(255),
        `updated_by` varchar(255),
        primary key (`album_id`)
    ) engine=InnoDB;

    create table `role` (
        `created_at` datetime(6) not null,
        `role_id` bigint not null auto_increment,
        `updated_at` datetime(6),
        `created_by` varchar(255),
        `name` varchar(255) not null,
        `updated_by` varchar(255),
        primary key (`role_id`)
    ) engine=InnoDB;

    create table `role_account` (
        `account_id` bigint not null,
        `created_at` datetime(6) not null,
        `role_id` bigint not null,
        `updated_at` datetime(6),
        `created_by` varchar(255),
        `updated_by` varchar(255),
        primary key (`account_id`, `role_id`)
    ) engine=InnoDB;

    create table `token` (
        `revoked` bit not null,
        `account_id` bigint,
        `created_at` datetime(6) not null,
        `expiry_date` datetime(6) not null,
        `token_id` bigint not null auto_increment,
        `updated_at` datetime(6),
        `created_by` varchar(255),
        `token` varchar(255) not null,
        `token_type` varchar(255) not null,
        `updated_by` varchar(255),
        primary key (`token_id`)
    ) engine=InnoDB;

    alter table `account` 
       add constraint UK_gex1lmaqpg0ir5g1f5eftyaa1 unique (`username`);

    alter table `family_member` 
       add constraint UK_9j58np7nvxkjsr8axoodws9wi unique (`account_id`);

    alter table `role` 
       add constraint UK_8sewwnpamngi6b1dwaa88askk unique (`name`);

    alter table `contact` 
       add constraint `FKa662284mv3v70efr9ke4e56rx` 
       foreign key (`member_id`) 
       references `family_member` (`member_id`);

    alter table `family_member` 
       add constraint `FKe036vnrpek6g9ui0s16evp7xy` 
       foreign key (`account_id`) 
       references `account` (`account_id`);

    alter table `family_member` 
       add constraint `FKefmngx5ktky2xhh7f73f74hj` 
       foreign key (`family_id`) 
       references `family` (`family_id`);

    alter table `marriage` 
       add constraint `FK3j0pdlqvtc098flmu4xdaeapq` 
       foreign key (`husband_id`) 
       references `family_member` (`member_id`);

    alter table `marriage` 
       add constraint `FKockv3umn6rc2dtwnsicuji43v` 
       foreign key (`wife_id`) 
       references `family_member` (`member_id`);

    alter table `member_event` 
       add constraint `FKmtp4tlt0bm252tsyg82ny7tgj` 
       foreign key (`event_id`) 
       references `family_event` (`event_id`);

    alter table `member_event` 
       add constraint `FKs34ysou7xmtvaaucxiiqa5cpg` 
       foreign key (`member_id`) 
       references `family_member` (`member_id`);

    alter table `member_notification` 
       add constraint `FKg5ytrmyak9k0g7qlvusgxq9vf` 
       foreign key (`member_id`) 
       references `family_member` (`member_id`);

    alter table `member_notification` 
       add constraint `FK5i6t3fj6eejtmwbjspnndouuv` 
       foreign key (`notification_id`) 
       references `notification` (`notification_id`);

    alter table `merit` 
       add constraint `FKn9eosoi2ot8ukkx7elnwkgbdt` 
       foreign key (`member_id`) 
       references `family_member` (`member_id`);

    alter table `merit` 
       add constraint `FKhwjqbofc87hwb1jtqm4jnqqaj` 
       foreign key (`merit_event_id`) 
       references `merit_event` (`merit_event_id`);

    alter table `merit` 
       add constraint `FK2mqef1vui2bowrrm5pgk6xsql` 
       foreign key (`merit_type_id`) 
       references `merit_type` (`merit_type_id`);

    alter table `merit` 
       add constraint `FKme9ismjwj5onfc93fw7dslnjj` 
       foreign key (`payer_member_id`) 
       references `family_member` (`member_id`);

    alter table `merit_banking_info` 
       add constraint `FKq5gbxw79kt68f4ylo5il39ub5` 
       foreign key (`merit_id`) 
       references `merit` (`merit_id`);

    alter table `merit_spending` 
       add constraint `FKk19vjh27pi87ijb8a561kj9dc` 
       foreign key (`merit_id`) 
       references `merit` (`merit_id`);

    alter table `merit_spending` 
       add constraint `FKt97ig3fvne50kk1y56ro6lxxa` 
       foreign key (`merit_event_id`) 
       references `merit_event` (`merit_event_id`);

    alter table `photo` 
       add constraint `FKenp8min560cfgcqgl9ix71khm` 
       foreign key (`album_id`) 
       references `photo_album` (`album_id`);

    alter table `role_account` 
       add constraint `FK9dgt8k82peg2i69sytqp5ljte` 
       foreign key (`account_id`) 
       references `account` (`account_id`);

    alter table `role_account` 
       add constraint `FKg5a7wqfh8i53yr5m2rrukliu8` 
       foreign key (`role_id`) 
       references `role` (`role_id`);

    alter table `token` 
       add constraint `FKf4j7i0wwlqmeaxu9fufgkopdp` 
       foreign key (`account_id`) 
       references `account` (`account_id`);

    create table `account` (
        `account_id` bigint not null auto_increment,
        `created_at` datetime(6) not null,
        `updated_at` datetime(6),
        `created_by` varchar(255),
        `email` varchar(255),
        `full_name` varchar(255),
        `password` varchar(255) not null,
        `phone` varchar(255),
        `updated_by` varchar(255),
        `username` varchar(255) not null,
        primary key (`account_id`)
    ) engine=InnoDB;

    create table `contact` (
        `contact_id` bigint not null auto_increment,
        `created_at` datetime(6) not null,
        `member_id` bigint,
        `updated_at` datetime(6),
        `address` varchar(255),
        `created_by` varchar(255),
        `email` varchar(255),
        `phone` varchar(255),
        `updated_by` varchar(255),
        `zalo` varchar(255),
        primary key (`contact_id`)
    ) engine=InnoDB;

    create table `family` (
        `created_at` datetime(6) not null,
        `family_id` bigint not null auto_increment,
        `updated_at` datetime(6),
        `created_by` varchar(255),
        `name` varchar(255),
        `updated_by` varchar(255),
        primary key (`family_id`)
    ) engine=InnoDB;

    create table `family_event` (
        `end_date` date,
        `start_date` date,
        `created_at` datetime(6) not null,
        `event_id` bigint not null auto_increment,
        `updated_at` datetime(6),
        `created_by` varchar(255),
        `description` TEXT,
        `event_name` varchar(255),
        `place` varchar(255),
        `status` varchar(255),
        `updated_by` varchar(255),
        primary key (`event_id`)
    ) engine=InnoDB;

    create table `family_history` (
        `end_date` date,
        `start_date` date,
        `created_at` datetime(6) not null,
        `history_id` bigint not null auto_increment,
        `updated_at` datetime(6),
        `created_by` varchar(255),
        `description` TEXT,
        `updated_by` varchar(255),
        primary key (`history_id`)
    ) engine=InnoDB;

    create table `family_member` (
        `birth_date` date,
        `date_of_death` date,
        `father_id` integer,
        `mother_id` integer,
        `account_id` bigint,
        `created_at` datetime(6) not null,
        `family_id` bigint,
        `member_id` bigint not null auto_increment,
        `updated_at` datetime(6),
        `address` TEXT,
        `created_by` varchar(255),
        `full_name` varchar(255),
        `gender` varchar(255),
        `generation` varchar(255),
        `grave_site` varchar(255),
        `life_status` varchar(255),
        `role_family` varchar(255),
        `updated_by` varchar(255),
        primary key (`member_id`)
    ) engine=InnoDB;

    create table `marriage` (
        `created_at` datetime(6) not null,
        `husband_id` bigint,
        `marriage_id` bigint not null auto_increment,
        `updated_at` datetime(6),
        `wife_id` bigint,
        `created_by` varchar(255),
        `updated_by` varchar(255),
        primary key (`marriage_id`)
    ) engine=InnoDB;

    create table `member_event` (
        `is_going` bit,
        `created_at` datetime(6) not null,
        `event_id` bigint not null,
        `member_id` bigint not null,
        `updated_at` datetime(6),
        `created_by` varchar(255),
        `updated_by` varchar(255),
        primary key (`event_id`, `member_id`)
    ) engine=InnoDB;

    create table `member_notification` (
        `created_at` datetime(6) not null,
        `member_id` bigint not null,
        `notification_id` bigint not null,
        `updated_at` datetime(6),
        `created_by` varchar(255),
        `updated_by` varchar(255),
        primary key (`member_id`, `notification_id`)
    ) engine=InnoDB;

    create table `merit` (
        `amount` decimal(10,2),
        `merit_date` date,
        `created_at` datetime(6) not null,
        `member_id` bigint,
        `merit_event_id` bigint,
        `merit_id` bigint not null auto_increment,
        `merit_type_id` bigint,
        `payer_member_id` bigint,
        `updated_at` datetime(6),
        `created_by` varchar(255),
        `description` TEXT,
        `payment_status` varchar(255),
        `qr_code_url` varchar(255),
        `updated_by` varchar(255),
        primary key (`merit_id`)
    ) engine=InnoDB;

    create table `merit_banking_info` (
        `created_at` datetime(6) not null,
        `merit_banking_info_id` bigint not null auto_increment,
        `merit_id` bigint,
        `updated_at` datetime(6),
        `account_number` varchar(255),
        `bank_name` varchar(255),
        `created_by` varchar(255),
        `note` TEXT,
        `updated_by` varchar(255),
        primary key (`merit_banking_info_id`)
    ) engine=InnoDB;

    create table `merit_event` (
        `end_date` date,
        `start_date` date,
        `created_at` datetime(6) not null,
        `merit_event_id` bigint not null auto_increment,
        `updated_at` datetime(6),
        `created_by` varchar(255),
        `description` TEXT,
        `updated_by` varchar(255),
        primary key (`merit_event_id`)
    ) engine=InnoDB;

    create table `merit_spending` (
        `amount` decimal(10,2),
        `spending_date` date,
        `created_at` datetime(6) not null,
        `merit_event_id` bigint,
        `merit_id` bigint,
        `merit_spending_id` bigint not null auto_increment,
        `updated_at` datetime(6),
        `created_by` varchar(255),
        `description` TEXT,
        `updated_by` varchar(255),
        primary key (`merit_spending_id`)
    ) engine=InnoDB;

    create table `merit_type` (
        `created_at` datetime(6) not null,
        `merit_type_id` bigint not null auto_increment,
        `updated_at` datetime(6),
        `created_by` varchar(255),
        `description` TEXT,
        `merit_type_name` varchar(255),
        `updated_by` varchar(255),
        primary key (`merit_type_id`)
    ) engine=InnoDB;

    create table `notification` (
        `created_at` datetime(6) not null,
        `notification_id` bigint not null auto_increment,
        `updated_at` datetime(6),
        `status` varchar(20),
        `type` varchar(50),
        `title` varchar(200) not null,
        `content` TEXT,
        `created_by` varchar(255),
        `updated_by` varchar(255),
        primary key (`notification_id`)
    ) engine=InnoDB;

    create table `photo` (
        `album_id` bigint,
        `created_at` datetime(6) not null,
        `photo_id` bigint not null auto_increment,
        `updated_at` datetime(6),
        `created_by` varchar(255),
        `image` varchar(255),
        `updated_by` varchar(255),
        primary key (`photo_id`)
    ) engine=InnoDB;

    create table `photo_album` (
        `album_id` bigint not null auto_increment,
        `created_at` datetime(6) not null,
        `updated_at` datetime(6),
        `album_name` varchar(255),
        `background_image` varchar(255),
        `created_by` varchar(255),
        `updated_by` varchar(255),
        primary key (`album_id`)
    ) engine=InnoDB;

    create table `role` (
        `created_at` datetime(6) not null,
        `role_id` bigint not null auto_increment,
        `updated_at` datetime(6),
        `created_by` varchar(255),
        `name` varchar(255) not null,
        `updated_by` varchar(255),
        primary key (`role_id`)
    ) engine=InnoDB;

    create table `role_account` (
        `account_id` bigint not null,
        `created_at` datetime(6) not null,
        `role_id` bigint not null,
        `updated_at` datetime(6),
        `created_by` varchar(255),
        `updated_by` varchar(255),
        primary key (`account_id`, `role_id`)
    ) engine=InnoDB;

    create table `token` (
        `revoked` bit not null,
        `account_id` bigint,
        `created_at` datetime(6) not null,
        `expiry_date` datetime(6) not null,
        `token_id` bigint not null auto_increment,
        `updated_at` datetime(6),
        `created_by` varchar(255),
        `token` varchar(255) not null,
        `token_type` varchar(255) not null,
        `updated_by` varchar(255),
        primary key (`token_id`)
    ) engine=InnoDB;

    alter table `account` 
       add constraint UK_gex1lmaqpg0ir5g1f5eftyaa1 unique (`username`);

    alter table `family_member` 
       add constraint UK_9j58np7nvxkjsr8axoodws9wi unique (`account_id`);

    alter table `role` 
       add constraint UK_8sewwnpamngi6b1dwaa88askk unique (`name`);

    alter table `contact` 
       add constraint `FKa662284mv3v70efr9ke4e56rx` 
       foreign key (`member_id`) 
       references `family_member` (`member_id`);

    alter table `family_member` 
       add constraint `FKe036vnrpek6g9ui0s16evp7xy` 
       foreign key (`account_id`) 
       references `account` (`account_id`);

    alter table `family_member` 
       add constraint `FKefmngx5ktky2xhh7f73f74hj` 
       foreign key (`family_id`) 
       references `family` (`family_id`);

    alter table `marriage` 
       add constraint `FK3j0pdlqvtc098flmu4xdaeapq` 
       foreign key (`husband_id`) 
       references `family_member` (`member_id`);

    alter table `marriage` 
       add constraint `FKockv3umn6rc2dtwnsicuji43v` 
       foreign key (`wife_id`) 
       references `family_member` (`member_id`);

    alter table `member_event` 
       add constraint `FKmtp4tlt0bm252tsyg82ny7tgj` 
       foreign key (`event_id`) 
       references `family_event` (`event_id`);

    alter table `member_event` 
       add constraint `FKs34ysou7xmtvaaucxiiqa5cpg` 
       foreign key (`member_id`) 
       references `family_member` (`member_id`);

    alter table `member_notification` 
       add constraint `FKg5ytrmyak9k0g7qlvusgxq9vf` 
       foreign key (`member_id`) 
       references `family_member` (`member_id`);

    alter table `member_notification` 
       add constraint `FK5i6t3fj6eejtmwbjspnndouuv` 
       foreign key (`notification_id`) 
       references `notification` (`notification_id`);

    alter table `merit` 
       add constraint `FKn9eosoi2ot8ukkx7elnwkgbdt` 
       foreign key (`member_id`) 
       references `family_member` (`member_id`);

    alter table `merit` 
       add constraint `FKhwjqbofc87hwb1jtqm4jnqqaj` 
       foreign key (`merit_event_id`) 
       references `merit_event` (`merit_event_id`);

    alter table `merit` 
       add constraint `FK2mqef1vui2bowrrm5pgk6xsql` 
       foreign key (`merit_type_id`) 
       references `merit_type` (`merit_type_id`);

    alter table `merit` 
       add constraint `FKme9ismjwj5onfc93fw7dslnjj` 
       foreign key (`payer_member_id`) 
       references `family_member` (`member_id`);

    alter table `merit_banking_info` 
       add constraint `FKq5gbxw79kt68f4ylo5il39ub5` 
       foreign key (`merit_id`) 
       references `merit` (`merit_id`);

    alter table `merit_spending` 
       add constraint `FKk19vjh27pi87ijb8a561kj9dc` 
       foreign key (`merit_id`) 
       references `merit` (`merit_id`);

    alter table `merit_spending` 
       add constraint `FKt97ig3fvne50kk1y56ro6lxxa` 
       foreign key (`merit_event_id`) 
       references `merit_event` (`merit_event_id`);

    alter table `photo` 
       add constraint `FKenp8min560cfgcqgl9ix71khm` 
       foreign key (`album_id`) 
       references `photo_album` (`album_id`);

    alter table `role_account` 
       add constraint `FK9dgt8k82peg2i69sytqp5ljte` 
       foreign key (`account_id`) 
       references `account` (`account_id`);

    alter table `role_account` 
       add constraint `FKg5a7wqfh8i53yr5m2rrukliu8` 
       foreign key (`role_id`) 
       references `role` (`role_id`);

    alter table `token` 
       add constraint `FKf4j7i0wwlqmeaxu9fufgkopdp` 
       foreign key (`account_id`) 
       references `account` (`account_id`);

    create table `account` (
        `account_id` bigint not null auto_increment,
        `created_at` datetime(6) not null,
        `updated_at` datetime(6),
        `created_by` varchar(255),
        `email` varchar(255),
        `full_name` varchar(255),
        `password` varchar(255) not null,
        `phone` varchar(255),
        `updated_by` varchar(255),
        `username` varchar(255) not null,
        primary key (`account_id`)
    ) engine=InnoDB;

    create table `contact` (
        `contact_id` bigint not null auto_increment,
        `created_at` datetime(6) not null,
        `member_id` bigint,
        `updated_at` datetime(6),
        `address` varchar(255),
        `created_by` varchar(255),
        `email` varchar(255),
        `phone` varchar(255),
        `updated_by` varchar(255),
        `zalo` varchar(255),
        primary key (`contact_id`)
    ) engine=InnoDB;

    create table `family` (
        `created_at` datetime(6) not null,
        `family_id` bigint not null auto_increment,
        `updated_at` datetime(6),
        `created_by` varchar(255),
        `name` varchar(255),
        `updated_by` varchar(255),
        primary key (`family_id`)
    ) engine=InnoDB;

    create table `family_event` (
        `end_date` date,
        `start_date` date,
        `created_at` datetime(6) not null,
        `event_id` bigint not null auto_increment,
        `updated_at` datetime(6),
        `created_by` varchar(255),
        `description` TEXT,
        `event_name` varchar(255),
        `place` varchar(255),
        `status` varchar(255),
        `updated_by` varchar(255),
        primary key (`event_id`)
    ) engine=InnoDB;

    create table `family_history` (
        `end_date` date,
        `start_date` date,
        `created_at` datetime(6) not null,
        `history_id` bigint not null auto_increment,
        `updated_at` datetime(6),
        `created_by` varchar(255),
        `description` TEXT,
        `updated_by` varchar(255),
        primary key (`history_id`)
    ) engine=InnoDB;

    create table `family_member` (
        `birth_date` date,
        `date_of_death` date,
        `father_id` integer,
        `mother_id` integer,
        `account_id` bigint,
        `created_at` datetime(6) not null,
        `family_id` bigint,
        `member_id` bigint not null auto_increment,
        `updated_at` datetime(6),
        `address` TEXT,
        `created_by` varchar(255),
        `full_name` varchar(255),
        `gender` varchar(255),
        `generation` varchar(255),
        `grave_site` varchar(255),
        `life_status` varchar(255),
        `role_family` varchar(255),
        `updated_by` varchar(255),
        primary key (`member_id`)
    ) engine=InnoDB;

    create table `marriage` (
        `created_at` datetime(6) not null,
        `husband_id` bigint,
        `marriage_id` bigint not null auto_increment,
        `updated_at` datetime(6),
        `wife_id` bigint,
        `created_by` varchar(255),
        `updated_by` varchar(255),
        primary key (`marriage_id`)
    ) engine=InnoDB;

    create table `member_event` (
        `is_going` bit,
        `created_at` datetime(6) not null,
        `event_id` bigint not null,
        `member_id` bigint not null,
        `updated_at` datetime(6),
        `created_by` varchar(255),
        `updated_by` varchar(255),
        primary key (`event_id`, `member_id`)
    ) engine=InnoDB;

    create table `member_notification` (
        `created_at` datetime(6) not null,
        `member_id` bigint not null,
        `notification_id` bigint not null,
        `updated_at` datetime(6),
        `created_by` varchar(255),
        `updated_by` varchar(255),
        primary key (`member_id`, `notification_id`)
    ) engine=InnoDB;

    create table `merit` (
        `amount` decimal(10,2),
        `merit_date` date,
        `created_at` datetime(6) not null,
        `member_id` bigint,
        `merit_event_id` bigint,
        `merit_id` bigint not null auto_increment,
        `merit_type_id` bigint,
        `payer_member_id` bigint,
        `updated_at` datetime(6),
        `created_by` varchar(255),
        `description` TEXT,
        `payment_status` varchar(255),
        `qr_code_url` varchar(255),
        `updated_by` varchar(255),
        primary key (`merit_id`)
    ) engine=InnoDB;

    create table `merit_banking_info` (
        `created_at` datetime(6) not null,
        `merit_banking_info_id` bigint not null auto_increment,
        `merit_id` bigint,
        `updated_at` datetime(6),
        `account_number` varchar(255),
        `bank_name` varchar(255),
        `created_by` varchar(255),
        `note` TEXT,
        `updated_by` varchar(255),
        primary key (`merit_banking_info_id`)
    ) engine=InnoDB;

    create table `merit_event` (
        `end_date` date,
        `start_date` date,
        `created_at` datetime(6) not null,
        `merit_event_id` bigint not null auto_increment,
        `updated_at` datetime(6),
        `created_by` varchar(255),
        `description` TEXT,
        `updated_by` varchar(255),
        primary key (`merit_event_id`)
    ) engine=InnoDB;

    create table `merit_spending` (
        `amount` decimal(10,2),
        `spending_date` date,
        `created_at` datetime(6) not null,
        `merit_event_id` bigint,
        `merit_id` bigint,
        `merit_spending_id` bigint not null auto_increment,
        `updated_at` datetime(6),
        `created_by` varchar(255),
        `description` TEXT,
        `updated_by` varchar(255),
        primary key (`merit_spending_id`)
    ) engine=InnoDB;

    create table `merit_type` (
        `created_at` datetime(6) not null,
        `merit_type_id` bigint not null auto_increment,
        `updated_at` datetime(6),
        `created_by` varchar(255),
        `description` TEXT,
        `merit_type_name` varchar(255),
        `updated_by` varchar(255),
        primary key (`merit_type_id`)
    ) engine=InnoDB;

    create table `notification` (
        `created_at` datetime(6) not null,
        `notification_id` bigint not null auto_increment,
        `updated_at` datetime(6),
        `status` varchar(20),
        `type` varchar(50),
        `title` varchar(200) not null,
        `content` TEXT,
        `created_by` varchar(255),
        `updated_by` varchar(255),
        primary key (`notification_id`)
    ) engine=InnoDB;

    create table `photo` (
        `album_id` bigint,
        `created_at` datetime(6) not null,
        `photo_id` bigint not null auto_increment,
        `updated_at` datetime(6),
        `created_by` varchar(255),
        `image` varchar(255),
        `updated_by` varchar(255),
        primary key (`photo_id`)
    ) engine=InnoDB;

    create table `photo_album` (
        `album_id` bigint not null auto_increment,
        `created_at` datetime(6) not null,
        `updated_at` datetime(6),
        `album_name` varchar(255),
        `background_image` varchar(255),
        `created_by` varchar(255),
        `updated_by` varchar(255),
        primary key (`album_id`)
    ) engine=InnoDB;

    create table `role` (
        `created_at` datetime(6) not null,
        `role_id` bigint not null auto_increment,
        `updated_at` datetime(6),
        `created_by` varchar(255),
        `name` varchar(255) not null,
        `updated_by` varchar(255),
        primary key (`role_id`)
    ) engine=InnoDB;

    create table `role_account` (
        `account_id` bigint not null,
        `created_at` datetime(6) not null,
        `role_id` bigint not null,
        `updated_at` datetime(6),
        `created_by` varchar(255),
        `updated_by` varchar(255),
        primary key (`account_id`, `role_id`)
    ) engine=InnoDB;

    create table `token` (
        `revoked` bit not null,
        `account_id` bigint,
        `created_at` datetime(6) not null,
        `expiry_date` datetime(6) not null,
        `token_id` bigint not null auto_increment,
        `updated_at` datetime(6),
        `created_by` varchar(255),
        `token` varchar(255) not null,
        `token_type` varchar(255) not null,
        `updated_by` varchar(255),
        primary key (`token_id`)
    ) engine=InnoDB;

    alter table `account` 
       add constraint UK_gex1lmaqpg0ir5g1f5eftyaa1 unique (`username`);

    alter table `family_member` 
       add constraint UK_9j58np7nvxkjsr8axoodws9wi unique (`account_id`);

    alter table `role` 
       add constraint UK_8sewwnpamngi6b1dwaa88askk unique (`name`);

    alter table `contact` 
       add constraint `FKa662284mv3v70efr9ke4e56rx` 
       foreign key (`member_id`) 
       references `family_member` (`member_id`);

    alter table `family_member` 
       add constraint `FKe036vnrpek6g9ui0s16evp7xy` 
       foreign key (`account_id`) 
       references `account` (`account_id`);

    alter table `family_member` 
       add constraint `FKefmngx5ktky2xhh7f73f74hj` 
       foreign key (`family_id`) 
       references `family` (`family_id`);

    alter table `marriage` 
       add constraint `FK3j0pdlqvtc098flmu4xdaeapq` 
       foreign key (`husband_id`) 
       references `family_member` (`member_id`);

    alter table `marriage` 
       add constraint `FKockv3umn6rc2dtwnsicuji43v` 
       foreign key (`wife_id`) 
       references `family_member` (`member_id`);

    alter table `member_event` 
       add constraint `FKmtp4tlt0bm252tsyg82ny7tgj` 
       foreign key (`event_id`) 
       references `family_event` (`event_id`);

    alter table `member_event` 
       add constraint `FKs34ysou7xmtvaaucxiiqa5cpg` 
       foreign key (`member_id`) 
       references `family_member` (`member_id`);

    alter table `member_notification` 
       add constraint `FKg5ytrmyak9k0g7qlvusgxq9vf` 
       foreign key (`member_id`) 
       references `family_member` (`member_id`);

    alter table `member_notification` 
       add constraint `FK5i6t3fj6eejtmwbjspnndouuv` 
       foreign key (`notification_id`) 
       references `notification` (`notification_id`);

    alter table `merit` 
       add constraint `FKn9eosoi2ot8ukkx7elnwkgbdt` 
       foreign key (`member_id`) 
       references `family_member` (`member_id`);

    alter table `merit` 
       add constraint `FKhwjqbofc87hwb1jtqm4jnqqaj` 
       foreign key (`merit_event_id`) 
       references `merit_event` (`merit_event_id`);

    alter table `merit` 
       add constraint `FK2mqef1vui2bowrrm5pgk6xsql` 
       foreign key (`merit_type_id`) 
       references `merit_type` (`merit_type_id`);

    alter table `merit` 
       add constraint `FKme9ismjwj5onfc93fw7dslnjj` 
       foreign key (`payer_member_id`) 
       references `family_member` (`member_id`);

    alter table `merit_banking_info` 
       add constraint `FKq5gbxw79kt68f4ylo5il39ub5` 
       foreign key (`merit_id`) 
       references `merit` (`merit_id`);

    alter table `merit_spending` 
       add constraint `FKk19vjh27pi87ijb8a561kj9dc` 
       foreign key (`merit_id`) 
       references `merit` (`merit_id`);

    alter table `merit_spending` 
       add constraint `FKt97ig3fvne50kk1y56ro6lxxa` 
       foreign key (`merit_event_id`) 
       references `merit_event` (`merit_event_id`);

    alter table `photo` 
       add constraint `FKenp8min560cfgcqgl9ix71khm` 
       foreign key (`album_id`) 
       references `photo_album` (`album_id`);

    alter table `role_account` 
       add constraint `FK9dgt8k82peg2i69sytqp5ljte` 
       foreign key (`account_id`) 
       references `account` (`account_id`);

    alter table `role_account` 
       add constraint `FKg5a7wqfh8i53yr5m2rrukliu8` 
       foreign key (`role_id`) 
       references `role` (`role_id`);

    alter table `token` 
       add constraint `FKf4j7i0wwlqmeaxu9fufgkopdp` 
       foreign key (`account_id`) 
       references `account` (`account_id`);
