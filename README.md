# pre-access
预发布环境的入口

APP如果想接入预发布环境，只需要设置HTTP代理，就可以很方便的测试啦


## 依赖条件
生产环境和预发布环境使用不同的域名

例如
* 生产环境
  * domain.com
* 预发布环境
  * pre-domain.com


## 配置
* 修改DNS服务器地址
* 修改需要修改的预发布环境和生产环境的域名

```nginx.conf
        location / {
            set $domain "";

            resolver 192.168.1.123;
            resolver_timeout 30s;
            proxy_pass http://$domain$request_uri;

            access_by_lua '
                 domain_map = {
                     ["apis\\\\.domain\\\\.com"] = "pre-apis.domain.com"
                 };

                 ngx.var.domain = ngx.var.host
                 for src,dst in pairs(domain_map)
                 do
                     local from, to, err = ngx.re.find(ngx.var.host, src, "jo")
                     if from then
                         ngx.var.domain = dst;
                         ngx.log(ngx.NOTICE, ngx.var.host, " change to ", ngx.var.domain);
                     end
                 end
            ';
        }
```
