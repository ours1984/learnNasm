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
make qemug64 m64=1 debug=1 //64位gdb+qemu启动,graphic画图暂时有问题
make build m32=1 //生成内核,不启动仿真
```

就是拿坐标,画直线,哈哈哈

![20221106221204](https://pic.ours1984.top/img/20221106221204.png!shuiyin)

.vocode文件夹配置了vscode调试信息,gdb64为64位调试.

64 bit下graphic暂时有问题,屏蔽掉(不调用接口)才能正常运行

qemug启动调试后,vscode下直接F5可以远程调试

## [玩转系统执行流](https://blog.ours1984.top/posts/enterl/)

call文件夹下为汇编执行流学习代码,以及汇编32位64位和c相互调用

```shell
cd call
make m32=1 //32位实例
make m64=1 //64位实例 graphic暂未适配64位
make m32=1 debug=1 //生成调试信息
```

## makefile学习

compile.mk编译生成可执行文件
comfig.mk组织文件夹

[学习 nasm 汇编](https://blog.ours1984.top/posts/huibian/)
