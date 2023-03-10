# s1emoticon S1论坛麻将脸仓库

作为[S1论坛](https://bbs.saraba1st.com/)的麻将脸（特色表情）讨论和增减新表情的地方。

## 最新下载地址
[https://github.com/kawaiidora/s1emoticon/releases/latest](https://github.com/kawaiidora/s1emoticon/releases/latest)

## 分类

论坛和应用对应：
|文件夹名|对应名称|备注|
|--------|--------|----|
|animal|动物||
|bundam|高达|为了字母顺序|
|carton|动漫|当时想打cartoon打错了，后来变成了二次元头像的含义|
|device|硬件||
|face|麻将脸|缺省表情系列|
|goose|鹅||

其他：
|文件夹名|对应名称|备注|
|--------|--------|----|
|unused|未使用|属于原打包的extra|
|queue|候选|新增表情的候补生|
|etc|混沌|未整理区域|

## 其他文件说明

### cdb_common_smiley.csv

麻将脸记录表

|id|typeid|displayorder|type|code|url|
|--|------|------------|----|----|---|
|不重复自增ID|type的标识符|论坛用显示序号|麻将脸都是smiley|文件对应的ASCII代码|对应文件标识符|

### automatic.py

一键复制重命名打包脚本（未完成），运行需要Python 3.8.6或更高版本 (为了在win7上能运行）

- [x] 读取数据表 
- [ ] 从文件目录读取文件名和排序等信息，新文件添加新的项目 
- [ ] 根据文件名排序信息重新排序
- [ ] 输出更新后数据表
- [ ] 输出更新后文件，含增补包
