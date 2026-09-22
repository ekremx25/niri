# Niri Configuration

Taşınabilir Niri yapılandırması. Arch Linux ve CachyOS üzerinde Niri, Quickshell ve Wayland uygulamalarıyla kullanılmak üzere hazırlanmıştır.

## Özellikler

- Türkçe klavye düzeni ve Wayland uygulama ortamı
- Klavye ve fare odaklı pencere yönetimi
- Quickshell uygulama çekmecesi (`Super+A`)
- DaVinci Resolve'u açan veya mevcut penceresine odaklanan kısayol (`Super+D`)
- Pencereyi sol yarı ile genişletilmiş sütun arasında geçiren kısayol (`Super+M`)
- PipeWire ses tuşları ve Niri ekran görüntüsü kısayolları
- Quickshell, NetworkManager applet ve Waypaper başlangıcı
- Makineye özel monitör ayarları için ayrı `outputs.kdl`

## Gereksinimler

Ana paketler:

```bash
sudo pacman -S niri pipewire wireplumber xdg-desktop-portal \
  xdg-desktop-portal-gnome xdg-desktop-portal-gtk \
  network-manager-applet kitty dolphin firefox
```

Yapılandırmada ayrıca `quickshell`, `waypaper` ve `hyprlock` komutları kullanılır. Bunlardan istemediklerinizi `config.kdl` içinden kaldırabilirsiniz.

Niri ekran paylaşımı ve OBS yakalama için `xdg-desktop-portal-gnome` ile `xdg-desktop-portal-gtk` gereklidir.

## Kurulum

```bash
git clone https://github.com/ekremx25/niri.git
cd niri
./install.sh
```

Kurulum betiği mevcut `~/.config/niri/config.kdl` dosyasını tarih ekleyerek yedekler, dosyaları kurar ve `niri validate` ile doğrular.

## Monitör ayarı

Bağlı çıkışları öğrenin:

```bash
niri msg outputs
```

Ardından `~/.config/niri/outputs.kdl` dosyasındaki örneği kendi çıkış adı, çözünürlük, yenileme hızı ve ölçek değerinizle düzenleyin. Monitör bilgileri makineye özel olduğu için depodaki ana ayara sabitlenmemiştir.

## Kısayollar

| Kısayol | İşlem |
| --- | --- |
| `Super+Return` | Kitty |
| `Super+B` | Firefox |
| `Super+E` | Dolphin |
| `Super+A` | Quickshell uygulama çekmecesi |
| `Super+D` | DaVinci Resolve'u aç / öne getir |
| `Super+M` | Sol yarı / genişletilmiş sütun |
| `Super+F` | Tam ekran |
| `Super+T` | Yüzen pencereyi aç/kapat |
| `Super+1…9` | Çalışma alanına geç |
| `Print` | Bölge ekran görüntüsü |

Tüm kısayollar [`config.kdl`](config.kdl) içinde açıklamalı olarak bulunur.

## Kişiselleştirme

- Klavye düzeni: `input.keyboard.xkb.layout`
- Varsayılan uygulamalar: `binds` bölümü
- Pencere kuralları: `window-rule` blokları
- Renk, gölge ve boşluklar: `layout` bölümü
- Başlangıç uygulamaları: `spawn-at-startup` satırları

Kişisel parola veritabanları, anahtar dosyaları, monitör kimlikleri ve yedekler depoya dahil edilmez.

## Lisans

[MIT](LICENSE)
