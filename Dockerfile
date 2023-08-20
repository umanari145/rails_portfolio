FROM ruby:3.0.3
 
# ビルド時に実行するコマンドの指定
# インストール可能なパッケージの一覧の更新
RUN apt-get update -qq \
# パッケージのインストール（nodejs、postgresql-client、npmを指定）
&& apt-get install -y nodejs postgresql-client npm \
&& rm -rf /var/lib/apt/lists/* \
&& npm install --global yarn
 
# 作業ディレクトリの指定
# 作業ディレクトリの作成、設定
RUN mkdir /app_name 

# 作業ディレクトリ名をAPP_ROOTに割り当てて、以下$APP_ROOTで参照
ENV APP_ROOT /app_name 
WORKDIR $APP_ROOT

# ホスト側（ローカル）のGemfileを追加する（ローカルのGemfileは【３】で作成）
ADD ./Gemfile $APP_ROOT/Gemfile
ADD ./Gemfile.lock $APP_ROOT/Gemfile.lock

# Gemfileのbundle install
RUN bundle install
ADD . $APP_ROOT