1. How to dry run ovirt-node-setup on F18

a) Install prerequisite packages: 
     PyPAM, 
     python-gudev, 
     python-augeas,
     python-urwid

b) cd ovirt-node

c) PYTHONPATH=./src bash ./scripts/ovirt-node-setup --dry 
