include $(TOPDIR)/rules.mk

PKG_NAME:=rustifi
PKG_VERSION:=1.0
PKG_RELEASE:=1

PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)

include $(INCLUDE_DIR)/package.mk

define Package/rustifi
  SECTION:=utils
  CATEGORY:=Utilities
  TITLE:=Rust-based CLI utility
  MAINTAINER:=Your Name <you@example.com>
  DEPENDS:=+libstdcpp
endef

define Package/rustifi/description
  A simple Rust-based OpenWRT package.
endef

define Build/Compile
  cargo build --release --target=aarch64-unknown-linux-musl
endef

define Package/rustifi/install
  $(INSTALL_DIR) $(1)/usr/bin
  $(INSTALL_BIN) target/aarch64-unknown-linux-musl/release/rustifi $(1)/usr/bin/
endef

$(eval $(call BuildPackage,rustifi))

