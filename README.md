# rtorrent-rutorrent-flood-Docker

```bash
-e FLOOD_PORT=3000 # 端口
-e FLOOD_HOST=0.0.0.0 # IP
-e FLOOD_PARAMETER # flood其他参数传递
-e "FLOOD_PARAMETER=--auth none --rtsocket /var/run/rtorrent/scgi.socket"
```

数据目录 `/data/flood`

socket文件路径 `/var/run/rtorrent/scgi.socket`