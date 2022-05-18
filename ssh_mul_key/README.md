# ssh_mul_key.sh
一键脚本，单机支持多个ssh-key，支持多个git-server的认证。

```shell
./ssh_mul_key.sh --email liuhj0910@163.com --key jfh git.jointforce.com liuhuijun001@chinasofti.com --key github github.com liuhj0910@163.com --key gitee gitee.com liuhj0910@163.com
```

说明：--email 配置默认email，用来生成基础的ssh-key，而不是git-server认证的key

--key 后缀 git-server的host 邮箱