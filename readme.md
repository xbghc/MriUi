# Build
> [!WARNING]
> `Qt5.15.17`在ARM版Windows上无法使用qt online installer安装

## 在VS Code中构建

1. 使用Qt Online Installer安装`Qt5.15.17`。
2. Vs Code安装插件`Qt C++ Extention Pack`(步骤2-4参照[Qt官方文档](https://doc.qt.io/vscodeext/vscodeext-getting-started.html))。
3. `Ctrl + Shift + P`选择`Register Qt installations`，选择Qt安装目录（如`D:\Qt`）
4. `Ctrl + Shift + P`选择`CMake: Select a Kit`，选择合适的版本（通常是amd64）
