# README

## アプリケーション名 「Tamemol」

### 概要
「Tamemol」は毎日のちょっとした無駄遣いをなくすためのWebアプリケーションです。<br>
何か欲しいものやプレゼントを誰かにする際にその商品が高価であった際は貯金をする必要があります。<br>
しかしお菓子やジュースなどちょっとした買い物をついしてしまい、なかなかと貯金ができないといった人のためのアプリケーションがこの「Tamemol」です。<br>
我慢したものの商品名や金額を入力して保存することで自分がどれくらい我慢したのかということを確認でき、その人の我慢を手助けします。<br>

### 使用言語
Ruby (フレームワーク Ruby on Rails)<br>
HTMl<br>
CSS (フレームワーク Bootstrap)<br>
開発環境 Cloud9<br>

### 機能
新規登録、ログイン機能<br>
CRUD機能<br>
月の我慢する目標金額を設定し、現在の進行状況の表示<br>
ユーザー一覧<br>
「我慢したもの、買ったもの」一覧画面<br>

### 使用方法
今回作成したWebアプリケーションの使用方法を説明します。
ユーザーはまずなにか買うのを我慢した際に、「記録する」というボタンを押します。すると商品名や金額が入力できるフォーム画面に遷移し、記録します。<br>
一覧ページでは「我慢したもの」と「一度は我慢したが、買ってしまったもの」の二つのテーブルが存在し、入力された段階では「我慢したもの」に振り分けられます。<br>
もし一度は我慢したものの、買ってしまったという場合は、「買った」というボタンを押すことで別のテーブルに振り分けられます。<br>
テーブルは1ヶ月ごとに登録したデータが自動で切り替わる仕組みになっており、ユーザーが任意の月に切り替えることもできます。<br>
ユーザーは月にどれくらい我慢するかという目標を設定することができ、目標に対してどのくらい我慢したかという達成率も確認することができます。<br>
トップページでは「我慢したもの」と「買ってしまったもの」をそれぞれ計算し、一目で理解できるようにしています。<br>
またほかのユーザーの我慢金額も確認することができ、我慢の頑張りを共有しながら貯金することができます。<br>

### 苦労した点
DBに保存された商品をどのようにして「我慢したもの」と「買ってしまったもの」という二つに分けるかということにとても苦労しました。<br>
加えてその二つを別々に計算して、Viewに表示するため、データの区別や管理に時間がかかりました。<br>
今回のWebアプリケーションの場合、1ヶ月単位で表示するデータを切り替えるように設計する必要があったため、どのようにしてViewを切り替えるのかという部分も工夫しました。<br>
またユーザーが一目で自分の我慢金額や進捗状況を理解するためにはどのようにレイアウトをするべきかということに注意しました。<br>