

# resymbol

Update Gene Symbols Uniquely

<br />

<p align="center">
  <h3 align="center">更新symbol后出现重名？</h3>
  <h3 align="center">更新symbol时网络不稳定导致总失败？</h3>
  <h3 align="center">Get duplicated symbols after update？</h3>
  <h3 align="center">Bad newtwork always abort your updating ？</h3>


  
  <p align="center">
    resymbol只更新不会产生歧义或冲突的gene symbols。只使用下载后的本地基因名更新文件，运行不吃网速，更没有长串symbol更新时总掉线的烦恼！  
    Only symbols without ambiguity will be updated. Using local files instead of checking online, faraway from abort and crawling.  
    <br />

  </p>

</p>

 
### 所需文件下载/To download genefiles

https://ftp.ebi.ac.uk/pub/databases/genenames/hgnc/archive/  
### 注意该文件每月更新/This file updates monthly!!!

### 示例/Example

hgnc_complete_set <- read.delim("hgnc_complete_set.txt")  
nameold = c("TP53","CD206")  
nametotal = resymbol(hgnc_complete_set,nameold)

### 输出结果/output
包含有新symbol列的数据框/A dataframe including replaced symbols:  
old: 输入的symbols/symbols input.  
newnames: 可选的更新后symbol（可能有歧义或与输入symbol冲突）/returned new symbols.   
prev/aliaschange: 可选的根据别名/曾用名库更新后的symbol/newnames searched by previous/alias symbol list.   
changenumber: 输入symbol匹配到的新symbol数/how many new symbols did the old symbol matched.   
newname_to_use: 具有唯一性的symbol列/unique updated symbol list.  


### 作者/Author
Jihao

### 鸣谢/Acknowledgments


- [一只小蛮要](https://blog.csdn.net/weixin_43843918/article/details/129395318?spm=1001.2014.3001.5501)
- [辣椒油li](https://blog.csdn.net/lijianyi0219/article/details/116297423)
- [shaojintian](https://github.com/shaojintian/Best_README_template)


<!-- links -->
[your-project-path]:shaojintian/Best_README_template
[contributors-shield]: https://img.shields.io/github/contributors/shaojintian/Best_README_template.svg?style=flat-square
[contributors-url]: https://github.com/shaojintian/Best_README_template/graphs/contributors
[forks-shield]: https://img.shields.io/github/forks/shaojintian/Best_README_template.svg?style=flat-square
[forks-url]: https://github.com/shaojintian/Best_README_template/network/members
[stars-shield]: https://img.shields.io/github/stars/shaojintian/Best_README_template.svg?style=flat-square
[stars-url]: https://github.com/shaojintian/Best_README_template/stargazers
[issues-shield]: https://img.shields.io/github/issues/shaojintian/Best_README_template.svg?style=flat-square
[issues-url]: https://img.shields.io/github/issues/shaojintian/Best_README_template.svg
[license-shield]: https://img.shields.io/github/license/shaojintian/Best_README_template.svg?style=flat-square
[license-url]: https://github.com/shaojintian/Best_README_template/blob/master/LICENSE.txt
[linkedin-shield]: https://img.shields.io/badge/-LinkedIn-black.svg?style=flat-square&logo=linkedin&colorB=555
[linkedin-url]: https://linkedin.com/in/shaojintian




