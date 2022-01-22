function vpn_off --description "Stop wireguard vpn service"
	sudo systemctl stop wg-quick@wg0
end
