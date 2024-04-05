{ buildGoModule,
  fetchFromGitHub,
  # pulumi,
  dotnetCorePackages,
}:
buildGoModule rec {
  pname = "pulumi-language-dotnet";
  version = "3.60.0";

  src = fetchFromGitHub({
    owner = "pulumi";
    repo = "pulumi-dotnet";
    rev="v${version}";
    fetchSubmodules = false;
    sha256 = "sha256-9UxzLb2ZeAKQXXeITixKxsi0a1Us4DLxTYdsLDn23sE=";
  });

  vendorHash = "sha256-dBkP1CBIWv64pkDXcbxyJwJyMgnfk2c4izc960B68SI=";
  sourceRoot = "${src.name}/pulumi-language-dotnet";

  ldflags = [
    "-s"
    "-w"
    "-X github.com/pulumi/pulumi/sdk/v3/go/common/version.Version=${version}"
  ];

  nativeCheckInputs = [
    dotnetCorePackages.sdk_6_0
    dotnetCorePackages.runtime_6_0
  ];

  # postInstall = ''
  #   cp ../pulumi-language-python-exec           $out/bin
  #   cp ../../dist/pulumi-resource-pulumi-python $out/bin
  #   cp ../../dist/pulumi-analyzer-policy-python $out/bin
  # '';
}
