{
  description = "Personal flake templates";

  outputs = { self }: {
    templates = {
      haskell-basic = {
        path = ./haskell-basic;
        description = "Very basic flake with a callCabal2nix project";
      };

      haskell-github = {
        path = ./haskell-github;
        description = "Flake with a callCabal2nix project with GitHub Actions workflows";
      };

      haskell-benchmark = {
        path = ./haskell-benchmark;
        description = "Basic benchmark suite for quick benchmarks";
      };
    };
  };
}
