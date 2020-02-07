function vpn_on --description "Start wireguard vpn service"
	sudo systemctl start wg-quick@wg0
end
