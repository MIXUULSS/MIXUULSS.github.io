# GitHub重新上传指南

## 📁 **需要上传的核心文件清单**

### 🔧 **1. 核心配置文件 (必须)**
- [x] `_config.yml` - Hexo主配置文件
- [x] `_config.butterfly.yml` - Butterfly主题配置
- [x] `package.json` - 项目依赖配置
- [x] `package-lock.json` - 锁定依赖版本
- [x] `README.md` - 项目说明文档
- [x] `.gitignore` - Git忽略文件配置

### 📂 **2. 源文件目录 (必须)**
- [x] `source/` - 所有源文件
  ├── [x] `_posts/` - 博客文章 (5个md文件)
  ├── [x] `css/` - 自定义CSS样式
  ├── [x] `img/` - 图片资源文件
  ├── [x] `about/` - 关于页面
  ├── [x] `music/` - 音乐页面
  ├── [x] `movies/` - 电影页面
  ├── [x] `anime/` - 动漫页面
  ├── [x] `manga/` - 漫画页面
  ├── [x] `novel/` - 小说页面
  ├── [x] `asmr/` - ASMR页面
  ├── [x] `link/` - 友情链接页面
  ├── [x] `categories/` - 分类页面
  ├── [x] `tags/` - 标签页面
  └── [x] `CNAME` - 域名配置文件

### 🎨 **3. 主题文件 (必须)**
- [x] `themes/butterfly/` - 完整的Butterfly主题
  ├── [x] `layout/` - 页面模板 (110个pug文件)
  ├── [x] `source/` - 主题静态资源 (CSS/JS/图片)
  ├── [x] `scripts/` - 主题功能脚本 (29个js文件)
  └── [x] `_config.yml` - 主题默认配置

### 📋 **4. 不需要上传的文件 (将被.gitignore忽略)**
- [ ] `public/` - 生成的静态文件 (可以重新生成)
- [ ] `node_modules/` - 依赖包 (可通过npm install重新安装)
- [ ] `db.json` - Hexo数据库文件
- [ ] `.deploy_git/` - 部署缓存

## 🚀 **重新上传步骤**

### **第一步：删除现有GitHub仓库内容**
```bash
# 在GitHub网页上删除仓库中的所有文件
# 或者使用以下命令（谨慎操作）
git rm -rf .
git commit -m "Clear repository"
git push origin main --force
```

### **第二步：上传核心文件**
```bash
# 添加所有必要文件
git add _config.yml _config.butterfly.yml package*.json README.md .gitignore
git add source/ themes/
git commit -m "Initial Hexo blog setup with Butterfly theme"
git push origin main
```

### **第三步：本地安装依赖并生成**
```bash
# 安装依赖
npm install

# 生成静态文件
npx hexo clean
npx hexo generate
```

### **第四步：设置GitHub Pages**
1. 进入GitHub仓库设置
2. 找到Pages选项
3. Source选择：Deploy from a branch
4. Branch选择：main
5. Folder选择：/(root)
6. 保存设置

## 📊 **文件统计**

- **总文件数**: 约 300+ 文件
- **主要配置**: 6个文件
- **源文件**: 25个文件 + 5篇博客文章
- **主题文件**: 210个文件
- **预计上传大小**: ~15-20MB

## ⚠️ **注意事项**

1. **Git LFS**: 如果有大文件，考虑使用Git LFS
2. **分支设置**: 确保GitHub Pages指向main分支
3. **域名配置**: CNAME文件确保正确域名
4. **依赖版本**: package.json确保兼容性

## 🎯 **上传完成后验证**

1. 访问 `https://MIXUULSS.github.io`
2. 检查页面样式是否正常
3. 验证所有导航链接
4. 测试博客文章显示
5. 确认响应式布局

---

**准备好开始重新上传了吗？** 🚀