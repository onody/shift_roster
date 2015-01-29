Shift Roster
====


## Description

職場のシフト作成プログラム。

* 1ヶ月、6人でのシフト
* 実装には遺伝的アルゴリズムを利用
  * サンプルを10セット作る
  * ルールに沿って、セットそれぞれに点数をつける
  * 下から2つのサンプルは淘汰される（削除される）
  * 上位2位のサンプルを交叉、突然変異させた子ども2人をサンプルに追加
  * 1000回繰り返して、1位のサンプルを表示

## TODO

* 評価が甘いので修正する
* 1000回で結果を得るのではなく、一定の点数に達するまでに修正する


## Author

[onody](https://github.com/onody)