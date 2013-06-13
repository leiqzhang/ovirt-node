bootloader --timeout=30 --append="check rootflags=ro crashkernel=128M elevator=deadline install quiet max_loop=256"
services --enabled=auditd,ntpd,ntpdate,iptables,network,rsyslog,multipathd,snmpd,ovirt-early,ovirt,ovirt-post,ovirt-cim,anyterm,collectd,libvirtd,cgconfig,lighttpd
