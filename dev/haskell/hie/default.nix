let
	all-hies = import (fetchTarball "https://github.com/infinisil/all-hies/tarball/master") {};
in
{
	home.packages = [
		(all-hies.unstableFallback.selection { selector = p: { inherit (p) ghc865; }; })
	];
}
