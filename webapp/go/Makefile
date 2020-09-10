export GO111MODULE=on

all: build

# 【必須】アプリケーションの起動のために必要
# ライセンスキーは Account Settings -> Summary から取得できます。
# シェルで環境変数としてセットしておくとその値が使用されます。
export NEW_RELIC_LICENSE_KEY#=abfdef

# 【任意】デプロイメントマーカーを記録するために必要
# REST API キーは Account Settings -> API keys から取得できます。
# シェルで環境変数としてセットしておくとその値が使用されます。
export NEW_RELIC_APP_KEY#=abcdef

# 【任意】デプロイメントマーカーを記録するために必要
# App ID は APM -> 各アプリケーション -> (i) マーク から取得できます。
# シェルで環境変数としてセットしておくとその値が使用されます。
# App ID を指定してデプロイする（ローカル向け）:
# make deploy NEW_RELIC_APP_ID=100000000
export NEW_RELIC_APP_ID#=100000000

# ds2 にデプロイする:
# make deploy HOST=ds2
HOST=ds1

TARGET=./isucari
SERVICE_NAME=isucari
DEPLOY_PATH=/home/isucon/go/src/github.com/isucon/isucon9-qualify/webapp/go/isucari

build: *.go
	go build -o ${TARGET}

run: build
	${TARGET}

deploy: build
	scp ${TARGET} "root@${HOST}:${DEPLOY_PATH}"
	ssh "root@${HOST}" "chown isucon:isucon ${DEPLOY_PATH}"
	./mark-deploy.sh
	ssh "root@${HOST}" "systemctl restart ${SERVICE_NAME}"

mark:
	./mark-deploy.sh

restart:
	ssh "root@${HOST}" "systemctl restart ${SERVICE_NAME}"
