%{ for addr in ip_addrs ~}
template ${addr}:${port}
%{ endfor ~}
