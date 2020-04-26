function proxy --description "Set proxy settings."
	set -gx http_proxy http://bywww.blue-yonder.org:8888
	set -gx HTTP_PROXY $http_proxy
	set -gx https_proxy $http_proxy
	set -gx HTTPS_PROXY $https_proxy
	set -gx no_proxy "localhost,127.0.0.1,.blue-yonder.cloud,.blue-yonder.org,.phi-tps.local,blue-yonder.cloud,blue-yonder.org,phi-tps.local"
	set -gx NO_PROXY $no_proxy
	set -gx REQUESTS_CA_BUNDLE /etc/ssl/cert.pem
end
