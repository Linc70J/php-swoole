# php-swoole
這是用於構建php容器的Dockerfile，基於php-fpm擴展swoole模組，提供完全同步的代碼實現異步程序。

如果您有改進或建議，歡迎在GitHub上提出Issues或發送PR。

## Version
| Docker Tag | Git Release | PHP Version |
|------------|-------------|-------------|
| latest | Master Branch | 7.2.18 |

## Get this image

構建完成的 Docker Image 存放在 [Docker Hub Registry](https://hub.docker.com/r/linc70j/php-swoole)，歡迎下載。

```bash
docker push linc70j/php-swoole
```

## Getting Started

### Step 1: 啟動PHP服務

建議為您的PHP服務指定一個明確名稱，以便更容易連接到其他的容器。

```bash
docker run -it --name phpswoole -v $(pwd):/var/www -p 80:80 linc70j/php-swoole
```

也可以使用 Docker Compose：

```yaml
services:
  phpswoole:
    image: 'linc70j/php-swoole:latest'
    volumes:
      - $(pwd):/var/www
    ports:
      - '80:80'
```

P.S. 建議使用nginx來為我們的PHP提供Web服務，這將讓我們可以配置更複雜的設定，例如：靜態配置、負載平衡...等。


### Step 2: 啟動Swoole服務

通過以下程序代碼，我們可以創建一個異步服務器程序

```php
$http = new swoole_http_server('0.0.0.0', 80, SWOOLE_BASE);
```

Laravel framework 推薦使用[Laravel-Swoole](https://github.com/swooletw/laravel-swoole)，幫助您啟動swoole服務

## PHP Extensions
- swoole
- zip

## Tools
- apt
- docker-php
- pecl
- curl
- vim
- supervisor


## Links
- [https://hub.docker.com/r/linc70j/php-swoole](https://hub.docker.com/r/linc70j/php-swoole)