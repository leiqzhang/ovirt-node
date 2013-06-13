echo "Fixing boot menu for litevirt"

#check is deprecated, and should be replaced by rd.live.check
sed -i -e 's/ check/ rd.live.check/' $LIVE_ROOT/isolinux/isolinux.cfg

#remove troubleshooting menu items not required
sed -i '/label install (basic video)/,+3d' $LIVE_ROOT/isolinux/isolinux.cfg
sed -i '/label serial-console/,+3d' $LIVE_ROOT/isolinux/isolinux.cfg
sed -i '/label reinstall (basic video)/,+3d' $LIVE_ROOT/isolinux/isolinux.cfg
sed -i '/label reinstall-serial/,+3d' $LIVE_ROOT/isolinux/isolinux.cfg
sed -i '/label basic0/,+3d' $LIVE_ROOT/isolinux/isolinux.cfg
