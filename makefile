SHELL := /bin/bash

OS := $(shell uname -s)

BLUE=\033[1;34m
GREEN=\033[1;32m
YELLOW=\033[1;33m
RED=\033[1;31m
NC=\033[0m


init: ## Run pub get + build_runner
	@echo -e "$(BLUE)👉 Running flutter pub get...$(NC)"
	flutter pub get
	@echo -e "$(BLUE)👉 Running build_runner...(NC)"
	dart run build_runner build --delete-conflicting-outputs
	@echo -e "$(GREEN)✅ Init completed successfully!$(NC)"

pub: ## Only flutter pub get
	@echo -e "$(BLUE)👉 Running flutter pub get...$(NC)"
	flutter pub get
	@echo -e "$(GREEN)✔ pub complete$(NC)"

gen: ## Only build_runner
	@echo -e "$(BLUE)👉 Generating code with build_runner...$(NC)"
	dart run build_runner build --delete-conflicting-outputs
	@echo -e "$(GREEN)✔ build_runner complete$(NC)"

watch: ## Watch build_runner continuously
	@echo -e "$(YELLOW)👀 Watching build_runner... Press CTRL+C to stop$(NC)"
	dart run build_runner watch --delete-conflicting-outputs

clean: ## Clean flutter project fully
	@echo -e "$(RED)🧹 Cleaning project...$(NC)"
	flutter clean
	@echo -e "$(BLUE)👉 Running pub get after clean...$(NC)"
	flutter pub get
	@echo -e "$(GREEN)✔ Clean & restore completed$(NC)"

format: ## Format all Dart code
	@echo -e "$(BLUE)✨ Formatting Dart code...$(NC)"
	dart format lib test
	@echo -e "$(GREEN)✔ Formatting done$(NC)"

doctor: ## Run flutter doctor
	@echo -e "$(BLUE)🩺 Running flutter doctor...$(NC)"
	flutter doctor

help: ## Show this help message
	@echo -e "\n${YELLOW}🚀 Available Make commands:${NC}\n"
	@grep -E '^[a-zA-Z_-]+:.*?##' Makefile | sed -E 's/:.*?##/: /' | column -t -s ':'
	@echo ""
