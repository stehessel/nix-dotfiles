function proxy --description "Set proxy settings."
	if test (count $argv) -eq 1 -a "$argv[1]" = "clear"
		set -e http_proxy
		set -e HTTP_PROXY
		set -e https_proxy
		set -e HTTPS_PROXY
		set -e no_proxy
		set -e NO_PROXY
		set -e REQUESTS_CA_BUNDLE
	else
		set -gx http_proxy http://bywww.blue-yonder.org:8888
		set -gx HTTP_PROXY $http_proxy
		set -gx https_proxy $http_proxy
		set -gx HTTPS_PROXY $https_proxy
		set -gx no_proxy "localhost,127.0.0.1,.blue-yonder.cloud,.blue-yonder.org,.phi-tps.local,blue-yonder.cloud,blue-yonder.org,phi-tps.local"
		set -gx NO_PROXY $no_proxy
		set -gx REQUESTS_CA_BUNDLE $HOME/certs/Certificates.pem
	end
	return 0
end
