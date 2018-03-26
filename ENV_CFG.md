## ENVFILE


.env の項目について説明します。  
city.env.sampleをコピーしてご利用ください。  
ファイル名は任意ですが、複数拠点を同時に動かす場合は区別しやすいよう、  
地域名.envとすることをおすすめします（例：yokohama.env）

マニュアル上でも、地域名.env（`{$region}.env`）として進めます。

### 共通設定

key|value
---|---
LG_SCSS_COMPILE_PARAM  |  Scssコンパイラ用キー（10文字程度の任意の英数字）
LG_GOOGLE_ANALYTICS_WP  |  Google Analytics トラッキングID（WordPress用）
LG_GOOGLE_ANALYTICS_GT  |  Google Analytics トラッキングID（Goteo用）
LG_BASE_URL_WP  |  WordPressのベースURL
LG_BASE_URL_GT  |  GoteoのベースURL

### WordPress 向け設定

key|value
---|---
WORDPRESS_DB_HOST  |  データベースホストアドレス
WORDPRESS_DB_NAME  |  データベース名
WORDPRESS_DB_USER  |  データベース接続ユーザー名
WORDPRESS_DB_PASSWORD  |  データベース接続パスワード

### Goteo 向け設定

key|value
---|---
LG_OMNICONFIG_JSON_FILE  |  apikeys.json へのパス（通常は変更不要です）
SRC_URL  |  GoteoリソースURL（通常は LG_BASE_URL_GT からプロトコルをはずしたものでOK）
GOTEO_DB_CHARSET  |  データベースキャラクターセット
GOTEO_DB_HOST  |  データベースホストアドレス
GOTEO_DB_USERNAME  |  データベース接続ユーザー名
GOTEO_DB_PASSWORD  |  データベース接続パスワード
GOTEO_DB_PORT  |  データベース接続ポート
GOTEO_DB_SCHEMA  | データベース名
COMMON_AUTH_DB_SCHEMA  |  アカウント管理用データベース名（基本的には gt_lg-common で固定）
CRON_PARAM  |  Cron実行用のキー（10文字前後の任意の文字列）
CRON_VALUE  |  上記キーとセットとなる値（上記と異なる10文字前後の任意の文字列）
GOTEO_MAIL_FROM  |  
GOTEO_FAIL_MAIL  |  
GOTEO_LOG_MAIL  |  
GOTEO_MAIL_NAME  |
GOTEO_MAIL  |  
GOTEO_CONTACT_MAIL  |

### SNS関係の設定

key|value
---|---
OAUTH_FACEBOOK_ID  |  Facebook ログイン用 APP ID
OAUTH_FACEBOOK_SECRET  |  Facebook ログイン用 APP SECRET
OAUTH_TWITTER_ID  |  Twitter ログイン用 APP ID
OAUTH_TWITTER_SECRET  |  Twitter ログイン用 APP SECRET

### AWS関連の設定

#### SES

key|value
---|---
AWS_SES_ACCESS  |  アクセスキー
AWS_SES_SECERET  |  シークレットアクセスキー
AWS_SES_CHARSET  |  文字コード
AWS_SES_SOURCE  |  


#### AWS アクセスキー

key|value
---|---
DBI_AWS_ACCESS_KEY_ID  | アクセスキー
DBI_AWS_SECRET_ACCESS_KEY  |  シークレットアクセスキー

#### S3

key|value
---|---
STATIC_S3_BUCKET_NAME  |  バケット名
STATIC_S3_VERSION  |  バージョン指定
STATIC_S3_REGION  |  リージョン指定
STATIC_SVR_DOMAIN  |  S3サーバーアドレス

### その他
key|value
---|---
GOTEO_LOCATION_NAMES  |  地域名（表示したい順にカンマ区切り）
EPSILON_CONTRACT_CODE  | EPSILON 認証コード
