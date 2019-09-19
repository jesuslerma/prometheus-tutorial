# prometheus-tutorial
Taller dirigido a programadores.

Para iniciar clona el proyecto.
Ejecuta en tu terminal:
```bash
vagrant up
vagrant ssh grafana
cd node_exporter
./node_exporter &
exit

vagrant ssh node_exporter
cd node_exporter
./node_exporter &
exit

vagrant ssh prometheus
cd prometheus
vim prometheus.yml
exit
```
