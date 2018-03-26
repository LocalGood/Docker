# LocalGood 開発用 Docker コンテナ

LocalGoodをローカルで立ち上げるためのコンテナ一式です。  
起動するには [Docker](https://www.docker.com/) が動作する環境と、  
[Amazon Web Services(aws)](https://aws.amazon.com/)のアカウントが必要です。

## インストール

```
cd /PATH/TO/YOUR_PROJECT_ROOT/
git clone https://github.com/LocalGood/Docker.git
```

## 設定

### はじめに

LocalGoodではAWSの以下のサービスを利用しています。  
起動するためにはAWSアカウント及びこれらのサービスのアクセスキーの取得及び設定が必要になります。

- [Amazon Relational Database Service (RDS)](https://aws.amazon.com/jp/rds/)
- [Amazon Simple Storage Service (S3)](https://aws.amazon.com/jp/s3/)
- [Amazon Simple Email Service (SES)](https://aws.amazon.com/jp/ses/)

取得した各種アクセスキーは、次に説明する .env ファイルの中で設定してください。

> `${region}` は作成したい地域名（半角英数）に置き換えてください。  
> 一部ファイル名の指定がされている場所において、仕様上は他の名前でも問題ない場合もありますが、  
> サービス全体のネーミングルールに沿った書き方になるので統一してください。

### .env ファイルの準備

拠点用の各種設定をまとめた .env ファイルを用意します。  
City.sample.env をコピーし、立ち上げたい都市名.env などにリネームしてから  
パラメータを埋めていってください。  
パラメータの詳細は [ENV_CFG.md](ENV_CFG.md) を参照してください。

> .env ファイルにはデータベースのパスワードやAWSのアクセスキーなど、重要な情報が含まれています。
> 取り扱いには十分注意してください。

### docker-compose.yml の修正

docker-compose.yml に以下のセクションを追加します。

```yaml
# ==========================
# LOCALGOOD ${region}
# ==========================
  goteo_${region}:
    build:
        context: ./build/goteo
    volumes:
      - ./volumes/var/www/html/goteo/${region}:/var/www/html
      - ./volumes/var/www/html/omniconfig/${region}:/var/www/html/omniconfig
    env_file:
      - ./${region}.env
    restart: always

  wp_${region}:
    build:
      context: ./build/wp
    volumes:
      - ./volumes/var/www/html/wordpress/${region}:/var/www/html
      - ./volumes/var/www/html/omniconfig/${region}:/var/www/html/omniconfig
    env_file:
      - ./${region}.env
    restart: always
```

次に、`web` ブロックの volumes と depends_on を修正します。

> 既に他の地域用に立ち上がっているなどの理由で値が入っている場合はその設定に続けて追記してください。

```yaml
  web:
    volumes:
      - ./volumes/var/www/html/omniconfig/${region}:/var/www/html/goteo/${region}/omniconfig     # 追加
      - ./volumes/var/www/html/omniconfig/${region}:/var/www/html/wordpress/${region}/omniconfig # 追加
    depends_on:
      - wp_${region} # 追加
      - wp_${region} # 追加
```

### nginx 設定の追加

`volumes/etc/nginx/conf.d/`以下にnginx(webサーバー)の設定を追加します。  
（行番号は設定ファイルのバージョンによって前後する場合があります。）  
ファイル名はそれぞれ、`goteo_${region}.conf`と`wp_${region}.conf`としてください。

#### goteo_${region}.conf

**2行目付近：server_name**

    公開するサイトのドメインを入力してください。

**43行目付近：root**

    /var/www/html/goteo/${region};


**60行目付近：fastcgi_pass**

    goteo_${region}:9000

#### wp_${region}.conf

**2行目付近：server_name**

    公開するサイトのドメインを入力してください。

**47行目付近：root**

    /var/www/html/wordpress/${region};

**64行目付近：fastcgi_pass**

    wp_${region}:9000

----

## 起動と停止

### 起動

```sh
cd /PATH/TO/docker-compose.yml
docker-compose up -d
```

### 停止

```sh
cd /PATH/TO/docker-compose.yml
docker-compose stop
```

上記以外の docker-compose の使い方についてはここでは触れませんので、以下を参照してください。
https://docs.docker.com/compose/reference/overview/


## アクセスする前に

ローカルで起動したコンテナにアクセスするには、hosts ファイルの書き換えが必要になります。  
上記、nginxの設定で追加した server_name のドメインが localhost を見るように修正を行ってください。

例：server_name が city.localgood.jp の場合

```
127.0.0.1 city.localgood.jp
127.0.0.1 cf.city.localgood.jp
```
