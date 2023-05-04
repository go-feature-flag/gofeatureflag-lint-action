# gofeatureflag-lint-action

<p align="center">
    <img width="250" height="238" alt="Go Feature Flag" src="https://github.com/thomaspoignant/go-feature-flag/raw/main/logo.png" />
    <h2 align="center">GoFeatureFlagLint</h2>
    <p align="center">Lint your feature flag config files</p>
</p>

The `go-feature-flag/gofeatureflag-lint-action` Github action performs the
linting of the [GO Feature Flag](https://gofeatureflag.org/) flag config file. It
checks for errors in the config file and returns the error message if any.

📢 Join Our Community: [![Slack](https://img.shields.io/badge/join-us%20on%20slack-gray.svg?longCache=true&logo=slack&colorB=green)](https://gophers.slack.com/messages/go-feature-flag)

## Usage 📝

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
        uses: go-feature-flag/gofeatureflag-lint-action@v1

        ## set the input parameters for the action
        with:
          flag-file: ./config/flag-config.yaml
          format: yaml
```

## Inputs ⚙️

| **Name** | **Required** | **Defaults**  | **Description**  |
|:-----:|:-----:|:-----:|:-----:|
|  flag-file     | false      | `config/flag-config.yaml`  | Absolute or relative path of the file with name  |
|   format    | false      | `yaml`  | config file of type `yaml`, `toml`, or `json`  |

## Outputs ✉️

| **Name** | **Description**  |
|:-----:|:-----:|
|  lint-message     | `empty` if no error is found, else the value will be the error message  |

## Share the Love ❤️

Like this project? Please give it a ★ on our GitHub!

## License 💳

This project is licensed under the MIT License.
