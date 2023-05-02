# gofeatureflag-lint-action

<p align="center">
    <img width="250" height="238" alt="Go Feature Flag" src="https://github.com/thomaspoignant/go-feature-flag/raw/main/logo.png" />
    <h2 align="center">GoFeatureFlagLint</h2>
    <p align="center">Lint your feature flag config files.</p>
</p>

The `go-feature-flag/gofeatureflag-lint-action` Github action performs the
linting of the [gofeatureflag](https://gofeatureflag.org/) flag config file. It
checks for errors in the config file and returns the error message if any.

📢 Join Our Community: [![Slack](https://img.shields.io/badge/join-us%20on%20slack-gray.svg?longCache=true&logo=slack&colorB=green)](https://gophers.slack.com/messages/go-feature-flag)

## Usage

```yaml
on: [push]

jobs:
  gofeatureflag-lint-job:
    runs-on: ubuntu-latest
    name: A demo job to run gofeatureflag-lint on a config file
    steps:
      
      ## checkout the code from the repository
      - name: Checkout
        uses: actions/checkout@v3
      
      ## run the gofeatureflag-lint action
      - name: Lint the config file
        uses: go-feature-flag/gofeatureflag-lint-action@ea0524d562003105471e2ccdf3485e98db23fa48

        ## set the input parameters for the action
        with:
          flagFilePath: ${{ github.workspace }}/config/flag-config.yaml
          flagFiletype: 'yaml'
```

## Inputs

- `flagFilePath`: Provide the name and path of the config file. The default
  value for the input is `config/flag-config.yaml`.
- `flagFiletype`: The type of the config file. The default value for the input
  is `yaml`. The value can be `yaml`, `toml`, or `json`.

## Outputs

`lintMessage`: The value will be blank if no error is found. If an error is
found, the value will be the error message.

## License

This project is licensed under the MIT License.
