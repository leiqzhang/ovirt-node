#Lighttpd customization
echo "Configure lighttpd"
cat >> /etc/lighttpd/lighttpd.conf <<EOF
#%litevirt section
\$SERVER["socket"] == ":443" {
       ssl.engine   = "enable"
       ssl.pemfile  = "/etc/ssl/private/litevirt.pem"
}
#%end litevirt
EOF

cat >> /etc/lighttpd/modules.conf <<EOF
#%litevirt section
include "conf.d/proxy.conf
#%end litevirt
EOF 

cat >> /etc/lighttpd/conf.d/fastcgi.conf <<EOF
#%litevirt section
server.modules += ( "mod_proxy" )

$HTTP["url"] =~ ".*/litevirt-api/.*" {
    proxy.server  = ( "" =>
        (( "host" => "0.0.0.0", "port" => 8088 ))
    )
}
$HTTP["url"] =~ ".*/api/" {
    proxy.server  = ( "" =>
        (( "host" => "0.0.0.0", "port" => 8088 ))
    )
}
#%end litevirt
EOF
