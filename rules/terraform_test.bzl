load("@io_bazel_rules_go//go:def.bzl", "go_test")

def terraform_validate_test(name, srcs, terraform_binary = "//:terraform", **kwargs):
    "A macro to run terraform validate on a set of sources"

    go_test(
        name = name,
        srcs = ["//rules:terraform_test/validate.go"],
        data = srcs + [terraform_binary],
        deps = [
            "@com_github_gruntwork_io_terratest//modules/terraform",
            "@io_bazel_rules_go//go/tools/bazel:go_default_library",
        ],
        **kwargs,
    )