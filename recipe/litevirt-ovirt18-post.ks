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
include "conf.d/fastcgi.conf"
#%end litevirt
EOF 

cat >> /etc/lighttpd/conf.d/fastcgi.conf <<EOF
#%litevirt section
server.modules += ( "mod_rewrite" )

fastcgi.server = ( "/litevirt-api-server.py" =>
  ((
      "socket" => "/var/run/lighttpd/litevirt-api-server.socket",
      "bin-path" => server_root + "/litevirt/litevirt-api-server.py",
      "max-procs" => 5,
      "bin-environment" => (
          "REAL_SCRIPT_NAME" => ""
     ),
      "check-local" => "disable"
   ))
)

url.rewrite-once = (
        "^/favicon.ico$" => "/static/favicon.ico",
        "^/static/(.*)$" => "/static/$1",
        "^/api/(.*)$" => "/litevirt-api-server.py/$1",
       )
#%end litevirt
EOF
