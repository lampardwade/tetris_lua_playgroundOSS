# lua版俄罗斯方块

■游戏名
* 俄罗斯方块无消除版

■游戏规则
* 尽可能长时间的维持住方块不到底顶部

* 以坚持时间长短评价游戏技巧

■文件构成
* 基本在Tetris_lua该目录以下
* tetris.mp4 游戏录像
* tetris.apk 安卓设备执行文件
* 其他为Toboggan.exe来打开的元文件

* GameEngine-android目录下有部分build所需的asset文件

■代码构成
* item.lua 方块模具
* grid.lua 构成方块的四个子方块模具

备忘
lua第一次接触，
利用周末时间边学习边完成。游戏部分开发方法先用unity C#写了一遍带消除功能带一部分特殊UI的俄罗斯方块。然后循序渐进地用lua来移植改写，初期感想lua的数据结构管理等等方面比较特殊

tutorial例子以及Doc文档作为教学文案对此次开发有很大帮助，从环境构建到测试直至最后的编译制作apk

有时间的话想再细看下引擎底层代码



# Playground OSS

This is the 'Playground' game engine and is released in open source under Apache License v2.0.

 * All the needed documentation is in the /Doc folder.
 * Source code are under the /Engine folder.
 * Tool to compile a sample project is under /Tools folder.
 * Sample showing the scripting APIs are available under the /Tutorial folder.

Other folders (CSharpVersion, SampleProject) are more related to prototype features or detailed implementations.

To get started, please read the /Doc/Project.md

The dev team.

## Build Status
[![Build Status](https://travis-ci.org/KLab/PlaygroundOSS.png?branch=master)](https://travis-ci.org/KLab/PlaygroundOSS)


## LICENSE
'Playground OSS' is released under Apache Software License, Version 2.0 (Apache 2.0). Please refer http://www.apache.org/licenses/LICENSE-2.0 file for detail.


---------------------------------------------------------------------------
# tetris_lua_playgroundOSS
