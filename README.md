# Lein

Cloud Supporter System.

## Local Setting

### GitHub上でFork

    https://github.com/shu0115/lein

### リポジトリをローカルへ作成

    $ cd ~/WORK_DIRECTORY
    $ git clone git@github.com:YOUR_USER_NAME/lein.git
    $ cd lein

### ブランチ作成

    $ git checkout -b YOUR_NEW_BRANCH

### Twitterアプリ登録

<a href="https://dev.twitter.com/apps/new" target="_blank">Twitter Create an application</a>

    Name: [ (アプリケーションの名前) ]
    Description: [ (アプリケーションの説明) ]
    WebSite: [ http://0.0.0.0:3000/ ]
    Callback URL: [ http://0.0.0.0:3000/ ] ※登録しないと動かない

    □ Yes, I agree <= チェック

    CAPTCHA入力後「Create your Twitter application」を押下

### ローカル用Twitterキー設定

Create: config/initializers/local_setting.rb

    # Twitter OAuth Local Setting
    ENV['TWITTER_KEY'] = "YOUR_CONSUMER_KEY"
    ENV['TWITTER_SECRET'] = "YOUR_CONSUMER_SECRET"

※Twitterアプリ登録完了後に表示された「Consumer key」を「YOUR_CONSUMER_KEY」に、「Consumer secret」を「YOUR\_CONSUMER_SECRET」にそれぞれ入力

### Rails起動

Gemインストール

    bundle install --without production
  
ローカルDB作成

    rake db:migrate

ローカルサーバ起動

    bundle exec rails s

ページアクセス

    http://0.0.0.0:3000/

## Copyright

Copyright (c) 2012 Shun Matsumoto. <a href="http://creativecommons.org/licenses/by-nc-sa/2.1/jp/" target="_blank">CC BY-NC-SA 2.1</a>
