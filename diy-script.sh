#!/bin/bash

# ===== 1. 默认 IP =====
sed -i 's/192.168.1.1/192.168.3.1/g' package/base-files/files/bin/config_generate

# ===== 2. Clone PassWall2 源（如果 feeds 没加的话）=====
git clone --depth=1 https://github.com/xiaorouji/openwrt-passwall2 package/luci-app-passwall2
git clone --depth=1 https://github.com/xiaorouji/openwrt-passwall-packages package/openwrt-passwall

# ===== 3. 清旧配置 =====
sed -i '/CONFIG_PACKAGE_luci-app-passwall/d' .config
sed -i '/CONFIG_PACKAGE_luci-app-passwall2/d' .config
sed -i '/CONFIG_PACKAGE_passwall2/d' .config
sed -i '/CONFIG_PACKAGE_zerotier/d' .config
sed -i '/CONFIG_PACKAGE_luci-app-zerotier/d' .config

# ===== 4. ZeroTier =====
echo 'CONFIG_PACKAGE_zerotier=y' >> .config
echo 'CONFIG_PACKAGE_luci-app-zerotier=y' >> .config

# ===== 5. PassWall2 本体 =====
echo 'CONFIG_PACKAGE_luci-app-passwall2=y' >> .config
echo 'CONFIG_PACKAGE_passwall2=y' >> .config

# ===== 6. PassWall2 全内核组件 =====
echo 'CONFIG_PACKAGE_luci-app-passwall2_INCLUDE_Xray=y' >> .config
echo 'CONFIG_PACKAGE_luci-app-passwall2_INCLUDE_SingBox=y' >> .config
echo 'CONFIG_PACKAGE_luci-app-passwall2_INCLUDE_Shadowsocks_Libev_Client=y' >> .config
echo 'CONFIG_PACKAGE_luci-app-passwall2_INCLUDE_Shadowsocks_Rust_Client=y' >> .config
echo 'CONFIG_PACKAGE_luci-app-passwall2_INCLUDE_ShadowsocksR_Libev_Client=y' >> .config
echo 'CONFIG_PACKAGE_luci-app-passwall2_INCLUDE_Simple_Obfs=y' >> .config
echo 'CONFIG_PACKAGE_luci-app-passwall2_INCLUDE_V2ray_Plugin=y' >> .config
echo 'CONFIG_PACKAGE_luci-app-passwall2_INCLUDE_Brook=y' >> .config
echo 'CONFIG_PACKAGE_luci-app-passwall2_INCLUDE_Hysteria=y' >> .config
echo 'CONFIG_PACKAGE_luci-app-passwall2_INCLUDE_NaiveProxy=y' >> .config
echo 'CONFIG_PACKAGE_luci-app-passwall2_INCLUDE_tuic_client=y' >> .config
echo 'CONFIG_PACKAGE_luci-app-passwall2_INCLUDE_ChinaDNS_NG=y' >> .config
echo 'CONFIG_PACKAGE_luci-app-passwall2_INCLUDE_IPv6_Nat=y' >> .config
echo 'CONFIG_PACKAGE_luci-app-passwall2_Iptables_Transparent_Proxy=y' >> .config

# 关掉不需要的服务端组件（省一点点空间）
echo '# CONFIG_PACKAGE_luci-app-passwall2_INCLUDE_Shadowsocks_Libev_Server is not set' >> .config
echo '# CONFIG_PACKAGE_luci-app-passwall2_INCLUDE_Shadowsocks_Rust_Server is not set' >> .config
echo '# CONFIG_PACKAGE_luci-app-passwall2_INCLUDE_ShadowsocksR_Libev_Server is not set' >> .config

# 关掉大插件（防爆）
echo '# CONFIG_PACKAGE_luci-app-adguardhome is not set' >> .config
echo '# CONFIG_PACKAGE_luci-app-mosdns is not set' >> .config
echo '# CONFIG_PACKAGE_luci-app-ssr-plus is not set' >> .config
echo '# CONFIG_PACKAGE_luci-app-openclash is not set' >> .config
