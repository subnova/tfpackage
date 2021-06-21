"Macro for executing tests with Jest"

load("@npm//jest-cli:index.bzl", _jest_test = "jest_test")

def jest_test(name, srcs, deps, jest_config = "//:jest.config.js", **kwargs):
    "A macro around the autogenerate jest_test rule"
    templated_args = [
        "--no-cache",
        "--no-watchman",
        "--ci",
        "--colors",
        "--maxWorkers",
        "1",
    ]
    templated_args.extend(["--config", "$(rootpath %s)" % jest_config])

    data = [jest_config] + srcs + deps

    _jest_test(
        name = name,
        data = data,
        templated_args = templated_args,
        **kwargs,
    )
