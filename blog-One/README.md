# LSS的个人博客

一个基于 Hexo + Butterfly 主题的个人博客系统，用于记录生活和分享技术。

## 📋 项目信息

- **框架**: Hexo 7.3.0
- **主题**: Butterfly 5.3.4  
- **部署**: GitHub Pages
- **域名**: lssblog.us.kg

## 🚀 快速开始

### 安装依赖
```bash
npm install
```

### 本地运行
```bash
hexo server
```
访问 http://localhost:4000 查看博客

### 新建文章
```bash
hexo new "文章标题"
```

### 生成静态文件
```bash
hexo generate
```

### 部署到 GitHub Pages
```bash
hexo generate && hexo deploy
```

## 📁 目录结构

```
blog-One/
├── source/                 # 源文件目录
│   ├── _posts/            # 博客文章
│   ├── about/             # 关于页面
│   ├── link/              # 友情链接页面
│   ├── music/             # 音乐页面
│   ├── movies/            # 电影页面
│   └── img/               # 图片资源
├── themes/                # 主题目录
├── _config.yml           # Hexo 主配置
├── _config.butterfly.yml  # Butterfly 主题配置
└── package.json          # 项目依赖
```

## ⚙️ 主要配置

### Hexo 主配置 (_config.yml)
- 网站基本信息
- URL设置
- 部署配置
- 搜索配置

### 主题配置 (_config.butterfly.yml)
- 导航菜单
- 代码块设置
- 侧边栏配置
- 主题颜色
- 功能开关

## 🎨 功能特性

### 核心功能
- ✅ 本地搜索功能
- ✅ 图片懒加载
- ✅ 代码高亮 (macOS 风格)
- ✅ 数学公式支持 (KaTeX)
- ✅ 灯箱效果
- ✅ Pjax 加速
- ✅ 字数统计
- ✅ 访客统计
- ✅ 深色模式
- ✅ 响应式设计

### 高级功能
- 💬 **评论系统**: Twikoo 评论，支持 Markdown
- 📊 **图表支持**: Mermaid 图表绘制
- 🎆 **视觉特效**: 烟花点击效果、动态背景
- 💖 **打赏功能**: 微信/支付宝打赏支持
- 📱 **RSS 订阅**: 支持文章订阅
- 🌈 **主题定制**: 个性化配色方案
- 📈 **SEO 优化**: 完整的搜索引擎优化
- 🎯 **阅读进度**: 文章阅读进度显示

## 📝 写作指南

### 文章格式
```markdown
---
title: 文章标题
date: 2025-03-01 13:00:00
author: LSS
tags: ["标签1", "标签2"]
categories: ["分类名"]
excerpt: 文章摘要
cover: /img/cover.jpg
toc: true
---

文章内容...
```

### 支持的功能
- 数学公式：使用 `$...$` 或 `$$...$$`
- 代码块：使用 ```language
- 目录：`[[toc]]` 自动生成目录
- 图片：支持懒加载和灯箱效果

## 🔧 部署

博客已配置自动部署到 GitHub Pages：

1. 确保已配置 GitHub 仓库
2. 修改 `_config.yml` 中的部署配置
3. 运行部署命令：
   ```bash
   hexo generate && hexo deploy
   ```

## 📞 联系方式

- 邮箱：mixuu10001@gmail.com
- GitHub：@MIXUULSS

---

**持续学习，持续分享！** 🚀