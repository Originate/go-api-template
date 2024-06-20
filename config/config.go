package config

import "github.com/Originate/go-utilities/configutilities"

type Config struct {
	Database configutilities.DatabasePostgresConfiguration `yaml:"database"`
	Gin      configutilities.GinConfiguration              `yaml:"gin"`
	Slog     configutilities.SlogConfiguration             `yaml:"slog"`
}
