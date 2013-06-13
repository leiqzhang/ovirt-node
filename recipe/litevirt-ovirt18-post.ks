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

