// Command server は payment-service の gRPC サーバのエントリポイントです。
//
// いまは雛形なので起動ログを出して終了するだけです。
// gRPC サーバ（health / reflection / graceful shutdown）は S-04 で実装します。
package main

import (
	"log/slog"
	"os"
)

func main() {
	logger := slog.New(slog.NewJSONHandler(os.Stdout, nil))
	slog.SetDefault(logger)

	port := os.Getenv("GRPC_PORT")
	if port == "" {
		port = "50053"
	}

	slog.Info("payment-service: not implemented yet (see S-04)", "grpc_port", port)
}
