packer {
  required_plugins {
    docker = {
      version = ">= 0.0.7"
      source  = "github.com/hashicorp/docker"
    }
  }
}

variable "docker_image" {
  type    = string
  default = "ubuntu:focal"
}

source "docker" "ubuntu" {
  image  = var.docker_image
  commit = true
}

build {
  name = "learn-packer"
  sources = [
    "source.docker.ubuntu"
  ]


  provisioner "shell" {
    environment_vars = [
      "FOO=hello world",
    ]
    inline = [
      "echo Adding file to Docker Container",
      "echo \"FOO is $FOO\" > example.txt",
      "mkdir tests",
    ]
  }

  provisioner "file" {
    source      = "./tests"
    destination = "/tests"
  }

  provisioner "shell" {
    inline = [
      "apt-get update",
      "apt-get install -y ruby-full",
      "apt-get install -y git curl autoconf bison build-essential libssl-dev libyaml-dev libreadline6-dev zlib1g-dev libncurses5-dev libffi-dev libgdbm6 libgdbm-dev libdb-dev",
"cat example.txt",      
"cd tests/tests",
      "ls",
      "gem install bundler --no-document",
"bundle install",
"rspec --init",      
"bundle exec rspec",
    ]
  }
}
