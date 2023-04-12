# rtorrent-rutorrent-flood-Docker

基础镜像: https://github.com/crazy-max/docker-rtorrent-rutorrent

flood: https://github.com/jesec/flood

geoip-updater: https://github.com/crazy-max/geoip-updater

```bash
-e FLOOD_PORT=3000 # flood 端口
-e FLOOD_HOST=0.0.0.0 # flood IP
-e FLOOD_PARAMETER # flood 其他参数传递
-e GU_EDITION_IDS # geoip-updater 要下载的 MaxMind 的 GeoIP2 数据库的版本 ID 列表（逗号分隔）
-e GU_LICENSE_KEY # geoip-updater 用于下载数据库的MaxMind 许可证密钥
-e GU_SCHEDULE # geoip-updater 用于安排下载计划的 CRON 表达式
-e GU_LOG_LEVEL # geoip-updater 日志级别输出
```

数据目录 `/data/flood`

socket文件路径 `/var/run/rtorrent/scgi.socket`