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
			lib,
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

			buildPhase = ''
				runHook preBuild

				make depend
				make

				runHook postBuild
			'';

			installPhase = ''
				runHook preInstall

				install -Dm755 hdspeconf \
				$out/bin/hdspeconf

				install -Dm644 dialog-warning.png \
				$out/share/hdspeconf/dialog-warning.png

				install -Dm644 LICENSE \
				$out/share/licenses/hdspeconf/LICENSE

				runHook postInstall
			'';

			meta = {
				description = "User-space configuration tool for RME HDSPe cards";
				mainProgram = "hdspeconf";
				license = lib.licenses.gpl3Only;
				platforms = [ "x86_64-linux" ];
				homepage = "https://github.com/Sotem/hdspeconf";
			};
		};		
	in {

		packages.${system}.default = pkgs.callPackage hdspeconf {};

		overlays.default = final: prev: {
			hdspeconf = final.callPackage hdspeconf {};
		};
	};
}
