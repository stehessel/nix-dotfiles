function proxy --description "Set proxy settings."
	set -gx http_proxy http://bywww.a.westeurope.blue-yonder.cloud:8888
	set -gx https_proxy $http_proxy
	set -gx no_proxy "localhost,127.0.0.1,.blue-yonder.cloud,.blue-yonder.org,.phi-tps.local"
	set -gx REQUESTS_CA_BUNDLE /etc/ssl/cert.pem
end
