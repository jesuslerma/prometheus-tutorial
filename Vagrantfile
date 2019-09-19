Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/xenial64"
  
  config.vm.define "prometheus" do |mch1|
    mch1.vm.provision "shell", path: "prometheus.sh"
    mch1.vm.network "private_network", ip: "10.6.6.1"
    mch1.vm.network "forwarded_port", guest: 9090, host: 9090
  end

  config.vm.define "node_exporter" do |mch|
    mch.vm.provision "shell", path: "node_exporter.sh"
    mch.vm.network "private_network", ip: "10.6.6.2"
    mch.vm.network "forwarded_port", guest: 9100, host: 9100
  end

  config.vm.define "grafana" do |mch|
    mch.vm.provision "shell", path: "grafana.sh"
    mch.vm.network "private_network", ip: "10.6.6.3"
    mch.vm.network "forwarded_port", guest: 9100, host: 9200
    mch.vm.network "forwarded_port", guest: 3000, host: 3100
  end
end

