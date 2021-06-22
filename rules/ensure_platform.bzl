def _platform_transition(settings, attrs):
    _ignore = (settings)
    return {"//command_line_option:platforms": attrs.platforms}

platform_transition = transition(
    implementation = _platform_transition,
    inputs = [],
    outputs = ["//command_line_option:platforms"],
)

def _ensure_platform(ctx):
    return [DefaultInfo(files = ctx.attr.dep[0][DefaultInfo].files)]

ensure_platform = rule(
    implementation = _ensure_platform,
    attrs = {
        "dep": attr.label(cfg = platform_transition, allow_files = True),
        "platforms": attr.string(),
        "_whitelist_function_transition": attr.label(
            default = "@bazel_tools//tools/allowlists/function_transition_allowlist"
        ),
    })