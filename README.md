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


## Grafana node_exporter
## DISK
### Filesystem tracking
The overall space remaining on various filesystems.

```node_filesystem_avail_bytes```
```node_filesystem_size_bytes```

Grafana Panel: Bar Gauge

PromQL: ```(1 - node_filesystem_avail_bytes / node_filesystem_size_bytes) * 100```
Query Config:

  Legend: {{ device }}

  Resolution: 1/1

  Format: Time series 

  Instant: on

Visualization Config: 

  Display:

    Show: Calculation

    Calc: Mean

    Orientation: Vertical

    Mode: Gradient

  Field:

    Unit: percent(0-100)

    Min: 0

    Max: 100

### Read & Write Latencies
The read and write latencies on our disks.

For reading
```node_disk_read_time_seconds_total```
```node_disk_reads_completed_total```

For writing

```node_disk_write_time_seconds_total```
```node_disk_writes_completed_total```

Grafana Panel: Graph

A

PromQL: ```rate(node_disk_read_time_seconds_total[5s]) / rate(node_disk_reads_completed_total[5s]) * 100```

Query Config:
  Legend: {{ device }} disk read latency

  Resolution: 1/1

  Format: Time series

  Instant: off

B

PromQL: ```rate(node_disk_write_time_seconds_total[5s]) / rate(node_disk_writes_completed_total[5s]) * 100```
Query Config:
  Legend: {{ device }} disk write latency
  Resolution: 1/1
  Format: Time series
  Instant: off

Visualization Config: 
  Display Modes:
    Bars: On
    Lines: off
    Points: off
  Mode Options:
    Fill: 1
    Line Width: 1
  Hover Tooltip:
    Mode: All series
    Start order: None
  Stacking & Null value:
    Stack: off
    Null value: null
### Number of inodes on our system
The number of inodes still available on your system.

Metrics:

```node_filesystem_files_free```
```node_filesystem_files```


Grafana Panel: Bar Gauge
PromQL: ```node_filesystem_files_free / node_filesystem_files * 100```
Query Config: Legend: {{ mountpoint }} Resolution: 1/1 Format: Time series Instant: on

Visualization Config:
  Display:

    Show: Calculation

    Calc: Mean

    Orientation: Horizontal

    Mode: Gradient

  Field:

    Unit: percent(0-100)

    Min: 0

    Max: 100

### Overall I/O load on your instance
```node_disk_io_now```


Grafana Panel: Graph
A

PromQL: ```rate(node_disk_io_now)```

Query Config: Legend: {{ device }} global I/O Resolution: 1/1 Format: Time series Instant: off

Visualization Config: 

  Display Modes:

    Bars: Off

    Lines: off

    Points: on

  Mode Options:

    Fill: 1

    Line Width: 1

    Point Radius: 3

  Hover Tooltip:

    Mode: All series

    Start order: None

  Stacking & Null value:

    Stack: off

    Null value: null

  ### Memory Information
  ```node_memory_MemTotal_bytes```

  Grafana Panel: Graph
  A
  
  PromQL: ```node_memory_MemTotal_bytes```

  Query Config: Legend: {{instance}}_Total memory Resolution: 1/2 Format: Time series Instant: off

  Visualization Config: 

  Display Modes:

    Bars: off

    Lines: on

    Points: off

  Mode Options:

    Fill: 6
    
    Fill Gradient: 3

    Line Width: 3

  Hover Tooltip:

    Mode: All series

    Start order: None

  Stacking & Null value:

    Stack: off

    Null value: null

  Left Y:
    unit: bytes
    
    scale: linear
    
### Memory usage
```(1 - (node_memory_MemAvailable_bytes{instance=~\"$node\"} / (node_memory_MemTotal_bytes{instance=~\"$node\"})))* 100```
Singlestat


## Python Client
In one vagrant machine called python we need to install
```bash
sudo apt-get install python3-pip
sudo bash -c 'cat << EOF >> /etc/environment
LC_ALL="en_US.UTF-8"
LC_CTYPE="en_US.UTF-8"
EOF'
pip3 install prometheus_client
```

We need to create a file called server.py
```python
import http.server
from prometheus_client import start_http_server

class MyHandler(http.server.BaseHTTPRequestHandler):
        def do_GET(self):
                self.send_response(200)
                self.end_headers()
                self.wfile.write(b"Hello World")

if __name__ == "__main__":
        start_http_server(8000)
        server = http.server.HTTPServer(('localhost',8001), MyHandler)
        server.serve_forever()
```
