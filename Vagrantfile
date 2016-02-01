Vagrant.configure(2) do |config|

    # main & default: normal OS series...
    config.vm.define "main", primary: true do |node|

        node.vm.box = "ubuntu/trusty64"
        #node.vm.box = "ubuntu/precise64"
        #node.vm.box = "debian/jessie64"
        #node.vm.box = "debian/wheezy64"
        #node.vm.box = "bento/centos-7.2"
        #node.vm.box = "bento/centos-6.7"

        #ansible-galaxy install -f  -r test-requirements.yml

        node.vm.provision "ansible" do |ansible|
          ansible.playbook = "test.yml"
          #ansible.sudo = true
          ansible.verbose = "vvv"
        end

        node.vm.provider "virtualbox" do |vb|
          vb.customize ["modifyvm", :id, "--memory", "1024"]
        end

    end


    # docker: for auto build & testing (e.g., Travis CI)
    config.vm.define "docker" do |node|
        node.vm.box = "williamyeh/ubuntu-trusty64-docker"

        node.vm.provision "shell", inline: <<-SHELL
            cd /vagrant
            docker build  -f test/Dockerfile-ubuntu14.04  -t es_trusty   .
            docker build  -f test/Dockerfile-ubuntu12.04  -t es_precise  .
            docker build  -f test/Dockerfile-debian8      -t es_jessie   .
            docker build  -f test/Dockerfile-debian7      -t es_wheezy   .
            docker build  -f test/Dockerfile-centos7      -t es_centos7  .
            docker build  -f test/Dockerfile-centos6      -t es_centos6  .
        SHELL
    end

end
