# kippu-payment

Kippu の **payment-service**（決済・返金 + Fake PSP）。Go + gRPC。

## 必要なもの

| ツール | バージョン |
|---|---|
| Go | 1.27.x（`go.mod` の `go` ディレクティブに従う） |
| buf / sqlc / golang-migrate / golangci-lint / grpcurl | 最新 |

## よく使うコマンド

```bash
make help       # ターゲット一覧
make run        # サーバ起動（:50053）
make test       # 全テスト
make lint       # golangci-lint
```

## ディレクトリ構成

```
cmd/server/            エントリポイント
internal/domain/       ドメイン層（集約・値オブジェクト・リポジトリ IF）
internal/application/  アプリケーション層（ユースケース）
internal/infrastructure/ インフラ層（Postgres / メッセージング）
internal/presentation/ プレゼンテーション層（gRPC ハンドラ / コンシューマ）
proto/                 protobuf 定義
gen/                   buf の生成コード（コミットする）
db/migrations/         マイグレーション
db/queries/            sqlc 用 SQL
docs/adr/              ADR
```
