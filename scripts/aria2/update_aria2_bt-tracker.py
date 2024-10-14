import os
import requests

# aria2.conf 文件路径
conf_path = "./aria2.conf"

# 检查当前目录是否存在 aria2.conf 文件
if not os.path.exists(conf_path):
    print("\033[91m当前目录下不存在 aria2.conf 文件,请先从 https://github.com/P3TERX/aria2.conf 下载该文件。\033[0m")
    exit(1)

# 定义 tracker 列表源
sources = [
    {
        "name": "精选列表 (XIU2/TrackersListCollection)",
        "url": "https://cf.trackerslist.com/best_aria2.txt"
    },
    {
        "name": "完整列表 (XIU2/TrackersListCollection)",
        "url": "https://cf.trackerslist.com/all_aria2.txt"
    },
    {
        "name": "HTTP(S) 列表 (XIU2/TrackersListCollection)",
        "url": "https://cf.trackerslist.com/http_aria2.txt"
    },
    {
        "name": "无 HTTP 列表 (XIU2/TrackersListCollection)",
        "url": "https://cf.trackerslist.com/nohttp_aria2.txt"
    },
    {
        "name": "trackers_best (ngosang/trackerslist)",
        "url": "https://cdn.jsdelivr.net/gh/ngosang/trackerslist@master/trackers_best.txt"
    },
    {
        "name": "trackers_all (ngosang/trackerslist)",
        "url": "https://cdn.jsdelivr.net/gh/ngosang/trackerslist@master/trackers_all.txt"
    },
    {
        "name": "trackers_all_udp (ngosang/trackerslist)",
        "url": "https://cdn.jsdelivr.net/gh/ngosang/trackerslist@master/trackers_all_udp.txt"
    },
    {
        "name": "trackers_all_http (ngosang/trackerslist)",
        "url": "https://cdn.jsdelivr.net/gh/ngosang/trackerslist@master/trackers_all_http.txt"
    },
    {
        "name": "trackers_all_https (ngosang/trackerslist)",
        "url": "https://cdn.jsdelivr.net/gh/ngosang/trackerslist@master/trackers_all_https.txt"
    },
    {
        "name": "trackers_all_ws (ngosang/trackerslist)",
        "url": "https://cdn.jsdelivr.net/gh/ngosang/trackerslist@master/trackers_all_ws.txt"
    }
]

# 打印列表供用户选择
print("请选择要更新 bt-tracker 列表的源:")
print("")
for i, source in enumerate(sources):
    print(f"{i}. {source['name']} => {source['url']}")
print("")

while True:
    choice = input(f"请输入编号 [0-{len(sources) - 1}]: ")
    if not choice.isdigit() or int(choice) < 0 or int(choice) >= len(sources):
        print(f"\033[91m无效的输入,请输入 0 到 {len(sources) - 1} 之间的数字。\033[0m")
    else:
        break

# 获取选择的源
selected_source = sources[int(choice)]

# 下载 tracker 列表
response = requests.get(selected_source["url"])
trackers = ",".join(filter(None, response.text.strip().split("\n")))

# 更新 aria2.conf 文件
with open(conf_path, "r", encoding="utf-8") as f:
    content = f.read()

content = content.replace(content[content.index("bt-tracker="):], f"bt-tracker={trackers}\n")

with open(conf_path, "w", encoding="utf-8") as f:
    f.write(content)

print(f"更新 {selected_source['name']} 成功!")
