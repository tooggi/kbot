# kbot

## Description
kbot is a simple Telegram bot written in Go. Its main functionality is to echo back any messages it receives from users.

## Features
- Echoes any text message sent to the bot.
- Built using the [telebot](https://github.com/tucnak/telebot) library for Go.

## Usage
Start a chat with the bot on Telegram and send any message. The bot will reply with the same message.

Link to the bot: https://t.me/etgkk_bot

## Pre-commit Gitleaks Hook
This repository includes an optional pre-commit hook that scans staged changes for secrets using Gitleaks.

#### Enable the hook
To enable Git hooks for this repository, run:

````bash
git config core.hooksPath .githooks
````

Then enable the Gitleaks pre-commit hook:

````bash
git config pre-commit-gitleaks.enable true
````

## License
This project is licensed under the MIT License.
