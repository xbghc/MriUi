#include "include/mriuiconfig.h"

QJsonArray MriUiConfig::loadStudyConfig()
{
    // 以后会在配置文件读取路径
    QString path = ":/config/defaultStudies.json";
    return loadJsonArray(path);
}
