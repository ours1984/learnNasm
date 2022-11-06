# learNasm

```shell
make call  //生成执行流
make os    //生成内核
```

## [你好世界VGA绘制](https://blog.ours1984.top/posts/sets/)

![20221106221108](https://pic.ours1984.top/img/20221106221108.png!shuiyin)

```shell
cd os
make qemug m32=1 debug=1 //32位gdb调试
make bochs m64=1 //64位bochs启动
make build m32=1 //生成内核,不启动仿真
```

就是拿坐标,画直线,哈哈哈

![20221106221204](https://pic.ours1984.top/img/20221106221204.png!shuiyin)

.vocode文件夹配置了vscode调试信息

qemug启动调试后,vscode下直接F5可以远程调试

## [玩转系统执行流](https://blog.ours1984.top/posts/enterl/)

call文件夹下为汇编执行流学习代码,以及汇编32位64位和c相互调用

```shell
cd call
make m32=1 //32位实例
make m64=1 //64位实例
make m32=1 debug=1 //生成调试信息
```

## makefile学习

compile.mk编译生成可执行文件
comfig.mk组织文件夹

[学习 nasm 汇编](https://blog.ours1984.top/posts/huibian/)
