# gofeatureflag-lint-action

<p align="center">
    <img width="250" height="238" alt="Go Feature Flag" src="https://github.com/thomaspoignant/go-feature-flag/raw/main/logo.png" />
    <h2 align="center">GoFeatureFlagLint</h2>
    <p align="center">Lint your feature flag config files.</p>
</p>

This action will perform the linting of the gofeatureflag config file.

📢 Join Our Community: [![Slack](https://img.shields.io/badge/join-us%20on%20slack-gray.svg?longCache=true&logo=slack&colorB=green)](https://gophers.slack.com/messages/go-feature-flag)

## Inputs

- `flag-file`: The location of the GO Feature Flag configuration flag to lint. The default value is `flag-file.yaml`.
- `format`: The format of your GO Feature Flag configuration flag (`yaml`, `toml`, `json`). The default value is `yaml`.

## Outputs
- `lint-message`: The value will be blank if no error is found. If an error is found, the value will be the error message.
- 
## Example usage
```yaml
on: [push]

jobs:
  feature-flag-lint:
    runs-on: ubuntu-latest
    name: A job to say hello
    steps:
      # To use this repository's private action,
      # you must check out the repository
      - name: Checkout
        uses: actions/checkout@v3
      - name: Linting GO Feature Flag config file
        uses: go-feature-flag/gofeatureflag-lint-action@v1
        with:
          flag-file: flag-file.yaml
          format: yaml
```

## License
This project is licensed under the MIT License.
