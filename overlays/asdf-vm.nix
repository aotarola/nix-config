final: prev: {
  # v0.20.1's git tag was deleted upstream, so nixpkgs' pinned fetchFromGitHub
  # 404s. Bump to v0.20.2, the next tag that still exists.
  asdf-vm = prev.asdf-vm.overrideAttrs (old: {
    version = "0.20.2";
    src = prev.fetchFromGitHub {
      owner = "asdf-vm";
      repo = "asdf";
      tag = "v0.20.2";
      hash = "sha256-HJRNRA98MIOEF/Q3I+cGUL8kH904j3/msI+FGDbRH7A=";
    };
  });
}
