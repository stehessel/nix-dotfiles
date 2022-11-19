{pkgs, ...}: {
  home = {
    packages = with pkgs; [
      (google-cloud-sdk.withExtraComponents (
        with google-cloud-sdk.components; [
          beta
          gke-gcloud-auth-plugin
        ]
      ))
    ];
  };
}
