# Github Action



#### 예제

```yaml
name: camp_collector_action

# 해당 브랜치로 푸시했을 때 동작 실행
on:
  push:
    branches: [ main ]

  # Allows you to run this workflow manually from the Actions tab
  workflow_dispatch:

jobs:
  camp_collector_dist:
    runs-on: ubuntu-latest

    steps:
      - uses: actions/checkout@v2	# 이게 있으야 액션이 동작하는듯?

      # Runs a single command using the runners shell
      - name: Run a one-line script
        run: echo Hello, world!

      # Runs a set of commands using the runners shell
      - name: Run a multi-line script
        run: |
          echo Add other actions to build,
          echo test, and deploy your project.

```

