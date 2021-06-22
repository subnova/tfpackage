# Third-party dependencies fetched by Bazel
# Unlike WORKSPACE, the content of this file is unordered.
# We keep them separate to make the WORKSPACE file more maintainable.

# Install the nodejs "bootstrap" package
# This provides the basic tools for running and packaging nodejs programs in Bazel
load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")
def fetch_dependencies():
    http_archive(
        name = "build_bazel_rules_nodejs",
        sha256 = "0fa2d443571c9e02fcb7363a74ae591bdcce2dd76af8677a95965edf329d778a",
        urls = ["https://github.com/bazelbuild/rules_nodejs/releases/download/3.6.0/rules_nodejs-3.6.0.tar.gz"],
    )

    http_archive(
        name = "bazel_skylib",
        urls = [
            "https://github.com/bazelbuild/bazel-skylib/releases/download/1.0.3/bazel-skylib-1.0.3.tar.gz",
            "https://mirror.bazel.build/github.com/bazelbuild/bazel-skylib/releases/download/1.0.3/bazel-skylib-1.0.3.tar.gz",
        ],
        sha256 = "1c531376ac7e5a180e0237938a2536de0c54d93f5c278634818e0efc952dd56c",
    )

    http_archive(
        name = "io_bazel_rules_docker",
        sha256 = "59d5b42ac315e7eadffa944e86e90c2990110a1c8075f1cd145f487e999d22b3",
        strip_prefix = "rules_docker-0.17.0",
        urls = ["https://github.com/bazelbuild/rules_docker/releases/download/v0.17.0/rules_docker-v0.17.0.tar.gz"],
    )

    http_archive(
        name = "rules_pkg",
        urls = [
            "https://mirror.bazel.build/github.com/bazelbuild/rules_pkg/releases/download/0.4.0/rules_pkg-0.4.0.tar.gz",
            "https://github.com/bazelbuild/rules_pkg/releases/download/0.4.0/rules_pkg-0.4.0.tar.gz",
        ],
        sha256 = "038f1caa773a7e35b3663865ffb003169c6a71dc995e39bf4815792f385d837d",
    )

    http_archive(
        name = "io_bazel_rules_go",
        sha256 = "69de5c704a05ff37862f7e0f5534d4f479418afc21806c887db544a316f3cb6b",
        urls = [
            "https://mirror.bazel.build/github.com/bazelbuild/rules_go/releases/download/v0.27.0/rules_go-v0.27.0.tar.gz",
            "https://github.com/bazelbuild/rules_go/releases/download/v0.27.0/rules_go-v0.27.0.tar.gz",
        ],
    )

    http_archive(
        name = "bazel_gazelle",
        sha256 = "62ca106be173579c0a167deb23358fdfe71ffa1e4cfdddf5582af26520f1c66f",
        urls = [
            "https://mirror.bazel.build/github.com/bazelbuild/bazel-gazelle/releases/download/v0.23.0/bazel-gazelle-v0.23.0.tar.gz",
            "https://github.com/bazelbuild/bazel-gazelle/releases/download/v0.23.0/bazel-gazelle-v0.23.0.tar.gz",
        ],
    )

    # terraform
    _TERRAFORM_VERSION = "1.0.0"

    http_archive(
        name = "terraform_darwin",
        build_file_content = """exports_files(["terraform"])""",
        sha256 = "b67f5e25a73866b83880fd6fbc5e57add3ed893a31eda26b748aea4afc7255c4",
        urls = [
            "https://releases.hashicorp.com/terraform/%s/terraform_%s_darwin_amd64.zip" % (_TERRAFORM_VERSION, _TERRAFORM_VERSION)
        ],
    )

    http_archive(
        name = "terraform_linux",
        build_file_content = """exports_files(["terraform"])""",
        sha256 = "8be33cc3be8089019d95eb8f546f35d41926e7c1e5deff15792e969dde573eb5",
        urls = [
            "https://releases.hashicorp.com/terraform/%s/terraform_%s_linux_amd64.zip" % (_TERRAFORM_VERSION, _TERRAFORM_VERSION)
        ],
    )

    http_archive(
        name = "terraform_windows",
        build_file_content = """exports_files(["terraform.exe"])""",
        sha256 = "82ff30315a9d43c477adbf31dead4b3ff9f96415754f8e7dc22a481982e08098",
        urls = [
            "https://releases.hashicorp.com/terraform/%s/terraform_%s_windows_amd64.zip" % (_TERRAFORM_VERSION, _TERRAFORM_VERSION)
        ],
    )

    # tflint
    _TFLINT_VERSION = "v0.29.1"

    http_archive(
        name = "tflint_darwin",
        build_file_content = """exports_files(["tflint"])""",
        sha256 = "ba8493f37e75962ea7bac3c557113b021885b991aa2f3c3de7c50d123050f4dd",
        urls = [
            "https://github.com/terraform-linters/tflint/releases/download/%s/tflint_darwin_amd64.zip" % _TFLINT_VERSION
        ],
    )

    http_archive(
        name = "tflint_linux",
        build_file_content = """exports_files(["tflint"])""",
        sha256 = "797ad3cc1d29c0e6a19885c24c00cecc9def53fa4ab418583a82891cc36a979a",
        urls = [
            "https://github.com/terraform-linters/tflint/releases/download/%s/tflint_linux_amd64.zip" % _TFLINT_VERSION
        ],
    )

    http_archive(
        name = "tflint_windows",
        build_file_content = """exports_files(["tflint.exe"])""",
        sha256 = "78cc691bf7010400d93f7c9cf44110448230225099650bc0e6f2139d59badd6c",
        urls = [
            "https://github.com/terraform-linters/tflint/releases/download/%s/tflint_windows_amd64.zip" % _TFLINT_VERSION
        ],
    )