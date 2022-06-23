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
config_content['proxies'] = my_config['proxies']
config_content['proxy-groups'] = my_config['proxy-groups']
config_content['rules'] = my_config['rules']+config_content['rules']
config_content.pop('proxy-providers')

with open('./clash_rule/my_clash_config.yaml', 'w') as f:
    f.write(yaml.dump(config_content))
    f.close()
