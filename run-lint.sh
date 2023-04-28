## Get the latest image of go-feature-flag-lint
docker pull thomaspoignant/go-feature-flag-lint:latest

## Run the linter against the config file
docker run -v ${pwd}/config:/config --rm --name gofeatureflag_lint thomaspoignant/go-feature-flag-lint --input-format=yaml --input-file=/config/flag-config.yaml
