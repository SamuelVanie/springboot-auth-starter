{
  description = "Authentication starter pack for springboot applications";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }: {
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
        in
          {
            devShell = pkgs.mkShell {
              buildInputs = with pkgs; [
                openjdk17
                maven
                git
                curl
                spring-boot-cli
              ];
              
              shellHook = ''
                echo "🚀 Spring Boot Authentication Starter Environment"
                echo "Java: $(java -version 2>&1 | head -n 1)"
                echo "Maven: $(mvn -version | head -n 1)"
                echo ""
                echo "📋 Quick Commands:"
                echo "  mvn spring-boot:run     - Start the application"
                echo "  mvn test               - Run tests"
                echo "  docker-compose up      - Start dev databases"
                echo "  http :8080/health      - Test health endpoint"
                echo ""
              '';
              
              # Environment variables for development
              JAVA_HOME = "${pkgs.openjdk17}";
            };
          }
    );
  };
}
