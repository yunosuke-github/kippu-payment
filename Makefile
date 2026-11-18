GRPC_PORT    ?= 50053
DATABASE_URL ?= postgres://payment_svc:payment_svc@localhost:5432/payment_db?sslmode=disable

export GRPC_PORT

.PHONY: help run test test-unit lint fmt tidy gen migrate-new migrate-up migrate-down

help: ## ターゲット一覧を表示
	@grep -E '^[a-zA-Z_-]+:.*?## ' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "  \033[36m%-14s\033[0m %s\n", $$1, $$2}'

run: ## gRPC サーバを起動
	go run ./cmd/server

test: ## 全テスト（race 検出あり）
	go test ./... -race -count=1

test-unit: ## ドメイン層・アプリケーション層の単体テスト
	go test ./internal/domain/... ./internal/application/... -count=1

lint: ## golangci-lint
	golangci-lint run ./...

fmt: ## gofmt / goimports
	golangci-lint fmt ./...

tidy: ## go mod tidy
	go mod tidy

gen: ## buf lint + buf generate + sqlc generate（設定ファイルを置いてから使う）
	buf lint && buf generate && sqlc generate

migrate-new: ## マイグレーション作成 例: make migrate-new name=create_events
	migrate create -ext sql -dir db/migrations -seq $(name)

migrate-up: ## マイグレーション適用
	migrate -path db/migrations -database "$(DATABASE_URL)" up

migrate-down: ## マイグレーションを 1 つ戻す
	migrate -path db/migrations -database "$(DATABASE_URL)" down 1
