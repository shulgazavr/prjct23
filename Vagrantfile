servers = [
    { :hostname => 'proxy', :ips => '192.168.10.200', :ram => 1024, :cpuz => 1 },
    { :hostname => 'web', :ips => '192.168.10.201', :ram => 2048, :cpuz => 2 },
    { :hostname => 'grafana', :ips => '192.168.10.203', :ram => 4096, :cpuz => 2 },
    { :hostname => 'bckp', :ips => '192.168.10.204', :ram => 1024, :cpuz => 1 },
]

Vagrant.configure(2) do |config|
    servers.each do |machine|
        config.vm.define machine[:hostname] do |node|
            node.vm.box = 'centos/7'
            node.vm.box_version = "2004.01"
            node.vm.hostname = machine[:hostname]
            node.vm.network :public_network, ip: machine[:ips], bridge: "eno1"
            node.vm.provider "virtualbox" do |vb|
                vb.memory = machine[:ram]
                vb.cpus = machine[:cpuz]
            end
            node.vm.provision :ansible do |ansible|
                ansible.playbook = "playbooks/playbook-prepeare.yml" # Install standart utils
            end
            node.vm.provision :ansible do |ansible|
                ansible.playbook = "playbooks/playbook-#{node.vm.hostname}.yml" # Main playbook for host
            end
            node.vm.provision :ansible do |ansible|
                ansible.playbook = "playbooks/playbook-node-exp.yml" # Install node exporter
            end
            if (machine[:hostname] != "bckp")
                node.vm.provision :ansible do |ansible|
                    ansible.playbook = "playbooks/playbook-bckp-client.yml" # Prepeare for backup
                end
            end
            if (machine[:hostname] == "web")
                node.vm.provision "shell", path: "setup_php.sh" # Specific for web - install PHP
            end
            if (machine[:hostname] == "proxy")
                node.vm.network :public_network, ip: '192.168.31.200', bridge: "eno1" # local ip
            end
        end
    end
end
