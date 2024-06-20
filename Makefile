export GOOSE_MIGRATION_DIR ?= ./database/migrations
export GOOSE_DRIVER ?= postgres
export GOOSE_DBSTRING ?= host=localhost port=5432 user=postgres password=postgres dbname=templateapi sslmode=disable

.SILENT:

run:
	if ! [ -f ./config/config.dev.yml ];    \
	then \
		go run ./main.go;    \
	else \
		go run ./main.go --config-file=./config/config.dev.yml;    \
	fi

# The name argument is specified as: make migration NAME="name-of-the-migration"
migration:
	goose create $(NAME) sql

migrations_up:
	goose up

migrations_up_by_one:
	goose up-by-one

# The version argument is specified as: make migrations_down_to VERSION="<name-of-migration>.sql"
migrations_up_to:
	goose up-to $(VERSION)

migrations_down:
	goose down

# The version argument is specified as: make migrations_down_to VERSION="<name-of-migration>.sql"
migrations_down_to:
	goose down-to $(VERSION)

db_status:
	goose status

reset_db:
	goose reset

watch:
	if ! [ -f ./config/config.dev.yml ];    \
	then \
		gow -c -v -r=false run ./main.go;    \
	else \
		gow -c -v -r=false run ./main.go --config-file=./config/config.dev.yml;    \
	fi

lint:
	golangci-lint run --allow-parallel-runners --fix

test:
	go test ./internal/... -race -coverprofile=fmt.coverage

