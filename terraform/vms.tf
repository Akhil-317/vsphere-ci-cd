// vms.tf

data "vsphere_datacenter" "dc" {
  name = var.datacenter
}

data "vsphere_datastore" "ds" {
  name          = var.datastore
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_network" "net" {
  name          = var.network
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_resource_pool" "pool" {
  name          = "Resources"
  datacenter_id = data.vsphere_datacenter.dc.id
}

// Jenkins Master
resource "vsphere_virtual_machine" "jenkins_master" {
  name             = "Jenkins_Master"
  resource_pool_id = data.vsphere_resource_pool.pool.id
  datastore_id     = data.vsphere_datastore.ds.id

  num_cpus = 2
  memory   = 4096
  guest_id = "otherGuest64"
  scsi_type = "lsilogic"

  // point the CD-ROM to your CentOS ISO on that datastore
  cdrom {
    datastore_id = data.vsphere_datastore.ds.id
    path         = "${var.datastore}/CentOS/CentOS-8.5.2111-x86_64-dvd1.iso"
  }

  disk {
    label            = "Jenkins_Master-disk0"
    size             = 50
    thin_provisioned = true
  }

  network_interface {
    network_id   = data.vsphere_network.net.id
    adapter_type = "vmxnet3"
  }

  boot_delay         = 5000
  boot_retry_enabled = true
  boot_retry_delay   = 10000

  wait_for_guest_net_timeout = 0
  wait_for_guest_ip_timeout  = 0
}

// Jenkins Agent (same pattern, tweak name, CPU/memory/disk)
resource "vsphere_virtual_machine" "jenkins_agent" {
  name             = "Jenkins_Agent"
  resource_pool_id = data.vsphere_resource_pool.pool.id
  datastore_id     = data.vsphere_datastore.ds.id

  num_cpus = 2
  memory   = 2048
  guest_id = "otherGuest64"
  scsi_type = "lsilogic"

  cdrom {
    datastore_id = data.vsphere_datastore.ds.id
    path         = "${var.datastore}/CentOS/CentOS-8.5.2111-x86_64-dvd1.iso"
  }

  disk {
    label            = "Jenkins_Agent-disk0"
    size             = 20
    thin_provisioned = true
  }

  network_interface {
    network_id   = data.vsphere_network.net.id
    adapter_type = "vmxnet3"
  }

  boot_delay         = 5000
  boot_retry_enabled = true
  boot_retry_delay   = 10000

  wait_for_guest_net_timeout = 0
  wait_for_guest_ip_timeout  = 0
}
