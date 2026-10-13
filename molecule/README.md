# Molecule tests

## Scenario: default

This creates Podman test containers where the tasks (roles) defined in the converge playbook will be executed.
`sshd` is not needed in the containers since the connection is done using podman. The downside is that things
like `molecule login` won't work without `ssh`.

Using the DevContainer, this means that the containers run inside the DevContainer (podman-in-podman).


## Scenario: libvirt

This creates full virtual machines with the host's libvirt socket. Base images are the Debian cloud-init images,
the connection can only be done using `ssh`.

Using the DevContainer, the VMs run under libvirtd on the host, KVM on the host is used and not needed in the
container. However, the libvirt group needs to be created inside the container with the same GID as on the host,
and the socket as well as the images directory need to be bind mounted into the container.
