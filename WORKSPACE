# Bazel workspace created by @bazel/create 3.6.0

# Declares that this directory is the root of a Bazel workspace.
# See https://docs.bazel.build/versions/master/build-ref.html#workspace
workspace(
    # How this workspace would be referenced with absolute labels from another workspace
    name = "tfpackage",
    # Map the @npm bazel workspace to the node_modules directory.
    # This lets Bazel use the same node_modules as other local tooling.
    managed_directories = {"@npm": ["node_modules"]},
)

load("//tools:bazel_deps.bzl", "fetch_dependencies")

fetch_dependencies()

load("@bazel_skylib//:workspace.bzl", "bazel_skylib_workspace")

bazel_skylib_workspace()

# rules_nodejs

# The npm_install rule runs yarn anytime the package.json or package-lock.json file changes.
# It also extracts any Bazel rules distributed in an npm package.
load("@build_bazel_rules_nodejs//:index.bzl", "npm_install")

npm_install(
    # Name this npm so that Bazel Label references look like @npm//package
    name = "npm",
    exports_directories_only = True,
    package_json = "//:package.json",
    package_lock_json = "//:package-lock.json",
)

# rules_pkg
load("@rules_pkg//:deps.bzl", "rules_pkg_dependencies")

rules_pkg_dependencies()

# rules_go
# gazelle:repo bazel_gazelle
load("@io_bazel_rules_go//go:deps.bzl", "go_register_toolchains", "go_rules_dependencies")
load("@bazel_gazelle//:deps.bzl", "gazelle_dependencies")
load("//:deps.bzl", "go_dependencies")

# gazelle:repository_macro deps.bzl%go_dependencies
go_dependencies()

go_rules_dependencies()

go_register_toolchains(version = "1.15.6")

gazelle_dependencies()

# rules_docker
load(
    "@io_bazel_rules_docker//repositories:repositories.bzl",
    container_repositories = "repositories",
)

container_repositories()

load("@io_bazel_rules_docker//repositories:deps.bzl", container_deps = "deps")

container_deps()

load(
    "@io_bazel_rules_docker//nodejs:image.bzl",
    nodejs_image_repositories = "repositories",
)

nodejs_image_repositories()

load(
    "@io_bazel_rules_docker//go:image.bzl",
    go_image_repos = "repositories",
)

go_image_repos()