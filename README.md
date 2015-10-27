# Boilerplate

## インストール

これにより、`npm-bp`コマンドを有効にします。

```bash
$ npm install 59naga/boilerplate --global
```

## プロジェクトの自動生成

`npm-bp`で指定したパッケージ名で__ファイル群の文字列を置換し__、パッケージ名のフォルダへ展開します。
またその際、`npm install`を自動で実行します。

```bash
$ npm-bp bland-new-package

# Generating the bland-new-package .................. done
# bland-new-package
# ├─ README.md
# ├─ bower.json
# ├─ index.coffee
# ├─ node_modules
# │  ├─ ghooks
# │  ├─ jasminetea
# │  └─ object-parser-cli
# ├─ package.json
# ├─ src
# │  └─ index.coffee
# └─ test
#     └─ api.spec.coffee
# 
# Generated /Users/59naga/Downloads/bland-new-package
```

```bash
cd bland-new-package
```

`59naga`や`59798`など、著者情報は置換されない点に注意して下さい。これは、レポジトリをフォークして該当ファイルを修正、`npm install`時の名前を自分のリポジトリ名に修正することで解決できます。

### `npm start`

`test/index.coffee`を`node-jasmine`にコンパイルして渡します。
`.`,`src`,`test`内の`.coffee`の変更を検知して、テストを再実行します。
BDDに有効です。

### `npm test`

テストを実行後、`ibrik`でカバレッジを計測し、`coffeelint`で文法チェックを行います。

`.travis.yml`か`COVERALLS_REPO_TOKEN`が適切であれば、カバレッジレポートを`coveralls.io`に自動で送信します。

```bash
npm test

# > jasminetea --file index.coffee --lint --cover --report
# ...
# 1 spec, 0 failures
# Finished in 0 seconds
# ...
# =============================== Coverage summary ===============================
# Statements   : 100% ( 9/9 )
# Branches     : 100% ( 0/0 )
# Functions    : 100% ( 4/4 )
# Lines        : 100% ( 5/5 )
# ================================================================================
# ...
# ✓ Ok! » 0 errors and 0 warnings in 2 files
```

### `git commit`

`ghooks`により`npm test`が自動実行されます。これが通らない限り、コミットはキャンセルされます。

### `npm run client-setup`

npm scriptsの`client-setup`以下のスクリプトを有効にするために必要です。
bower.json内の`opc-scripts install`で定義された依存モジュールをインストールします。
`browserify`, `chokidar`など、インストール時間を要するものを含むため、これは数十秒掛かります。

### `npm run localhost`

`src/index.coffee`を`coffeeify`で変換し、`zuul`を使用してブラウザ上でテストが通るか確認します。

また、test内で使用したfs.readFileSyncなどは、`brfs`によってBufferインスタンスに変換されてから、実行する点に注意してください。

### `npm run test-cloud`

saucelabs上でブラウザ上のテストが通るか確認します。使用するブラウザは`zuul.yml`の`browsers`で定義した内容です。
環境変数`SAUCE_USERNAME`, `SAUCE_ACCESS_KEY`を使用します。
詳しくは`defunctzombie/zuul`のwiki内を参照してください。

### `npm run build`

bower.jsonの`name`に`.min.js`を加えたファイル名で、`coffeeify`の結果を保存します。

```bash
npm build

# > $(opc bower opc-scripts.build) | exorcist $(opc bower name).js.map -b . > $(opc bower name).js
# > $(opc bower opc-scripts.uglify)
# > rm $(opc bower name).js $(opc bower name).js.map && wc -c $(opc bower main)
# 
#      928 bland-new-package.min.js
```

`opc ***`はUNIX用のコマンド生成コマンドで、`$()`内を実行することで、windows用に変換することも可能です。
`opc`コマンドが存在しない場合、`npm install object-parser-cli --global`で解決できます。

# TravisCI上の環境変数

以下のようにして、`.travis.yml`に暗号化して埋め込みます。`travis encrypt`後は、`.yml`の書式が崩れてしまうので、暗号化されたTOKENの行だけコピーして、`git checkout`するなどした方が良いかもしれません。

```bash
open https://travis-ci.org/profile/ # to Enable repository

subl ~/.npmrc
# copy the authTokenValue -> registry.npmjs.org/:_authToken=********-****-****-****-************
travis encrypt --add deploy.api_key
# paste `********-****-****-****-************`
# ^D^D

open https://coveralls.io/repos/new
travis encrypt COVERALLS_REPO_TOKEN=* --add
# or...
open https://codeclimate.com/dashboard # setting>test coverage
travis encrypt CODECLIMATE_REPO_TOKEN=* --add

# https://docs.saucelabs.com/ci-integrations/travis-ci/
travis encrypt SAUCE_USERNAME=* --add
travis encrypt SAUCE_ACCESS_KEY=* --add
```

License
---
[MIT][License]

[License]: http://59naga.mit-license.org/
