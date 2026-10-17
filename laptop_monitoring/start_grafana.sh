docker run -d -p 10081:80 -p 12005:2003 -p 12006:2004 -p 12027:2023 -p 12028:2024 -p 18129:8125/udp -p 18131:8126 -v /opt/graphite/configs:/opt/graphite/conf -v /opt/graphite/data:/opt/graphite/storage graphiteapp/graphite-statsd:1.1.8-8
#docker run -d --name graphite --restart=always -p 80:80 -p 2003-2004:2003-2004 -p 2023-2024:2023-2024 -p 8125:8125/udp -p 8126:8126  graphiteapp/graphite-statsd
docker run -d -p 3001:3000     -v /opt/grafana:/var/lib/grafana -v /opt/grafana_config/grafana.ini:/opt/grafana.ini -e "GF_PATHS_CONFIG=/opt/grafana.ini"     grafana/grafana:8.5.4
