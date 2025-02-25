
CREATE DATABASE feedfusion;
USE feedfusion;
-- articles

DROP TABLE IF EXISTS articles;
CREATE TABLE articles (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,  -- 文章ID
    title VARCHAR(255) NOT NULL,           -- 文章标题
    content TEXT NOT NULL,                 -- 文章正文
    author_id BIGINT NOT NULL,              -- 关联用户表的作者ID
    category_id INT NOT NULL,               -- 文章类别ID
    cover_image VARCHAR(255),               -- 文章封面图URL
    status ENUM('draft', 'published', 'deleted') DEFAULT 'draft', -- 文章状态
    publish_time DATETIME DEFAULT NULL,     -- 发布时间
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP, -- 创建时间
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP, -- 更新时间
    INDEX idx_category (category_id),
    INDEX idx_publish_time (publish_time),
    INDEX idx_author (author_id)
);

DROP TABLE IF EXISTS article_settings;
CREATE TABLE article_settings (
    article_id BIGINT PRIMARY KEY,
    allow_comments BOOLEAN DEFAULT TRUE, -- 是否允许评论
    allow_sharing BOOLEAN DEFAULT TRUE, -- 是否允许分享
    FOREIGN KEY (article_id) REFERENCES articles(id) ON DELETE CASCADE
);


DROP TABLE IF EXISTS article_images;
CREATE TABLE article_images (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    article_id BIGINT NOT NULL,   -- 关联文章表
    image_url VARCHAR(255) NOT NULL,  -- 图片链接
    image_hash VARCHAR(64) NOT NULL, -- 图片hash
    position INT DEFAULT 0,  -- 图片在文章中的位置
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (article_id) REFERENCES articles(id) ON DELETE CASCADE
);


DROP TABLE IF EXISTS channels;
CREATE TABLE channels (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50) NOT NULL UNIQUE, -- 类别名称
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

DROP TABLE IF EXISTS users;
CREATE TABLE users (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(50) NOT NULL UNIQUE,
    email VARCHAR(100) NOT NULL UNIQUE,
    password_hash VARCHAR(255) NOT NULL, -- 密码加密存储
    avatar VARCHAR(255), -- 头像URL
    role ENUM('admin', 'editor', 'author', 'reader') DEFAULT 'reader', -- 用户角色
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

DROP TABLE IF EXISTS article_statistics;
CREATE TABLE article_statistics (
    article_id BIGINT PRIMARY KEY,
    view_count BIGINT DEFAULT 0,     -- 浏览量
    like_count INT DEFAULT 0,        -- 点赞数
    comment_count INT DEFAULT 0,     -- 评论数
    share_count INT DEFAULT 0,       -- 分享数
    FOREIGN KEY (article_id) REFERENCES articles(id) ON DELETE CASCADE
);



DROP TABLE IF EXISTS user_actions;
CREATE TABLE user_actions (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    user_id BIGINT NOT NULL,  -- 用户ID
    article_id BIGINT NOT NULL, -- 文章ID
    action_type ENUM('like', 'comment', 'share', 'view') NOT NULL, -- 操作类型
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (article_id) REFERENCES articles(id) ON DELETE CASCADE
);


DROP TABLE IF EXISTS comments;
CREATE TABLE comments (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    article_id BIGINT NOT NULL, -- 文章ID
    user_id BIGINT NOT NULL, -- 评论用户ID
    content TEXT NOT NULL, -- 评论内容
    parent_comment_id BIGINT DEFAULT NULL, -- 父评论ID（支持回复）
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (article_id) REFERENCES articles(id) ON DELETE CASCADE,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

