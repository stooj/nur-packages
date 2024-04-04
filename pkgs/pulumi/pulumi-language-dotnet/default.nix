# { lib,
#   fetchFromGitHub,
#   buildDotnetModule,
#   dotnetCorePackages,
# }:
# 
# buildDotnetModule rec {
#   pname = "pulumi-language-dotnet";
#   version = "3.60.0";
# 
#   src = fetchFromGitHub({
#     owner = "pulumi";
#     repo = "pulumi-dotnet";
#     rev="v${version}";
#     fetchSubmodules = false;
#     sha256 = "sha256-iI5ybbASfVkHHlprrnmrFeDAnrjNF+2TouHIMU/0XHQ=";
#   });
#   vendorHash = "sha256-kJjEKhK0Tm62KYA6UGBC5IGfZrDkdNEj+Z/MKdU0F8U=";
#   projectFile = "Pulumi.sln";
#   nugetDeps = null;
# 
#   dotnet-sdk = dotnetCorePackages.sdk_6_0;
#   dotnet-runtime = dotnetCorePackages.runtime_6_0;
# 
#   ldflags = [
#     "-s"
#     "-w"
#     "-X github.com/pulumi/pulumi/sdk/v3/go/common/version.Version=${version}"
#   ];
# 
#   # go: inconsistent vendoring in ...
#   doCheck = false;
# 
#   meta = with lib; {
#     description = "Golang language host plugin for Pulumi";
#     mainProgram = "pulumi-language-go";
#     homepage = "https://github.com/pulumi/pulumi/tree/master/sdk/go";
#     license = licenses.asl20;
#   };
# }


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

  # postPatch = ''
  #   substituteInPlace main_test.go \
  #     --replace "TestDeterminePulumiPackages" \
  #               "SkipTestDeterminePulumiPackages"
  # '';

  ldflags = [
    "-s"
    "-w"
    # "-X github.com/pulumi/pulumi/sdk/v3/go/common/version.Version=${version}"
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
