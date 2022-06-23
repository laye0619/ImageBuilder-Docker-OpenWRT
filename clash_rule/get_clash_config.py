import random
import yaml
import requests

# resp = requests.get(
#     'https://ghproxy.com/https://raw.githubusercontent.com/Hackl0us/SS-Rule-Snippet/main/LAZY_RULES/clash.yaml')
resp = requests.get(
    'https://raw.githubusercontent.com/Hackl0us/SS-Rule-Snippet/main/LAZY_RULES/clash.yaml')
config_content = yaml.safe_load(resp.text)

with open('./clash_rule/my_config_need_to_add_into.yaml', 'r') as f:
    my_config = yaml.safe_load(f)
    f.close()

# 随机生成0-9数字，填充端口号
port_last_number = random.randint(1, 9)
for item in my_config['proxies']:
    item['port'] = int(float(item['port'])/10)*10+port_last_number

config_content['proxies'] = my_config['proxies']
config_content['proxy-groups'] = my_config['proxy-groups']
config_content['rules'] = my_config['rules']+config_content['rules']
config_content.pop('proxy-providers')

with open('./clash_rule/my_clash_config.yaml', 'w') as f:
    f.write(yaml.dump(config_content))
    f.close()
