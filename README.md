# prometheus-tutorial
Taller dirigido a programadores.

Para iniciar clona el proyecto.
Ejecuta en tu terminal:
```bash
vagrant up
vagrant ssh grafana
sudo service grafana-server start
cd node_exporter
./node_exporter &
exit

vagrant ssh node_exporter
cd node_exporter
./node_exporter &
exit

vagrant ssh prometheus
cd prometheus
./prometheus &
exit
```


# Grafana
Create a New Dashboard
Then clic on graph
And add

process_resident_memory_bytes
prometheus_tsdb_head_series
