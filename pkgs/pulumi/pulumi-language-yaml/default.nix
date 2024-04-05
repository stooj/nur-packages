{
    lib,
    buildGoModule,
    fetchFromGitHub,
    pulumi,
}:
buildGoModule rec {
    pname = "pulumi-language-yaml";
    version = "1.6.0";

    src = fetchFromGitHub({
            owner = "pulumi";
            repo = "pulumi-yaml";
            rev="v${version}";
            fetchSubmodules = false;
            sha256 = "sha256-ubat51dNGWa+A0H8g9KZPmn6sz12/MJJvGsl9D+fjJg=";
            });

    vendorHash = "sha256-euzPnHbT/Dy/wB0qtLuFg2skdgUwSf2Gpmx04Z9IIik=";
    sourceRoot = "${src.name}";

    nativeBuildInputs = [ pulumi ];

    disabledTests = [
        # Uses cached schema path
        "TestGenerateExamples"
        "TestProjectConfigWithSecretDecrypted"
        "TestExamplePulumiVariable"
        "TestRandom"
        "TestTypeCheckError"
        "TestMismatchedConfigType"
        "TestProjectConfigRef"

    ];

    preCheck = ''
        # Code generation tests download dependencies from network
        rm pkg/pulumiyaml/codegen/*_test.go
        buildFlagsArray+=("-run" "[^(${lib.concatStringsSep "|" disabledTests})]")
    '';

    ldflags = [
        "-s"
        "-w"
        "-X github.com/pulumi/pulumi/sdk/v3/go/common/version.Version=${version}"
    ];
}
