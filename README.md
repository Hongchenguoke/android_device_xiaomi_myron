# OrangeFox Recovery — Xiaomi Myron (Redmi K90 Pro Max)

## 设备参数

| Spec | Value |
|------|-------|
| **设备** | Xiaomi Redmi K90 Pro Max |
| **代号** | myron |
| **平台** | Canoe (Snapdragon 8 Elite Gen 5) |
| **CPU** | Oryon V3 Phoenix (ARMv9.2-A), arm64-v8a |
| **OS**  | Android 16 / HyperOS 3.0 |
| **屏幕** | 1200 × 2608, 480 DPI |
| **Recovery** | 100 MB |


## 刷入

```bash
adb reboot bootloader
fastboot flash recovery_a recovery.img
fastboot flash recovery_b recovery.img
fastboot reboot recovery
```

## 注意事项
- 首次刷入建议先备份原厂 recovery


## License

Apache License 2.0
