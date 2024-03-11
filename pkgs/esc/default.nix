{
    lib,
    fetchFromGitHub,
    buildGoModule
}:

buildGoModule rec {
    pname = "esc";
    version = "0.8.2";
    src = fetchFromGitHub({
        owner = pname;
        repo = "esc";
        rev= "v${version}";
        fetchSubmodules = false;
        sha256 = "sha256-iI5ybbASfVkHHlprrnmrFeDAnrjNF+2TouHIMU/0XHQ=";
    });
    vendorHash = "sha256-kJjEKhK0Tm62KYA6UGBC5IGfZrDkdNEj+Z/MKdU0F8U=";
    ldflags = [
        "-s"
        "-w"
    ] ++ importpathFlags;
    importpathFlags = [
        "-X github.com/pulumi/esc/cmd/internal/version.Version=v${version}"
    ];
    # esc version returns nothing atm. Disabling checks until fixed upstream.
    doInstallCheck = false;
    installCheckPhase = ''
        $out/bin/esc version | grep v${version} > /dev/null
    '';

    meta = with lib; {
        homepage = "https://pulumi.io";
        description = "Pulumi ESC (Environments, Secrets, and Configuration) for cloud applications and infrastructure.";
        sourceProvenance = [ sourceTypes.fromSource ];
        license = licenses.asl20;
        platforms = platforms.unix;
    };
}
