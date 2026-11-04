{
	description = "User space configuration tool for RME HDSPe MADI / AES / RayDAT / AIO and AIO Pro cards, driven by the snd-hdspe driver.";
	inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";

	outputs = { 
		self,
		nixpkgs
	}:
	let
		system = "x86_64-linux";
		pkgs = nixpkgs.legacyPackages.${system};

		hdspeconf = {
			stdenv,
			alsa-lib,
			wxwidgets_3_2
		}:
		stdenv.mkDerivation {
			pname = "hdspeconf";
			version = "1.0.0";
			src = self;

			buildInputs = [
				alsa-lib
				wxwidgets_3_2
			];			

			installPhase = ''
				install -Dm755 hdspeconf -t $out/bin/
				install -Dm644 dialog-warning.png -t $out/share/hdspeconf/
			'';
		};
	in {

		packages.${system}.default = nixpkgs.legacyPackages.${system}.callPackage hdspeconf {};
	};
}
