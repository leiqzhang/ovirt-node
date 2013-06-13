echo "Fixing boot menu for litevirt"

#check is deprecated, and should be replaced by rd.live.check
sed -i -e 's/ check/ rd.live.check/' $LIVE_ROOT/isolinux/isolinux.cfg

