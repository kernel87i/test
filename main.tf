provider "vscale" {
  token = "${var.do_token}"
}

provider "aws" {
  access_key = "${var.access_key}"
  secret_key = "${var.secret_key}"
  region     = "${var.region}"
}


# Create a new scalet
resource "vscale_scalet" "test" {
  count     = "${length(var.devs)}"
  name      = "${var.devs[count.index]}"
  ssh_keys  = ["${vscale_ssh_key.SBabanin4.id}","${vscale_ssh_key.REBRAIN_SSH_PUB_KEY121212.id}"]
  make_from = "${var.image[count.index]}"
  location  = "${var.vscale_msk}"
  rplan     = "${var.vscale_rplan["s"]}"

provisioner "remote-exec" {
   inline = [
     "/bin/echo -e  root:'${random_string.password[count.index].result}' | chpasswd",
     "hostnamectl set-hostname ${var.devs[count.index]}",
   ]
}

connection {
  type     = "ssh"
  user     = "root"
  private_key = "${file("~/.ssh/id_rsa")}"
  host = self.public_address
 }

}

resource "random_string" "password" {
  length  = 16
  special = true
  count   = 2
}

# Create a new SSH key
resource "vscale_ssh_key" "SBabanin4" {
  name = "SBabanin4"
  key  = "${file("~/.ssh/id_rsa.pub")}"
}

# Added  SSH key Rebrain
resource "vscale_ssh_key" "REBRAIN_SSH_PUB_KEY121212" {
  name = "REBRAIN_SSH_PUB_KEY121212"
  key  = "${file("~/.ssh/REBRAIN_SSH_PUB_KEY.pub")}"
}


data "aws_route53_zone" "zone_SBabanin4"{
  name = "devops.rebrain.srwx.net"
}

resource "aws_route53_record" "SBabanin4" {
  name    = "SBabanin4.${data.aws_route53_zone.zone_SBabanin4.name}"
  zone_id = "${data.aws_route53_zone.zone_SBabanin4.zone_id}"
  type    = "A"
  ttl     = "300"
  count   = 2
  records = ["${element(vscale_scalet.test.*.public_address,count.index)}"]
  allow_overwrite = true
}

resource "local_file" "ansible_inventory" {
  count    = "${length(var.test)}"
  content = "[${var.group_name}]\n${join("\n", formatlist(
                "%s ansible_host=%s",
                vscale_scalet.test.*.name,
                vscale_scalet.test.*.public_address
              )
          )}"
   filename = "inventory.yml"
}
