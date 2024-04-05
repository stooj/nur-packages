{
    buildGoModule,
    fetchFromGitHub,
}:
buildGoModule rec {
    pname = "pulumi-language-java";
    version = "0.10.0";

    src = fetchFromGitHub({
            owner = "pulumi";
            repo = "pulumi-java";
            rev="v${version}";
            fetchSubmodules = false;
            sha256 = "sha256-Kfbyu5sHVxwkKhoEhHlG4ZVFKu103jU2bbbYsRnSeNw=";
            });

    vendorHash = "sha256-Cz0lzE7rSYOymuIXBMsYMYfWCy9kWuHGd1aFJAIrlNw";
    sourceRoot = "${src.name}/pkg";

    preCheck = ''
        # Code generation tests download dependencies from network
        rm codegen/java/*_test.go
    '';

    ldflags = [
        "-s"
        "-w"
        "-X github.com/pulumi/pulumi/sdk/v3/go/common/version.Version=${version}"
    ];
}
